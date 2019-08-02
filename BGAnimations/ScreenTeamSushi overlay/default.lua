return Def.ActorFrame {
  Def.Sprite{
        Name= "team",
        InitCommand=cmd(zoom,0.6);
        OnCommand= cmd(zoom,0.25;x,SCREEN_CENTER_X-30;y,SCREEN_CENTER_Y-400;sleep,1;linear,0.1;addy,370;sleep,0.05;addy,-1;sleep,0.05;addy,1;sleep,2;linear,0.5;diffusealpha,0),
        Texture= "team.png",
      },
  Def.Sprite{
        Name= "sushi",
        OnCommand= cmd(zoom,0.25;x,SCREEN_CENTER_X+30;y,SCREEN_CENTER_Y+400;sleep,1;linear,0.1;addy,-370;sleep,0.05;addy,1;sleep,0.05;addy,-1;sleep,2;linear,0.5;diffusealpha,0),
        Texture= "sushi.png",
      },
};
