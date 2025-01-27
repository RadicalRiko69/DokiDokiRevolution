
--
local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));

	-- Text
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(Center;diffusealpha,0);
	OnCommand=cmd(finishtweening;diffusealpha,1;);
	OffCommand=cmd(sleep,3;diffusealpha,0;);
	Def.Quad {
		InitCommand=cmd(zoomx,8500;zoomy,8500;diffuse,color("#ffffff");diffusealpha,0.5);
	};
	Def.Quad {
		InitCommand=cmd(zoomx,445;zoomy,85;diffuse,color("#fe81ae"));
	};
	Def.Quad {
		InitCommand=cmd(zoomx,440;zoomy,80;diffuse,color("#ffc8dc"));
	};
	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
		InitCommand=cmd(maxwidth,750;diffuse,Color("Black");zoom,0.75);
	};
	LoadActor(THEME:GetPathS("","_ding")) .. {
		OnCommand=cmd(play);
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = cmd(finishtweening);
};

return t;
