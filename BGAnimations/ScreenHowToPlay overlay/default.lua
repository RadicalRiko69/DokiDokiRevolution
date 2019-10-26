return Def.ActorFrame {

	Def.Sprite{
      Name= "monika",
      Frames= {
        {Frame= 0, Delay= 0.150},
        {Frame= 1, Delay= 0.150},
		    {Frame= 2, Delay= 0.150},
        {Frame= 3, Delay= 0.150},
        {Frame= 2, Delay= 0.150},
		    {Frame= 1, Delay= 0.150},
    },
      OnCommand= cmd(x,SCREEN_CENTER_X-150;y,SCREEN_CENTER_Y+50;zoomy,1;zoomx,0;bob;effectmagnitude,0,0.3,0;sleep,2.5;bounceend,0.5;zoomx,0.5;zoomy,0.5;sleep,30;linear,1.05;zoomx,0;zoomy,0),
      Texture= "monika 4x1.png",
    },

    Def.Sprite{
        Name= "logo",
        OnCommand= cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;zoom,0.45;sleep,0.0;linear,0.3;diffusealpha,1;zoom,0.45;sleep,1.8;linear,0.3;zoom,0.25;x,SCREEN_CENTER_X-145;y,SCREEN_CENTER_Y-165),
        Texture= "howtoplay.png",
      },
    Def.Sprite{
        Name= "box",
        OnCommand= cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+180;diffusealpha,0;zoom,0.7;sleep,2.5;linear,0.3;diffusealpha,1),
        Texture= "background.png",
      },
    Def.BitmapText{
        Name= "company",
        Font= "_aller 20px",
        InitCommand= cmd(draworder,301;horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160;cropright,1),
        OnCommand= cmd(sleep,5;linear,2;cropright,0;sleep,2;linear,1;diffusealpha,0),
        Text= "This is called a crossover. Not many people can do it\nbecause it's a hard pattern, but all you have\nto do is twist your body and not bitch about it.",
      },
    Def.BitmapText{
        Name= "company",
        Font= "_aller 20px",
        InitCommand= cmd(draworder,301;horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160;cropright,1),
        OnCommand= cmd(sleep,11.5;linear,2;cropright,0;sleep,2;linear,1;diffusealpha,0),
        Text= "This is a hold note, you have to\nhold this down in order to keep you lifebar\nup so that you can pass songs.",
      },
    Def.BitmapText{
        Name= "company",
        Font= "_aller 20px",
        InitCommand= cmd(draworder,301;horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160;cropright,1),
        OnCommand= cmd(sleep,16.5;linear,2;cropright,0;sleep,2;linear,1;diffusealpha,0),
        Text= "This is a roll, you have to excessively\ntap until the note is completely gone. Otherwise you will\nend up dropping it and will deplete your lifebar.",
      },
    Def.BitmapText{
        Name= "company",
        Font= "_aller 20px",
        InitCommand= cmd(draworder,301;horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160;cropright,1),
        OnCommand= cmd(sleep,22;linear,2;cropright,0;sleep,2;linear,1;diffusealpha,0),
        Text= "This is quad note.\nMake sure to smash it using your two feet, absolutely\ndo not use your hands.",
      },
    Def.BitmapText{
        Name= "company",
        Font= "_aller 20px",
        InitCommand= cmd(draworder,301;horizalign,left;zoom,0.8;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+160;cropright,1),
        OnCommand= cmd(sleep,28;linear,2;cropright,0;sleep,2;linear,1;diffusealpha,0),
        Text= "Be careful what you play, some difficulties can be too hard\nand will lead to a game over!\nWill you dance your way into her heart?",
      },

};
