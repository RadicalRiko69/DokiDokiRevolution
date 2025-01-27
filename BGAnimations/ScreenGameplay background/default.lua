if ThemePrefs.Get("Background") == "Traditional" then
	bg = "traditional"
else
	bg = "world"
end;

local t = Def.ActorFrame{
	LoadActor(bg) ..{
	};
}

return t