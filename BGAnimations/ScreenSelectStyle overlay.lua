return Def.ActorFrame {
  OffCommand=function(s) SOUND:DimMusic(0,math.huge) end,
    Def.BitmapText{
        Name= "header",
        Font= "_riffic free medium 40px",
        InitCommand= cmd(horizalign,left;zoom,1;x,SCREEN_LEFT+20;y,SCREEN_TOP+30;strokecolor,color("#fe81ae")),
        Text= "Select Style",
      },

};
