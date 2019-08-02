return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_UI/textbox"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(zoom,0.7);
	};

	LoadFont("_aller 20px") .. {
		Text="Game Over";
		InitCommand=cmd(zoom,0.8;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
	};

};
