local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Back" or event.GameButton == "Select" then
            SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
        elseif event.GameButton == "Start" then
            SCREENMAN:SetNewScreen("ScreenHelp");
        end
    end
    return false
end

local t = Def.ActorFrame{
	InitCommand=function(s) s:Center():queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input)
    end,
	OffCommand=cmd(diffusealpha,0);
	Def.Quad {
		InitCommand=cmd(zoomx,305;zoomy,105;diffuse,color("#fe81ae"));
	};
	Def.Quad {
		InitCommand=cmd(zoomx,300;zoomy,100;diffuse,color("#ffc8dc"));
	};
	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
        Text="Hey! Can you hear me?\nIt's a really important warning!";
		InitCommand=cmd(addy,-20;diffuse,Color("Black");zoom,0.75);
	};
	Def.BitmapText{
		Font="_riffic free medium 40px";
		Name="Text";
        Text="Yes (Enter)      No (Esc)";
		InitCommand=cmd(addy,20;strokecolor,color("#fe81ae");zoom,0.5);
	};
	LoadActor(THEME:GetPathS("Common","value")) .. {
		OnCommand=cmd(play);
	};
}

return t