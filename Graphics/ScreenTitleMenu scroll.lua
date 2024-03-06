local gc = Var("GameCommand");
local index = gc:GetIndex()+1;

return Def.ActorFrame {
	LoadFont("_riffic free medium 40px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		OnCommand=cmd(horizalign,left;addx,-100;zoom,0.4;diffusealpha,0;sleep,5.3+index*.1;decelerate,.2;addx,100;diffusealpha,1);
		GainFocusCommand=cmd(finishtweening;strokecolor,color("#fe81ae"));
		LoseFocusCommand=cmd(finishtweening;strokecolor,color("#7c2b48"));
	};
};
