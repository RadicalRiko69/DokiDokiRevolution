return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("#000000");diffusealpha,1;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	LoadActor(THEME:GetPathG("","_BG/you are not safe.png"))..{
		InitCommand=cmd(zoom,0.45;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	};
};
