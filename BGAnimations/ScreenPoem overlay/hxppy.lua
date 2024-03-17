
local t = Def.ActorFrame{	
}

t[#t+1] = Def.ActorFrame{
	Def.Sound{
		File=THEME:GetPathS("","buzz"),
		OnCommand=cmd(sleep,10;queuecommand,"Play");
		PlayCommand=function(self)
			self:play();
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_BG/hxppy thxughts"),
		Frames= {
			{Frame= 0, Delay= 10.000},
			{Frame= 1, Delay= 999.9},
		  },
		  InitCommand=cmd(diffusealpha,0;zoom,0.666;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.5;linear,0.5;diffusealpha,1);
		OnCommand=function(self)
			self:sleep(9):queuecommand("Scroll")
		end,
		ScrollCommand=cmd(texcoordvelocity,0,-3);
	},
}


return t