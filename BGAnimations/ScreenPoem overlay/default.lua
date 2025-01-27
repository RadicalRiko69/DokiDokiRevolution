local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Start" then
            SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
        end
    end
    return false
end

if math.random(1,10) == 8 and ThemePrefs.Get("Severity") == "Intense" then
	note = "threat"
elseif math.random(1,6) == 3 and ThemePrefs.Get("Severity") == "Intense" then
	note = "hxppy"
elseif math.random(1,100) == 69 and ThemePrefs.Get("Severity") == "Intense" then
	note = "found you"
elseif ThemePrefs.Get("Severity") == "Intense" then
	note = "poem"
else
	note = "advice"
end;

local t = Def.ActorFrame{
	InitCommand=function(s) s:queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input);
    end,
	LoadActor(THEME:GetPathS("Common","Page Flip")) .. {
		OnCommand=cmd(sleep,0.5;queuecommand,"Play");
		PlayCommand=cmd(play);
	};
	LoadActor(THEME:GetPathS("","Sparkle")) .. {
		OnCommand=cmd(play);
	};
	LoadActor(note) ..{
	};
}

return t