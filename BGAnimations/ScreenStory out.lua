return Def.ActorFrame{
	Def.Quad{
		Name="Transition";
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffuse,Color("Black");faderight,1;cropright,1);
		OnCommand=function(self)
			self:linear(1);
			self:cropright(0);
			self:faderight(0);
		end;
	};

}