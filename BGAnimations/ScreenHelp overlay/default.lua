local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Back" then
            SCREENMAN:SetNewScreen("ScreenSelectMusic");
        elseif event.GameButton == "Start" then
            SCREENMAN:SetNewScreen("ScreenSelectMusic");
        end
    end
    return false
end

local t = Def.ActorFrame{
	InitCommand=function(s) s:Center():queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input)
		ThemePrefs.Set("Target","Caught")
    end,
	LoadActor(THEME:GetPathG("","_BG/youre cooked lol"))..{
		InitCommand=cmd(diffusealpha,0;zoom,0.45;sleep,0.5;linear,0.5;diffusealpha,1;blend,Blend.Multiply);
	};
	OffCommand=cmd(diffusealpha,0);
	Def.Quad {
		InitCommand=cmd(zoomx,285;zoomy,105;diffuse,color("#fe81ae"));
	};
	Def.Quad {
		InitCommand=cmd(zoomx,280;zoomy,100;diffuse,color("#ffc8dc"));
	};
	Def.BitmapText{
		OnCommand=function(self)
			if math.random(1,5) == 1 then
				self:settext("File error: ''characters/monika.chr''\nThe file is missing or corrupt.");
			elseif math.random(1,5) == 2 then
				self:settext("File error: ''characters/natsuki.chr''\nThe file is missing or corrupt.");
			elseif math.random(1,5) == 3 then
				self:settext("File error: ''characters/sayori.chr''\nThe file is missing or corrupt.");
			elseif math.random(1,5) == 4 then
				self:settext("File error: ''characters/yuri.chr''\nThe file is missing or corrupt.");
			else
				self:settext("ÔÕóô-²³´žŸ ¡¢£¤¥¦§¨©ª«¬\n­®¯°±²³´µ¶·¸¹º»é÷!#$%&'()*+,-.");
			end;
		end,
		Font="Common Normal";
		Name="Text";
		InitCommand=cmd(addy,-20;diffuse,Color("Black");zoom,0.75);
	};
	Def.BitmapText{
		OnCommand=function(self)
			self:settext("ËÌÍÎÏÐÑ‘’“”•–—­®¯°±²³´µ¡ÒÓÔÕÖéêëìíîïðñòóô-²³´µ¡¢£¤¥¦§¨©ª«¬¶");
		end,
		Font="Common Normal";
		Name="Text";
		InitCommand=cmd(addy,200;diffuse,Color("Black");zoom,0.5);
	};
	Def.BitmapText{
		Font="_riffic free medium 40px";
		Name="Text";
        Text="OK";
		InitCommand=cmd(addy,20;strokecolor,color("#fe81ae");zoom,0.5);
	};
	LoadActor(THEME:GetPathS("Common","value")) .. {
		OnCommand=cmd(play);
	};
}

return t