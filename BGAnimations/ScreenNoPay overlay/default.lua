local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Start" then
            SCREENMAN:SetNewScreen("ScreenTeamSushi");
			PREFSMAN:SetPreference("CoinMode","Home");
        end
    end

    return false
end

GAMESTATE:UnjoinPlayer(PLAYER_1)

return Def.ActorFrame {
	OnCommand=function(s) s:queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input)
    end,
	BeginCommand=cmd(sleep,185;queuecommand,"End");
	EndCommand=function(s)
		SCREENMAN:SetNewScreen("ScreenExit");
	end,
	LoadActor(THEME:GetPathB("","ScreenTitleMenu underlay"))..{
		InitCommand=cmd(sleep,9;diffusealpha,0);
	};
	LoadActor(THEME:GetPathB("","ScreenTitleMenu overlay"))..{
		InitCommand=cmd(sleep,3;accelerate,0.5;diffusealpha,0);
	};
	LoadActor("glitch")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0.7;sleep,8.95;diffusealpha,1;vibrate;effectmagnitude,0,300,0;sleep,1.5;queuecommand,"Stop");
		StopCommand=cmd(bob;effectmagnitude,2,4,8;effectperiod,2);
	};
	LoadActor("glitch")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0.7;sleep,10.45;diffusealpha,0.4;bob;effectmagnitude,-4,-8,-16;effectperiod,1);
	};
	LoadActor("glitch")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0.7;sleep,10.45;diffusealpha,0.4;bob;effectmagnitude,6,6,6;effectperiod,6);
	};
	LoadActor("death")..{
		InitCommand=cmd(Center;diffusealpha,0;zoom,0.5;sleep,8.95;diffusealpha,1;vibrate;effectmagnitude,200,0,0;sleep,1.5;queuecommand,"Stop");
		StopCommand=cmd(zoom,1.25;addy,380;bob;effectmagnitude,1,2,3;effectperiod,3);
		OnCommand=function(self)
			if ThemePrefs.Get("Severity") == "Normal" then
				self:visible(false);
			else
				self:visible(true);
			end
		end,
	};
	LoadActor("death")..{
		InitCommand=cmd(Center;addy,380;diffusealpha,0;zoom,1.25;sleep,10.45;diffusealpha,0.4;bob;effectmagnitude,-2,4,-6;effectperiod,2);
		OnCommand=function(self)
			if ThemePrefs.Get("Severity") == "Normal" then
				self:visible(false);
			else
				self:visible(true);
			end
		end,
	};
	LoadActor("death")..{
		InitCommand=cmd(Center;addy,380;diffusealpha,0;zoom,1.25;sleep,10.45;diffusealpha,0.2;bob;effectmagnitude,2,-4,6;effectperiod,2);
		OnCommand=function(self)
			if ThemePrefs.Get("Severity") == "Normal" then
				self:visible(false);
			else
				self:visible(true);
			end
		end,
	};
	Def.Sprite{
		Texture="static 2x1.png";
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffusealpha,0;sleep,8.95;diffusealpha,0.5;sleep,1.5;diffusealpha,0);
	};
	Def.Sprite{
		Texture="static 2x1.png";
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffusealpha,0;sleep,10.45;diffusealpha,0.2;blend,Blend.Multiply);
	};
	Def.Quad{
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffuse,Color("Black");diffusealpha,0;sleep,170;linear,2;diffusealpha,1);
	};
	LoadActor(THEME:GetPathG("","TextBox/background"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffusealpha,0;zoom,0.7;sleep,12;linear,1;diffuse,color("#fe80e0");diffusealpha,1);
	};
	LoadActor(THEME:GetPathG("","TextBox/frame"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffusealpha,0;zoom,0.7;sleep,12;linear,1;diffusealpha,1);
	};
	LoadActor(THEME:GetPathS("","why"))..{
		InitCommand=cmd(sleep,180;queuecommand,"Play");
		PlayCommand=cmd(play)
	};
	LoadActor(THEME:GetPathG("","end"))..{
		InitCommand=cmd(diffusealpha,0;zoom,0.14;Center;sleep,180;linear,1;diffusealpha,1;sleep,3;linear,1;diffusealpha,0);
	};
	LoadFont("_courier new 40px") .. {
		OnCommand=function(self)
			self:settext("Coin Mode/Arcade use is prohibited on this theme. Please review the GitHub page again to get a better understanding of this project and what it can be used for. If you actually took the time to read the page and agree to the waiver, this wouldn't have happened!");
		end;
		InitCommand=cmd(x,SCREEN_CENTER_X-213;y,SCREEN_CENTER_Y+130;zoom,0.34;halign,0;valign,0;horizalign,left;wrapwidthpixels,1350;strokecolor,Color("Black");faderight,1;sleep,12;linear,1;diffusealpha,1;linear,5;faderight,0);
	};
	LoadFont("_aller thin 20px") .. {
		Text="                                                                                          Settings";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+190;diffusealpha,0;zoom,0.4;addy,20;sleep,12;linear,1;diffusealpha,1;diffuse,color("#1e1414"));
	};
	LoadFont("_aller thin 20px") .. {
		Text="History         Skip        Auto        Save        Load                       ";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+190;diffusealpha,0;zoom,0.4;addy,20;sleep,12;linear,1;diffusealpha,1;diffuse,color("#986d6d"));
	};
	LoadActor(THEME:GetPathG("","_StepsDisplayListRow arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+210;y,SCREEN_CENTER_Y+212;diffusealpha,0;sleep,12;linear,1;diffusealpha,1);
	};
};

