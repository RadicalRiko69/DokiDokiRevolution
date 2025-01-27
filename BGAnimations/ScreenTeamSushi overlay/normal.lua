return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("#000000");diffusealpha,1;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
  --Loading
  LoadFont("_vcr osd mono 40px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;xy,SCREEN_LEFT+10,SCREEN_TOP+20;zoom,0.6;diffusebottomedge,color("#ff0081");diffusetopedge,color("#ff76d4"));
		OnCommand=function(s)
      s:settext("Loading assets..."):sleep(1):queuecommand("Text1");
    end;
		Text1Command=function(s)
      s:settext("Loading CHR files..."):sleep(1):queuecommand("Text2");
    end;
		Text2Command=function(s)
      s:settext("Loaded sayori.chr"):sleep(1):queuecommand("Text3");
    end;
		Text3Command=function(s)
      s:settext("Loaded natsuki.chr"):sleep(1):queuecommand("Text4");
    end;
		Text4Command=function(s)
      s:settext("Loaded yuri.chr"):sleep(1):queuecommand("Text5");
    end;
		Text5Command=function(s)
      s:settext("Loaded monika.chr"):sleep(1):queuecommand("Text6");
    end;
		Text6Command=function(s)
      s:settext("Loaded cynthia.chr"):sleep(1):queuecommand("Text7");
    end;
		Text7Command=function(s)
      s:settext("Loaded sarena.chr"):sleep(1):queuecommand("Text8");
    end;
		Text8Command=function(s)
      s:settext("Completed..."):sleep(1):queuecommand("Text9");
    end;
		Text9Command=function(s)
      s:settext("Execute transition");
    end;
	};
  --Loading assets
  LoadFont("_vcr osd mono 40px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;xy,SCREEN_RIGHT-450,SCREEN_BOTTOM-30;zoom,0.6;diffusebottomedge,color("#ff0081");diffusetopedge,color("#ff76d4"));
		OnCommand=function(s)
      s:settext("Sushiverse Entertainment\nVirtual Machine : Now Loading");
    end;
	};
  Def.Sprite{
    Name= "cursor",
    Frames= {
      {Frame= 0, Delay= 0.055},
      {Frame= 3, Delay= 0.055},
      {Frame= 2, Delay= 0.055},
      {Frame= 1, Delay= 0.055},
    },
      OnCommand= cmd(xy,SCREEN_RIGHT-20,SCREEN_BOTTOM-18;zoom,0.26;SetTextureFiltering,false;diffusebottomedge,color("#ff0081");diffusetopedge,color("#ff76d4")),
      Texture= THEME:GetPathG("","_UI/cursor 4x1.png"),
    },
    LoadActor(THEME:GetPathG("","_UI/scanlines"))..{
      OnCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;blend,Blend.Multiply);
    };
    Def.Sprite{
      Name= "transition",
      Frames= {
        {Frame= 20, Delay= 10.00},
        {Frame= 0, Delay= 0.035},
        {Frame= 1, Delay= 0.035},
        {Frame= 2, Delay= 0.035},
        {Frame= 3, Delay= 0.035},
        {Frame= 4, Delay= 0.035},
        {Frame= 5, Delay= 0.035},
        {Frame= 6, Delay= 0.035},
        {Frame= 7, Delay= 0.035},
        {Frame= 8, Delay= 0.035},
        {Frame= 9, Delay= 0.035},
        {Frame= 10, Delay= 0.035},
        {Frame= 11, Delay= 0.035},
        {Frame= 12, Delay= 0.035},
        {Frame= 13, Delay= 0.035},
        {Frame= 14, Delay= 0.035},
        {Frame= 15, Delay= 0.035},
        {Frame= 16, Delay= 0.035},
        {Frame= 17, Delay= 0.035},
        {Frame= 18, Delay= 0.035},
        {Frame= 19, Delay= 99999},
      },
        OnCommand= cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;SetTextureFiltering,false;sleep,15),
        Texture= THEME:GetPathG("","_UI/transition 7x3.png"),
      },
    Def.Sound {
      OnCommand=cmd(sleep,10;queuecommand,"Play");
      PlayCommand=cmd(play);
      File=THEME:GetPathS("","_whoosh"),
    },
};
