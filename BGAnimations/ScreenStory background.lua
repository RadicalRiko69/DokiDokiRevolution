--[[local chunk, errmsg = loadfile( THEME:GetCurrentThemeDirectory().."/StoryMode/Init.lua" )
if not chunk then error(errmsg) end
return chunk
]]
--Stop being a bitch ass and load my file, StepMania
return LoadActor("/"..THEME:GetCurrentThemeDirectory().."StoryMode/Init.lua");
--return loadfile("/"..THEME:GetCurrentThemeDirectory().."StoryMode/Init.lua");
