return Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.Black),
	StartTransitioningCommand=cmd(diffusealpha,1;sleep,0.02;diffusealpha,0)
}
