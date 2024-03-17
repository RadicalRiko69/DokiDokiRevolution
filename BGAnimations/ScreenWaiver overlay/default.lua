local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Start" then
            SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			ThemePrefs.Set("Waiver","Agree")
        end
    end

    return false
end

return Def.ActorFrame{
    OnCommand=function(s) s:queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input)
    end,
	BeginCommand=function(s)
		if ThemePrefs.Get("Waiver") == "Agree" then
			SCREENMAN:SetNewScreen("ScreenTitleMenu");
		end
	end,
	LoadActor(THEME:GetPathS("","Sparkle"))..{
		OffCommand=cmd(play);
	};
	LoadActor(THEME:GetPathG("","_BG/warning"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45);
	};
	LoadActor(THEME:GetPathG("","_BG/wallpaper"))..{
		InitCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OffCommand=cmd(zoom,0.45;decelerate,2;diffusealpha,1);
	};
	LoadActor(THEME:GetPathG("","TextBox/background"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffuse,color("#fe80e0");zoom,0.7);
		OffCommand=cmd(decelerate,1;diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("","TextBox/frame"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;zoom,0.7);
		OffCommand=cmd(decelerate,1;diffusealpha,0);
	};
	LoadFont("_aller thin 20px") .. {
		OnCommand=function(self)
			self:settext("This is a DDLC fan game not associated with Team Salvato or Serenity Forge. The original game must be played before using this theme as it contains spoilers from the original game.")
		end;
		InitCommand=cmd(x,SCREEN_CENTER_X-213;y,SCREEN_CENTER_Y+130;zoom,0.7;halign,0;valign,0;horizalign,left;wrapwidthpixels,610;strokecolor,Color("Black");faderight,1;linear,4;faderight,0;sleep,2;diffusealpha,0);
	};
	LoadFont("_aller thin 20px") .. {
		OnCommand=function(self)
			self:settext("This fan creation also contains contents not suitable for children or people who are easily disturbed. By using this theme, you are aware of the unpredictable features that may occur using the theme.")
		end;
		InitCommand=cmd(x,SCREEN_CENTER_X-213;y,SCREEN_CENTER_Y+130;zoom,0.7;halign,0;valign,0;horizalign,left;wrapwidthpixels,610;strokecolor,Color("Black");faderight,1;sleep,6;linear,4;faderight,0;sleep,2;diffusealpha,0);
	};
	LoadFont("_aller thin 20px") .. {
		OnCommand=function(self)
			self:settext("By accepting this waiver, you have read the GitHub page rules on what the theme can be used for.\n\nPress ENTER to agree and proceed using this theme.")
		end;
		InitCommand=cmd(x,SCREEN_CENTER_X-213;y,SCREEN_CENTER_Y+130;zoom,0.7;halign,0;valign,0;horizalign,left;wrapwidthpixels,610;strokecolor,Color("Black");faderight,1;sleep,12;linear,4;faderight,0);
		OffCommand=cmd(diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("","_StepsDisplayListRow arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+210;y,SCREEN_CENTER_Y+212);
		OffCommand=cmd(diffusealpha,0);
	};

};
