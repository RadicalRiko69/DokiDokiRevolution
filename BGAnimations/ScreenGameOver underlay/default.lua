return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","TextBox/background"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffuse,color("#fe80e0"));
			OnCommand=cmd(zoom,0.7);
	};

	LoadActor(THEME:GetPathG("","TextBox/frame"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
			OnCommand=cmd(zoom,0.7);
	};

	LoadFont("_aller 20px") .. {
		Text="Game Over";
		InitCommand=cmd(x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+130;zoom,0.8;skewx,-0.3;horizalign,left);
	};

};
