local game = GAMESTATE:GetCurrentGame():GetName()

if game == "dance" then
	LOGO = "dance"
elseif game == "pump" then
	LOGO = "pump"
elseif game == "be-mu" then
	LOGO = "bemu"
elseif game == "maniax" or game == "smx" then
	LOGO = "maniax"
elseif game == "techno" then
	LOGO = "techno"
else
	LOGO = "dance"
end;
return Def.ActorFrame{
	Def.ActorFrame{
		LoadActor(LOGO) ..{
		};
	};
};
