return Def.ActorFrame{

	LoadActor(THEME:GetPathG("","_BG/white"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.68);
	};

	LoadFont("_aller thin 20px") .. {
		Text="Please be courteous of neighbors when\nusing the dance mat controller.";
		InitCommand=cmd(zoom,1;diffuse,Color("Black");x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	};

	LoadActor(THEME:GetPathG("","_BG/white"))..{ --lazy hack
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.68;sleep,2;accelerate,0.5;diffusealpha,0);
	};

	LoadActor(THEME:GetPathG("","_BG/splash"))..{
		InitCommand=cmd(diffusealpha,1;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.68;sleep,1;accelerate,1;diffusealpha,0);
	};

};
