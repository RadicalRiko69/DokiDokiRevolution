return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_BG/notebook"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45);
	};

};
