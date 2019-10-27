return Def.ActorFrame{
	Def.Quad{
		Name="Transition";
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffuse,Color("Black");fadeleft,0;cropleft,0);
		OnCommand=function(self)
			self:linear(1);
			self:cropleft(1);
			self:fadeleft(1);
		end;
	};

}