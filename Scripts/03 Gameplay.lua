-- StepMania 5 default theme | script ring 03 | Gameplay.lua
-- someone thought it'd be a good idea to put theme preferences into the fallback
-- when they should've been in default instead. there is no emoticon for how i feel
-- at this moment right now -freem

-- for example, not every theme wants to worry about custom receptor positions.
local tNotePositions = {
	-- StepMania 3.9/4.0
	Normal = { -170, 170, },
	-- ITG
	Lower = { -125, 145, }
}

function GetTapPosition( sType )
	bCategory = (sType == 'Standard') and 1 or 2
	-- true: Normal
	-- false: Lower
	bPreference = ThemePrefs.Get("NotePosition") and "Normal" or "Lower"
	tNotePos = tNotePositions[bPreference]
	return tNotePos[bCategory]
end

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

-- combo under field is another thing that doesn't always need to be custom
function ComboUnderField()
	return ThemePrefs.Get("ComboUnderField")
end