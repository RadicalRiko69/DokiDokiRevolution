local function PlayerInfo(pn)
	local t = Def.ActorFrame {
		
	};
	return t
end;




local function customlifemeterS(pn)
	local t = Def.ActorFrame {
		LoadActor("mask") .. {
			BeginCommand=cmd(x,-270-38;MaskSource);
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};
		LoadActor("SOLIDO SINGLE") .. {
			BeginCommand=cmd(blend,Blend.Add;player,pn;playcommand,"Change";ztest,true);--20
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local hothreshold = 1
				self:cropright(1.0-params.Life);--1
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				if params.Life < dgthreshold then
					self:diffuse(color("#FF0000"));
				elseif params.Life >= hothreshold then
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FFFFFF"));
				end
			end;
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};	

		 --frame
		LoadActor("life bar single") .. {
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local hothreshold = THEME:GetMetric("LifeMeterBar", "HotValue");
				--self:croprigth(1-lfzoom);
				if params.Life >= hothreshold then
					self:visible(true);
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FFFFFF"));
					self:visible(true);	
				 end;
			end;
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;rotationz,2;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};
		LoadActor("tip hot") .. {
			BeginCommand=cmd(player,pn;draworder,5;pulse;effectmagnitude,1.2,1,0;effectclock,"bgm";effecttiming,1,0,0,0;);
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				if params.Life <= dgthreshold then
					self:visible(false);
				else
					self:visible(true);
				end
				local hothreshold = THEME:GetMetric("LifeMeterBar", "HotValue");
				if params.Life >= hothreshold then
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FF80FF"));
				end
				local xpos = params.Life*500;
				if xpos <= 4 then
					xpos = 4
				elseif xpos >= 498 then
					xpos = 498 
				end
				self:x(xpos-250);
				
				--self:glow(1,1,1,1);
				--[[
				self:glow(0,0,0,1);
				self:glowshift();
				self:effectperiod(0.2);
				self:effectcolor1(1,1,1,0);
				self:effectcolor2(1,1,1,1);
				]]
			end;
		};
		LoadActor("tip danger") .. {
			BeginCommand=cmd(player,pn;draworder,5;visible,false);
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				self:glow(0,0,0,1);
				if params.Life <= dgthreshold then
					self:visible(true);
				else
					self:visible(false);
				end
				local death = 0
				if params.Life == death then
					self:decelerate(1):zoom(0):diffusealpha(0);
				else
					self:diffusealpha(1);
				end
				local xpos = params.Life*500;
					if xpos <= 4 then
					xpos = 4
					elseif xpos >= 498 then
					xpos = 498 end
						self:x(xpos-250);
						self:glowshift();
						self:effectperiod(0.1);
						self:effectcolor1(1,1,1,0);
						self:effectcolor2(1,1,1,1);
			end;
		};
	};
	
	local playerFailed = false;

	t[#t+1] = LoadActor(THEME:GetPathS("","FAIL"))..{
		["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
			if params.Life == 0 and not playerFailed then
				MESSAGEMAN:Broadcast('Kill'..pname(pn));
				playerFailed = true
			end;
		end;
		["Kill"..pname(pn).."MessageCommand"]=cmd(play);
	};
	
	
	t[#t+1] = LoadActor("failed")..{
		InitCommand=cmd(zoom,0.8;diffusealpha,0;draworder,300);
		OnCommand=function(self)
			if pn == PLAYER_2 then
				self:rotationy(-180);
			end;
		end;
		["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,30,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
		SlowCommand=cmd(bounce;effectmagnitude,10,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
		SlowerCommand=cmd(bounce;effectmagnitude,5,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
		StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
	};

	return t
end;


--###############################################################################################################################################################

local function customlifemeterD(pn)
	local t = Def.ActorFrame {
		LoadActor("mask") .. {
			BeginCommand=cmd(x,-519-42;zoomx,1.2;MaskSource;);
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};	
		LoadActor("SOLIDO DOUBLE") .. {
			BeginCommand=cmd(player,pn;blend,Blend.Add;playcommand,"Change";x,-8;ztest,true);--20
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local hothreshold = 1
				self:cropright(1.0-params.Life);--1
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				if params.Life < dgthreshold then
					self:diffuse(color("#FF0000"));
				elseif params.Life >= hothreshold then
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FFFFFF"));
				end
			end;
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};
		--frame
		LoadActor("life bar double") .. {
			DeadCommand=cmd(diffuseshift;effectcolor1,color("#fc6200");effectcolor2,color("#6b0000");effectperiod,0.05);
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local hothreshold = THEME:GetMetric("LifeMeterBar", "HotValue");
				--self:croprigth(1-lfzoom);
				if params.Life >= hothreshold then
					self:visible(true);
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FFFFFF"));
					self:visible(true);	
				 end;
			end;
			["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,0,5,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
			SlowCommand=cmd(bounce;effectmagnitude,0,3,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
			SlowerCommand=cmd(bounce;effectmagnitude,0,1,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
			StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
		};

		LoadActor("tip hot") .. {
			BeginCommand=cmd(player,pn;draworder,5;playcommand,"Xposition";pulse;effectmagnitude,1.2,1,0;effectclock,"bgm";effecttiming,1,0,0,0;);
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local life = params.Life;
				local hothreshold = 1
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				if life <= dgthreshold then
					self:visible(false);
				else
					self:visible(true);
				end
				if params.Life >= hothreshold then
					self:diffuse(color("#00FFFF"));
				else
					self:diffuse(color("#FF80FF"));
				end
				local xpos = life*1000;
					if xpos <= 4 then
					xpos = 4
					elseif xpos >= 994 then
					xpos = 994 end
						self:x(xpos-500);
			end;
		};
		LoadActor("tip danger") .. {
			BeginCommand=cmd(player,pn;draworder,5;visible,false);
			["LifeMeterChanged"..pname(pn).."MessageCommand"]=function(self,params)
				local life = params.Life
				local dgthreshold = THEME:GetMetric("LifeMeterBar", "DangerThreshold");
				self:glow(0,0,0,1);
				if life <= dgthreshold then
					self:visible(true);
				else
					self:visible(false);
				end
				local death = 0
				if params.Life == death then
					self:decelerate(1):zoom(0):diffusealpha(0);
				else
					self:diffusealpha(1);
				end
				local xpos = life*1000;
					if xpos <= 4 then
					xpos = 4
					elseif xpos >= 994 then
					xpos = 994 end
						self:x(xpos-500);
						self:glowshift();
						self:effectperiod(0.1);
						self:effectcolor1(1,1,1,0);
						self:effectcolor2(1,1,1,1);
			end;
		};
		
	};

	t[#t+1] = LoadActor("failed")..{
		InitCommand=cmd(zoom,0.8;diffusealpha,0;draworder,300);
		OnCommand=function(self)
			if pn == PLAYER_2 then
				self:rotationy(-180);
			end;
		end;
		["Kill"..pname(pn).."MessageCommand"]=cmd(linear,0.05;diffusealpha,1;bounce;effectmagnitude,30,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slow");  
		SlowCommand=cmd(bounce;effectmagnitude,10,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Slower");
		SlowerCommand=cmd(bounce;effectmagnitude,5,0,0;effectperiod,0.05;sleep,0.25;queuecommand,"Stop");
		StopCommand=cmd(bounce;effectmagnitude,0,0,0;effectperiod,0.05);
	};
	return t
end;

--###############################################################################################################################################################



local t = Def.ActorFrame {

	customlifemeterS(PLAYER_1) .. {
		InitCommand=cmd(y,SCREEN_TOP+18;zoomy,0.8*0.66;zoomx,(340/384)*0.85*0.66;playcommand,"On";);
		OnCommand=function(self)
		local style=GAMESTATE:GetCurrentStyle();
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:visible(false);
				elseif style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
					self:visible(false);
				else
					self:visible(true);
				end
			else
				self:visible(false);
			end
			self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX"));
		end;
	};

	customlifemeterS(PLAYER_2) .. {
		InitCommand=cmd(y,SCREEN_TOP+18;zoomy,0.8*0.66;zoomx,(340/384)*0.85*0.66;rotationy,180;playcommand,"On";);
		OnCommand=function(self)
		local style=GAMESTATE:GetCurrentStyle();
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:visible(false);
				elseif style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
					self:visible(false);
				else
					self:visible(true);
				end
			else
				self:visible(false);
			end
			self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX"));
		end;
	};

	customlifemeterD(GAMESTATE:GetMasterPlayerNumber()) .. {
		Condition=(GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides");
		InitCommand=cmd(y,SCREEN_TOP+18;x,SCREEN_CENTER_X;zoomy,0.8*0.66;zoomx,(320/384)*0.85*0.71;); --playcommand,"On";
	};

-------------------------------------P1 SCORE gato
 --[[LoadFont("_arial Bold 20px") .. {
	InitCommand=cmd(horizalign,right;y,SCREEN_TOP+19;zoom,0.62;uppercase,true;shadowlength,1;visible,GAMESTATE:IsHumanPlayer(PLAYER_1);playcommand,"Set");
	ComboChangedMessageCommand=function(self)
		local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1);
		self:settext(scorecap(PSS:GetScore()));
	end;
	
	SetCommand=function(self)
		local style = GAMESTATE:GetCurrentStyle();
		
		
		if GetUserPref("UserPrefScorePosition") == "On" then 
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:x(SCREEN_RIGHT-83);
				else
					self:x(THEME:GetMetric("ScreenGameplay","PlayerP1OnePlayerOneSideX")+119);
				end
		end
		
		if GetUserPref("UserPrefScorePosition") == "Off" then 
				self:y(SCREEN_BOTTOM+9999);
		end
		
		if style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
			if GetUserPref("UserPrefScorePosition") == "On" then
				self:x(SCREEN_CENTER_X-25);
				self:visible(GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P1")
				self:horizalign(right);
			else
				self:x(SCREEN_CENTER_X);
				self:visible(GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P1")
				self:horizalign(center);
			end
		end
		
		
	end
};
	
-----------------------------------P2 SCORE perro
LoadFont("_arial Bold 20px") .. {
	InitCommand=cmd(horizalign,left;y,SCREEN_TOP+19;zoom,0.62;uppercase,true;shadowlength,1;visible,GAMESTATE:IsHumanPlayer(PLAYER_2);playcommand,"Set");	
	ComboChangedMessageCommand=function(self)
		
		local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2);
		self:settext(scorecap(PSS:GetScore()));
	end;
	
	SetCommand=function(self)
		local style = GAMESTATE:GetCurrentStyle();
		
		
		if GetUserPref("UserPrefScorePosition") == "On" then 
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:x(SCREEN_LEFT+83);
				else
					self:x(THEME:GetMetric("ScreenGameplay","PlayerP2OnePlayerOneSideX")-119);
				end
		end
		
		
		if GetUserPref("UserPrefScorePosition") == "Off" then 
				self:y(SCREEN_BOTTOM+9999);
		end
		
		
		if style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
			if GetUserPref("UserPrefScorePosition") == "On" then
				self:x(SCREEN_CENTER_X-25);
				self:visible(GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P2")
				self:horizalign(right);
			else
				self:x(SCREEN_CENTER_X);
				self:visible(GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P2")
				self:horizalign(center);
			end
		end
					
	end
};--]]

	PlayerInfo(PLAYER_1)..{
		InitCommand=cmd(y,SCREEN_TOP+495;zoomy,0.8;draworder,9999;zoomx,0.95;playcommand,"On";);
		OnCommand=function(self)
		local style=GAMESTATE:GetCurrentStyle();
			if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:visible(true);
					self:x(SCREEN_CENTER_X-220);
				elseif style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
					if GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P1" then
						self:visible(true);
						self:x(SCREEN_CENTER_X-220);
					else
						self:visible(false);
					end
				else
					self:visible(true);
				--[[	self:x(SCREEN_CENTER_X*0.53125);]]--
				if SCREEN_CENTER_X == 320 then
					self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX")-15);
				else
					self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX"));
				end
				end
			else
				self:visible(false);
			end
		end;
	};
	PlayerInfo(PLAYER_2)..{
		InitCommand=cmd(y,SCREEN_TOP+495;zoomy,0.8;draworder,9999;zoomx,0.95;playcommand,"On";);
		OnCommand=function(self)
		local style=GAMESTATE:GetCurrentStyle();
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				if style:GetStyleType() == "StyleType_OnePlayerTwoSides" then
					self:visible(true);
					self:x(SCREEN_CENTER_X+220);
				elseif style:GetStyleType() == "StyleType_TwoPlayersSharedSides" then
					if GAMESTATE:GetMasterPlayerNumber() == "PlayerNumber_P2" then
						self:visible(true);
						self:x(SCREEN_CENTER_X+220);
					else
						self:visible(false);
					end
				else
					self:visible(true);
					--[[self:x(SCREEN_CENTER_X*1.46875);]]--
				if SCREEN_CENTER_X == 320 then
					self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX")+15);
				else
					self:x(THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX"));
				end
				end
			else
				self:visible(false);
			end
		end;
	};


	
	--LoadActor("song meter");

};

for n=1,2 do 

t[#t+1] = LoadActor("sushi")..{
	InitCommand=cmd(Center;zoom,0.5);
	OnCommand=cmd(visible,GAMESTATE:GetCoinMode() == "CoinMode_Pay";queuecommand,"Zoom");
	ZoomCommand=cmd(decelerate,0.05;zoom,1;decelerate,0.05;zoom,0.75;queuecommand,"Zoom");
};

t[#t+1] = LoadActor("bitch")..{
	InitCommand=cmd(Center;zoom,0.5);
	OnCommand=cmd(visible,GAMESTATE:GetCoinMode() == "CoinMode_Pay");
};

-- if you use paymode
if (GAMESTATE:GetCoinMode() == "CoinMode_Pay") then
	t[#t+1] = LoadActor("earrape (loop)")..{
		OnCommand=cmd(queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
		OffCommand=cmd(stop);
	};	--Music
end

end

return t;



