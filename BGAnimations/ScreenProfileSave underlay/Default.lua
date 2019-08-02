return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_UI/textbox"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(zoom,0.7;sleep,5;linear,0.5;diffusealpha,0);
	};
}