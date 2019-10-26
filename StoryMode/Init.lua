local texttable2 = {
	"It’s a beautiful day outside, birds are singing, flowers are blooming. On days like these, I just want to listen to some good music with my best friend Sayori.",
	"/mc[LeftSide,4]/mc[SE,Arc_S0AA001]Although, cherry blossoms during the summer is too much. Wouldn't you agree, Mister?",
	"/mc[RightSide,0]/mc[SE,Arc_S0AA002]/mc[Appear]/dim[0]Yes...... monsters and cherry blossoms.\nBut tell me, who is the real monster here?",
	"/mc[SE,Arc_S0AA003]You, or I? The devil in the form of a beautiful woman,\nor the human with the looks of an unrelenting monster?",
	"/mc[SE,Arc_S0AA004]Then again, to everyone else, well―――\nI suppose one could call me a demon after all.",
	"/mc[LeftSide,8]/mc[SE,Arc_S0AA005]/dim[1]We're not so different on the inside, so what does it matter? Though―――you look more like the shadow of a monster.",
	"/mc[SE,Arc_S0AA006]/dim[0]As I thought.\nEverything's hazy, as if I were dreaming.",
	"/mc[SE,Arc_S0AA007]Meeting you must be the work of fate. Could you help me feel alive again?",
	"/mc[LeftSide,4]/mc[SE,Arc_S0AA008]/dim[1]Sure thing. But since you inturrupted my flower viewing, don't expect me to go easy on you.",
	"/mc[SE,Arc_S0AA009]/dim[0]I'd like nothing less. If my body can't awaken from this battle, it'd be best if I disappeared entirely from this world.",
	"/mc[SE,Arc_S0AA010]Against a foe like you, I may experience not the feeling of life, but of death."
}
	
local pos = 1;

local vntext = LoadVNText2();
local f;

local function inputs(event)
	--Check if player clicked screen, then skip to next screen if they did.
	local pn= event.PlayerNumber
	local button = event.button
	-- If the PlayerNumber isn't set, the button isn't mapped.  Ignore it.
	-- ...Unless it's the mouse.
	if not pn and event.DeviceInput.is_mouse == false then return end
	if event.DeviceInput.is_mouse then
		button = ToEnumShortString(event.DeviceInput.button)
	end
	-- If it's a release, ignore it.
	if event.type == "InputEventType_Release" then return end
	
	if button == "left mouse button" or button == "Start" then
		if not vntext:is_finished() then
			vntext:skip();
			--sleep(1);
		else
			if vntext:no_more_text() then
				--SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
			else
				pos = pos + 1;
				vntext:advance()
			end;
		end;
	else
		--tostring(vntext:no_more_text())
		--SCREENMAN:SystemMessage(button);
	end;
end;


local TEXTBOX_HEIGHT = 150;
local t = Def.ActorFrame{

	InitCommand=function(self)
		--Set the enemy character for the next song.
		--MBSTATE:SetEnemyCharacter("KishimaKouma");
		--Set random encounters for the rest of arcade mode.
		--MBSTATE:SetRandomEncounterList({"Satsuki","Len","Hisui","Kohaku","Aozaki","AkihaVermillion"});
	end;

	OnCommand=function(self)
		--Add input handler
		SCREENMAN:GetTopScreen():AddInputCallback(inputs);
		--Make this ActorFrame accessible throughout the file
		f = self;
	end;

	LoadActor("night path2")..{
		InitCommand=cmd(Cover;diffusealpha,.6)
	};
	
	Def.Sprite{
		Name="LeftSide";
		InitCommand=cmd(vertalign,bottom;xy,SCREEN_CENTER_X/2,SCREEN_BOTTOM;zoom,1.5);
		LeftSideMessageCommand=function(self,param)
			self:Load(GetPathVN("notexture (doubleres).png"));
		end;
		VNDimMessageCommand=function(self,param)
			if param[1] == '0' then
				self:VN_Dim()
			else
				self:VN_Undim()
			end
		end;
	};
	
	Def.Sprite{
		Name="RightSide";
		InitCommand=cmd(rotationy,180;vertalign,bottom;xy,SCREEN_WIDTH*.75,SCREEN_BOTTOM;zoom,1.5);
		RightSideMessageCommand=function(self,param)
			--SCREENMAN:SystemMessage(GetPathVN("notexture (doublres).png"));
			self:Load(GetPathVN("notexture (doubleres).png"));
		end;
		VNDimMessageCommand=function(self,param)
			if param[1] == '1' then
				self:VN_Dim()
			else
				self:VN_Undim()
			end
		end;
		
	};
	--[[Def.Quad{
		InitCommand=cmd(setsize,400,3;fadeleft,.5;faderight,.5;xy,SCREEN_CENTER_X/2+50,SCREEN_HEIGHT*.95+5;diffuse,Color("White"));
	};
	Def.Quad{
		InitCommand=cmd(zoomx,0;setsize,400,3;fadeleft,.5;faderight,.5;xy,SCREEN_WIDTH*.75-50,SCREEN_HEIGHT*.95+5;diffuse,Color("White"));
		AppearMessageCommand=cmd(decelerate,.6;zoomx,1);
	};]]
	--[[LoadFont("Dialogue Character Names")..{
		Name="LeftName";
		Text="NoName (Left)";
		InitCommand=cmd(xy,SCREEN_CENTER_X/2+50,SCREEN_BOTTOM-100-150/2;addx,100;halign,0.2;vertalign,bottom;shadowcolor,Color("Black");diffusebottomedge,Color("Red");shadowlength,1;diffusealpha,0);
		OnCommand=cmd(decelerate,.6;addx,-120;diffusealpha,1);
	};
	
	LoadFont("Dialogue Character Names")..{
		Name="RightName";
		Text="NoName (Right)";
		InitCommand=cmd(xy,SCREEN_WIDTH*.75-50,SCREEN_HEIGHT*.95;addx,-100;halign,0.8;vertalign,bottom;shadowcolor,Color("Black");diffusebottomedge,Color("Red");shadowlength,1;diffusealpha,0);
		AppearMessageCommand=cmd(decelerate,.6;addx,120;diffusealpha,1);
	};]]
};

t[#t+1] = Def.ActorFrame{

	genTextBackground(130)..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_BOTTOM-95;vertalign,top;)
	};
	--Make vntext here
	--function(font, text, maxwidth, spd, clr)
	vntext:make_actor("Dialogue Text", texttable2, 640*.8, 15, Color("White"))..{
		InitCommand=cmd(xy,150,SCREEN_BOTTOM-140);
	};
	
	--[[LoadActor(THEME:GetPathS("","73 (loop)"))..{
		OnCommand=cmd(play);
	};]]
	
	Def.Sound{
		Name="Voice";
		SEMessageCommand=function(self,param)
			--If we use THEME:GetPathS() StepMania will complain that the sound is missing. We want it to work even without any sound effects.
			local snd = "/"..THEME:GetCurrentThemeDirectory().."/Sounds/story_se/"..param[1]..".ogg";
			if FILEMAN:DoesFileExist(snd) then
				self:load(snd);
				self:play();
			end;
		end;
	};
};

return t;
