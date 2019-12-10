--[[local chunk, errmsg = loadfile( THEME:GetCurrentThemeDirectory().."/StoryMode/Init.lua" )
if not chunk then error(errmsg) end
return chunk
]]
--Stop being a bitch ass and load my file, StepMania
if VN_NEXT_SCENE then
	return LoadActor("/"..THEME:GetCurrentThemeDirectory().."StoryMode/"..VN_NEXT_SCENE..".lua");
else
	return LoadActor("/"..THEME:GetCurrentThemeDirectory().."StoryMode/Init.lua");
end;
--return loadfile("/"..THEME:GetCurrentThemeDirectory().."StoryMode/Init.lua");
