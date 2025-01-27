-- shakesoda calls this pump.lua
local function CurGameName()
	return GAMESTATE:GetCurrentGame():GetName()
end

-- GameCompatibleModes:
-- [en] returns possible modes for ScreenSelectPlayMode
function GameCompatibleModes()
	local Modes = {
		dance = "Single,Versus,Double",
		groove = "Single,Versus,Double",
		pump = "Single,Versus,Double",
		['be-mu'] = "5Keys,7Keys,10Keys,14Keys,Versus5,Versus7",
		kb7 = "KB7",
		smx = "Single,Versus,Double6,Double10,Couple,Routine",
		para = "Single,Versus",
		maniax = "Single,Versus,Double",
		-- todo: add versus modes for technomotion
		techno = "Single4,Single5,Single8,Single9,Versus4,Versus5,Versus8,Versus9,Double4,Double5,Double8,Double9",
		lights = "Single", -- lights shouldn't be playable
	}
	return Modes[CurGameName()]
end