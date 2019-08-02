return Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.White);
	StartTransitioningCommand=cmd(diffusealpha,0;sleep,0;linear,1;diffusealpha,1);
};