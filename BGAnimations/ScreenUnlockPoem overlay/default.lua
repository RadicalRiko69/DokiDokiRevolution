if math.random(1,100) == 99 and ThemePrefs.Get("Severity") == "Intense" then
	unlock = "help"
else
	unlock = "poem"
end;
  
return Def.ActorFrame {
	LoadActor(unlock)..{
};
};
  