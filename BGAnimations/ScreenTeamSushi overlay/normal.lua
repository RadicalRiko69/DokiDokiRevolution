return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("#000000");diffusealpha,1;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
  Def.Sprite{
        Name= "team",
        InitCommand=cmd(Center;zoom,0.56);
        OnCommand= cmd(sleep,4;diffusealpha,0),
        Texture= "sushi.png",
  },
  Def.Sprite{
    Name= "team",
    InitCommand=cmd(Center;addy,150;zoom,0.6;diffusealpha,0;diffusealpha,1;spin;effectmagnitude,0,0,-200;effectperiod,100);
    OnCommand= cmd(sleep,1;sleep,3;diffusealpha,0),
    Texture= "ring.png",
  },
};
