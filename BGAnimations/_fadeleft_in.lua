local ratio = 0.25		--screen width ratio
local animt = 1		--animation time
return Def.ActorFrame{

	Def.Quad{
		OnCommand=cmd(FullScreen;;diffuse,color("#000000");
			zoomx,_screen.w+(_screen.w*ratio);faderight,ratio;
			x,_screen.cx+(_screen.w*(ratio*0.5));
			decelerate,1;
			x,-_screen.cx-(_screen.w*(ratio*0.5));
		);
	};

};