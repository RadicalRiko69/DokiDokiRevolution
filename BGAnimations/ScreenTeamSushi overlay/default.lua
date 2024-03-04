return Def.ActorFrame {
  Def.Sprite{
        Name= "team",
        InitCommand=cmd(Center;zoom,0.6);
        OnCommand= cmd(sleep,4;diffusealpha,0),
        Texture= "sushi.png",
      },
};
