return Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.White),
	StartTransitioningCommand=cmd(diffusealpha,1;linear,1;diffusealpha,0)
}
