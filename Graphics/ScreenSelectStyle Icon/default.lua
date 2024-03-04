local t = Def.ActorFrame {};
local gc = Var("GameCommand");
local max_stages = PREFSMAN:GetPreference( "SongsPerPlay" );

--------------------------------------
t[#t+1] = Def.ActorFrame {
	InitCommand=function(s) s:xy(_screen.cx,_screen.cy-100):zoom(0.56) end,
	LoadActor(THEME:GetPathG("","TextBox/background")) ..{
		InitCommand=function(self)
			self:diffuse(color("#fe80e0")):zoom(2)
		end,
	};
	InitCommand=function(s) s:xy(_screen.cx,_screen.cy-100):zoom(0.25):draworder(999) end,
	GainFocusCommand=function(self)
		self:finishtweening():diffusealpha(0):zoomy(0):smooth(0.2):zoomy(0.25):diffusealpha(1)
	end;
	OnCommand=function(self)
		self:diffusealpha(0):zoomy(0)
		if (GAMESTATE:GetNumPlayersEnabled() > 1 and gc:GetName() == "Versus") or (gc:GetName() == "Single" and GAMESTATE:GetNumPlayersEnabled() == 1) then
			self:finishtweening():smooth(0.2):zoomy(0.25):diffusealpha(1)
		end;
	end;
	LoseFocusCommand=function(s) s:finishtweening():smooth(0.1):zoomy(0):diffusealpha(0) end,
	OffCommand=function(s) s:smooth(0.2):zoomy(0):diffusealpha(0) end,
	LoadActor( gc:GetName()..".png" );
};

return t;
