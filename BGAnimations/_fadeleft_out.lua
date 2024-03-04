local ratio = 0.25		--screen width ratio
local animt = 1		--animation time
return Def.ActorFrame{

	Def.Quad{
		OnCommand=function(self)
			self:FullScreen();self:zoomx(_screen.w+(_screen.w*ratio*2));self:diffuse(color("0,0,0,1"));self:fadeleft(ratio);
			self:x(_screen.cx*3+(_screen.w*ratio/2));
			self:decelerate(animt);
			self:x(_screen.cx-(_screen.w*ratio/2));
		end;
	};

};