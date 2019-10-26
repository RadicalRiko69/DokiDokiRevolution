local t = Def.ActorFrame{

	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black");faderight,1);
	};

};

return t;
