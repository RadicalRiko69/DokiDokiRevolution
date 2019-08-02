local gc = Var "GameCommand";
local name = gc:GetName():lower();
local index = gc:GetIndex()-1;

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("disc_"..name) .. {
		InitCommand=cmd(y,SCREEN_TOP+35;x,150*index;zoom,0;bounceend,0.35;zoom,0.1);
		GainFocusCommand=cmd(stoptweening;glowshift;decelerate,0.5;zoom,0.35);
		LoseFocusCommand=cmd(stoptweening;stopeffect;decelerate,0.5;zoom,0.2);
	};
};

-- Background!
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_UI/textbox")) .. {
		InitCommand=cmd(addy,200;diffusealpha,0);
		OnCommand=cmd(diffusealpha,1;zoom,0.7);
	};
};


return t