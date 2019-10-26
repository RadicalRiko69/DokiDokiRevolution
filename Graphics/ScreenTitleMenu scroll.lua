local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_riffic free medium 20px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		OnCommand=cmd(horizalign,left);
		GainFocusCommand=cmd(stoptweening;zoom,1;diffuse,color("fde3f2"));
		LoseFocusCommand=cmd(stoptweening;zoom,0.9;diffuse,color("ffffff"));
	};
};