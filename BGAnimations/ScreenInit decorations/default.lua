return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_BG/warning"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45);
	};

	LoadActor(THEME:GetPathG("","_BG/wallpaper"))..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45;sleep,5;decelerate,2;diffusealpha,1);
	};

	LoadActor(THEME:GetPathG("","_UI/textbox"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(zoom,0.7;sleep,5;linear,0.5;diffusealpha,0);
	};

	LoadFont("_aller 20px") .. {
		Text="This is a Doki Doki Literature Club fan game that is not affiliated with Team Salvato.\nIt is designed to be played only after the official game has been completed.\nYou can download Doki Doki Literature Club at: http://ddlc.moe";
		InitCommand=cmd(zoom,0.7;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(sleep,5;linear,0.5;diffusealpha,0);
	};

};
