local t = Def.ActorFrame {};
	

t[#t+1] = Def.ActorFrame {
  FOV=90;
	
LoadActor(THEME:GetPathG("","_BG/white"))..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	OnCommand=cmd(zoom,0.68;sleep,3;accelerate,0.5;diffusealpha,0);
};

--characters
Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_character_title/natsuki")) .. {
		InitCommand=cmd(zoom,0.48;x,SCREEN_RIGHT+310;y,SCREEN_BOTTOM-180;draworder,300);
		OnCommand=cmd(sleep,4;decelerate,2;x,SCREEN_RIGHT-206);
	};
};
Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_character_title/yuri")) .. {
		InitCommand=cmd(zoom,0.44;x,SCREEN_RIGHT+300;y,SCREEN_BOTTOM-220;draworder,300);
		OnCommand=cmd(sleep,4;decelerate,2;x,SCREEN_RIGHT-286);
	};
};
Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_character_title/monika")) .. {
		InitCommand=cmd(zoom,0.5;x,SCREEN_RIGHT+310;y,SCREEN_BOTTOM-100;draworder,300);
		OnCommand=cmd(sleep,4;decelerate,2;x,SCREEN_RIGHT-100;);
	};
};
Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_character_title/sayori")) .. {
		InitCommand=cmd(zoom,0.5;x,SCREEN_RIGHT+310;y,SCREEN_BOTTOM-100;draworder,300);
		OnCommand=cmd(sleep,4;decelerate,2;x,SCREEN_RIGHT-330;);
	};
};
LoadActor(THEME:GetPathG("","_BG/white"))..{ --lazy hack
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0);
	OnCommand=cmd(zoom,0.68;sleep,4.8;diffusealpha,1;sleep,0.05;linear,1;diffusealpha,0);
};
--front stuff
Def.ActorFrame {
	LoadActor("hub") .. {
		InitCommand=cmd(zoom,0.45;x,SCREEN_LEFT-110;y,SCREEN_CENTER_Y;draworder,300);
		OnCommand=cmd(sleep,4;decelerate,0.8;x,SCREEN_LEFT+110;);
	};
};
Def.ActorFrame {
	LoadActor("logo") .. {
		InitCommand=cmd(zoom,0.2;x,SCREEN_LEFT+160;y,SCREEN_TOP-200);
		OnCommand=cmd(sleep,4.5;linear,0.25;y,SCREEN_TOP+90;linear,0.5;addy,-50;sleep,0.25;accelerate,0.5;addy,50);
		};
	LoadActor("sparklies") .. {
		InitCommand=cmd(zoom,0;x,SCREEN_LEFT+160;y,SCREEN_TOP+180);
		OnCommand=cmd(sleep,4.6;accelerate,0.25;zoom,0.8;accelerate,0.5;diffusealpha,0;addy,50);
		};	
	};	
};

return t;
