local t = Def.ActorFrame {
};
-- Lock input for half a second so that players don't accidentally start a song
t[#t+1] = Def.Actor { 
	StartSelectingStepsMessageCommand=function() SCREENMAN:GetTopScreen():lockinput(0.25); end;
};

t[#t+1] = Def.Quad{
		InitCommand=cmd(diffusealpha,0);
		CodeMessageCommand=function(self, params)
			if params.Name == "EscapeFromEventMode" then
				self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(Color("Black"))
				:diffusealpha(1)
				SCREENMAN:SetNewScreen("ScreenTitleMenu");
			end
		end;
};

return t;
