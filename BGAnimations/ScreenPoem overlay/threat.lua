local t = Def.ActorFrame{
}

t[#t+1] = Def.ActorFrame{
	Def.Sound{
		File=THEME:GetPathS("","laugh"),
		OnCommand=cmd(sleep,10;queuecommand,"Play");
		PlayCommand=function(self)
			self:play();
			self:sleep(0.5);
			self:queuecommand("ForceLeave");
		end,
		ForceLeaveCommand=function(self)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_BG/threat"),
	  	OnCommand=cmd(diffusealpha,0;zoom,0.666;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.5;linear,0.5;diffusealpha,1);
	},
}

return t