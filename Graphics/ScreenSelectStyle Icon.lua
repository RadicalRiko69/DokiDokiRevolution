local gc = Var("GameCommand");

local string_name = gc:GetText();
local string_expl = THEME:GetString("StyleType", gc:GetStyle():GetStyleType());
local icon_color = color("#b95498");
local icon_color2 = color("#febce0");

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame { 
	GainFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconGainFocusCommand");
	LoseFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconLoseFocusCommand");

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		InitCommand=cmd(diffuse,icon_color;diffusebottomedge,icon_color2);
	};
	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background effect"));
	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_gloss"));
	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_stroke"));
	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_cutout"));

	LoadFont("_riffic free medium 20px")..{
		Text=string.upper(string_name);
		InitCommand=cmd(y,-12;zoom,1;maxwidth,232);
	};
	LoadFont("Common Normal")..{
		Text=(string_expl);
		InitCommand=cmd(y,27.5;zoom,0.6;maxwidth,300);
	};

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		DisabledCommand=cmd(diffuse,color("0,0,0,0.5"));
		EnabledCommand=cmd(diffuse,color("1,1,1,0"));
	};
};
return t