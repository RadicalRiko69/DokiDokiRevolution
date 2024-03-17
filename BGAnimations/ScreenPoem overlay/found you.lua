
local t = Def.ActorFrame{	
}

t[#t+1] = Def.ActorFrame{
	Def.Sound{
		File=THEME:GetPathS("","explode"),
		InitCommand=function(self)
		end,
		OnCommand=cmd(sleep,5;queuecommand,"Play");
		PlayCommand=function(self)
			self:play();
			ThemePrefs.Set("Target","Caught");
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_BG/find me"),
		InitCommand=cmd(diffusealpha,0;zoom,0.666;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.5;linear,0.5;diffusealpha,1);
		OnCommand=function(self)
			self:sleep(4):queuecommand("Scroll")
		end,
		ScrollCommand=cmd(texcoordvelocity,0,-30;sleep,1;queuecommand,"Leave");
		LeaveCommand=function(self)
			SCREENMAN:SetNewScreen("ScreenTeamSushi");
		end,
	},
}


return t