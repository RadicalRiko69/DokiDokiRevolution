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
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"This game is not suitable for children\nor those who are easily disturbed.",
	"Sushi Violation died for this.",
	"All of the dokis are yummy.",
	"Dan Salvato please notice me again!",
	"owo it's a Mithost",
	"This is not a mod, it doesn't use Ren'py...",
	"Welcome to the Dance Game Gurlz Club!",
	"Just Monika.",
	"Yummy Natsuki.",
	"Follow @UsagiSii on Twitter, her art is yummy!",
	"Presenting the only DDLC fangame that has 4:3 support!",

};

return Def.ActorFrame{
	--Fade out
	OnCommand=function(self)
		self:sleep(3);
		self:accelerate(0.5);
		self:diffusealpha(0);
		SCREENMAN:GetTopScreen():AddInputCallback(inputs);
	end;
	
	LoadFont("_aller thin 20px")..{
        Text=phrases[math.random(#phrases)];
        InitCommand=cmd(Center;diffusealpha,0;wrapwidthpixels,SCREEN_WIDTH;zoom,.75;diffuse,color("#000000"));
		OnCommand=cmd(sleep,3;accelerate,0.5;diffusealpha,1);
    };
	
	--Don't do this, use PlayMusic metric setting!!
	--[[LoadActor(THEME:GetPathS("ScreenTitleMenu", "music"))..{
		OnCommand=cmd(play);
	};]]
};
