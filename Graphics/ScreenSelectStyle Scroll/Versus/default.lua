local NumPlayers = GAMESTATE:GetNumPlayersEnabled()
local game = GAMESTATE:GetCurrentGame():GetName()

if game == "dance" then
	PAD = "dance"
elseif game == "pump" then
	PAD = "pump"
else
	PAD = "dance"
end;
return Def.ActorFrame{
	Def.ActorFrame{
		GainFocusCommand=function(s) s:stoptweening():smooth(0.3):zoom(1)
		end,
		LoseFocusCommand=function(s) s:stoptweening():smooth(0.3):zoom(0.825) end,
		LoadActor("pad"..PAD) ..{
			InitCommand=function(s) s:diffusealpha(0):zoomx(1):xy(2,278) end,
			OnCommand=function(s) s:zoom(0):decelerate(0.5):diffusealpha(1.0):zoom(1) end,
			GainFocusCommand=function(s) s:finishtweening():smooth(0.3):diffusealpha(1):diffuse(color("#FFFFFF"))
			end,
			LoseFocusCommand=function(s) s:finishtweening():stopeffect():diffuse(color("#353535")) end,
		};
		LoadActor("girls") ..{
			InitCommand=function(s) s:diffusealpha(0):zoomx(1):xy(2,278) end,
			OnCommand=function(s) s:zoom(0):decelerate(0.5):diffusealpha(1.0):zoom(0.8) end,
			GainFocusCommand=function(s) s:finishtweening():smooth(0.3):diffusealpha(1):diffuse(color("#FFFFFF")):bounce():effectmagnitude(0,-40,0):effectperiod(0.5)
			end,
			LoseFocusCommand=function(s) s:finishtweening():stopeffect():diffuse(color("#353535")) end,
		};
	};
};
