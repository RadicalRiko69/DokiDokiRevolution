return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_BG/poem"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.68);
		--OffCommand=cmd(linear,2;diffusealpha,0);
	};

};
