--[[
If you're trying to figure out how to do button inputs, don't use this.
this function uses DeviceInput because I need /mouse/ input, you normally
don't need that.
]]
local function inputs(event)
	--Check if player clicked screen, then skip to next screen if they did.
	local button = ToEnumShortString(event.DeviceInput.button)
	if button == "left mouse button" then
		--SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
	end
end;

local phrases = {
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily dismembered.",
	"Sushi Violation died for this once.",
	"Play Sushi Violation, you won't regret it.",
	"We're so back! LFG!!!!!!!!!!!!!!",
	"It's been a while, huh?",
	"Dan Salvato please notice me again!",
	"owo it's a Mithost",
	"Neither Team Salvato or Serenity Forge is not associated with this project.\nDO NOT add official assets in the theme!!!",
	"This is not a mod, it doesn't use\nthe original DDLC or DDLC Plus engine.",
	"Welcome to the Rhythm Club!",
	"Just Monika.",
	"I lost sleep because of this game.",
	"Shoutouts to r/DDLC and r/DDLCMods!",
	"Rest In Peace Sushi\n4/18/2010 - 6/7/2023",
	"Follow @UsagiSii on X, her art is amazing and cute!",
	"Presenting the only DDLC fangame that has 4:3 support!\nYeah we still have it lmaooooooooooo",
	"Swooshi moment!!!!!!",
};

return Def.ActorFrame{
	--Fade out
	OnCommand=function(self)
		self:sleep(3.25);
		self:accelerate(0.5);
		self:diffusealpha(0);
		SCREENMAN:GetTopScreen():AddInputCallback(inputs);
	end;
	--Sometimes I get this screen while debugging and it makes me really uncomfortable.
	BeginCommand=function(s)
		if math.random(1,64) == 20 and ThemePrefs.Get("Severity") == "Intense" then
			SOUND:StopMusic();
			s:queuecommand("Kill");
		end
	end,
	KillCommand=function(s)
			SCREENMAN:SetNewScreen("ScreenEnd");
	end,
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(Color("White"))
		end
	},
	LoadFont("_aller thin 20px")..{
        InitCommand=cmd(Center;diffusealpha,0;wrapwidthpixels,SCREEN_WIDTH;zoom,.75);
		OnCommand=function(self)
			self:accelerate(0.5):diffusealpha(1):diffuse(Color("Black")):settext(phrases[math.random(#phrases)]);
		end
    };
	LoadActor(THEME:GetPathS("","music (loop)"))..{
        OnCommand=function(s)
			if (GAMESTATE:GetCoinMode() == "CoinMode_Pay") then
				s:stop()
			else
				s:sleep(0.25):queuecommand("Play");
			end
		end,
		PlayCommand=cmd(play);
		OffCommand=cmd(stop);
    };
	CodeMessageCommand=function(self, params)
		if params.Name == "ActivateGhosts" then
			SCREENMAN:SetNewScreen("ScreenEnd");
		elseif params.Name == "DebugMenu" then
			SCREENMAN:SetNewScreen("ScreenOptionsTheme");
		end
	end;
};
