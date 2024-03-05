return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("#000000");diffusealpha,1;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
  Def.Sprite{
        Name= "team",
        InitCommand=cmd(Center;zoom,0.56);
        OnCommand= cmd(sleep,4;diffusealpha,0),
        Texture= THEME:GetPathB("","ScreenTeamSushi overlay/sushi.png"),
  },
	Def.Quad {
		InitCommand=cmd(diffuse,color("#FFFFFF");diffusealpha,0;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;hibernate,6;diffusealpha,1);
	},
};
