local gc = Var("GameCommand");
local index = gc:GetIndex()+1;

return Def.ActorFrame {
	LoadFont("_riffic free medium 20px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		OnCommand=cmd(horizalign,left;addx,-100;diffusealpha,0;sleep,5.3+index*.1;decelerate,.2;addx,100;diffusealpha,1);
		GainFocusCommand=cmd(stoptweening;linear,.1;zoom,1;diffuse,color("fde3f2"));
		LoseFocusCommand=cmd(stoptweening;linear,.1;zoom,0.9;diffuse,color("ffffff"));
	};
};
