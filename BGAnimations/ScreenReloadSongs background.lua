return Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(diffuse,color("#000000");diffusealpha,1;zoom,1000000;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
  --Loading assets
  LoadFont("_vcr osd mono 40px")..{
		InitCommand=cmd(uppercase,true;Center;zoom,0.6;diffusebottomedge,color("#ff0081");diffusetopedge,color("#ff76d4"));
		OnCommand=function(s)
      s:settext("Refreshing Database...");
    end;
	};
  LoadActor(THEME:GetPathG("","_UI/scanlines"))..{
    OnCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;blend,Blend.Multiply);
  };
};
