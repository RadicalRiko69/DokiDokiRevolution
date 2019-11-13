return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_BG/warning"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45);
	};

	LoadActor(THEME:GetPathG("","_BG/wallpaper"))..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45;sleep,5;decelerate,2;diffusealpha,1);
	};

	LoadActor(THEME:GetPathG("","TextBox/background"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffuse,color("#fe80e0"));
		OnCommand=cmd(zoom,0.7;sleep,5;linear,0.5;diffusealpha,0);
	};

	LoadActor(THEME:GetPathG("","TextBox/frame"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(zoom,0.7;sleep,5;linear,0.5;diffusealpha,0);
	};

	LoadFont("_aller 20px") .. {
		Text="This is a DDLC fan game that is not affiliated with\nTeam Salvato. The original game must be completed\nbefore playing. You can download Doki Doki\nLiterature Club at: http://ddlc.moe";
		InitCommand=cmd(horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160);
		OnCommand=cmd(sleep,5;linear,0.5;diffusealpha,0);
	};

};
