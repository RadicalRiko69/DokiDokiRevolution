return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","TextBox/background"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffuse,color("#fe80e0"));
			OnCommand=cmd(zoom,0.7;sleep,3;linear,0.5;diffusealpha,0);

	};
		LoadActor(THEME:GetPathG("","TextBox/frame"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
			OnCommand=cmd(zoom,0.7;sleep,3;linear,0.5;diffusealpha,0);

	};
}