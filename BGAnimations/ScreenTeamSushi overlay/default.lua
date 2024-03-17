if ThemePrefs.Get("Target") == "Caught" and ThemePrefs.Get("Severity") == "Intense" then
  splash = "hacked"
else
  splash = "normal"
end;

return Def.ActorFrame {
	LoadActor(splash)..{
	};
};
