local x = Def.ActorFrame{
	LoadFont("Common Normal")..{
		Text=ScreenString("Saving Profiles");
		InitCommand=cmd(Center;diffuse,color("1,1,1,1");x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+130;zoom,0.8;skewx,-0.3;horizalign,left;maxwidth,520);
	};
};

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

return x;