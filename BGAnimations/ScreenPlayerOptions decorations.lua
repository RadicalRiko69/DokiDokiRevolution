local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("#ffffff");diffusealpha,0.5);
	};
    Def.Quad {
		InitCommand=cmd(Center;zoomx,645;zoomy,350;diffuse,color("#fe81ae"));
	};
	Def.Quad {
		InitCommand=cmd(Center;zoomx,640;zoomy,345;diffuse,color("#ffc8dc"));
	};
	LoadActor(THEME:GetPathS("","_ding")) .. {
		OnCommand=cmd(play);
	};
	LoadActor(THEME:GetPathS("","_launch")) .. {
		OffCommand=cmd(queuecommand,"Play");
        PlayCommand=cmd(play);
	};
};

return t
