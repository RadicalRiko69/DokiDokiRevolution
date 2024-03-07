return Def.ActorFrame {
	LoadActor("explosion") .. {
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add');
		MilestoneCommand=cmd(zoom,0;diffusealpha,0.5;linear,0.5;zoom,1;diffusealpha,0);
	};
	LoadActor("explosion") .. {
		InitCommand=cmd(diffusealpha,0;blend,'BlendMode_Add');
		MilestoneCommand=cmd(rotationy,180;zoom,0;diffusealpha,0.5;linear,0.5;zoom,0.5;diffusealpha,0);
	};
};