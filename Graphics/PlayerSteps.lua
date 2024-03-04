local player = ...;

local t = Def.ActorFrame{}

--difficulty name
t[#t+1] = LoadFont("_halogen 20px") .. {
	InitCommand=cmd(maxwidth,300;y,10;x,14;zoom,0.5;vertalign,top;queuecommand,"Set");
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		if song then
			self:diffusealpha(1);
			local steps = GAMESTATE:GetCurrentSteps(player);
			local diff = string.gsub(string.gsub(ToEnumShortString(steps:GetStepsType()),".*_",""), ".*", string.upper);
			local meter = GAMESTATE:GetCurrentSteps(player):GetMeter()
			if diff == "THREEPANEL" then
					self:settext("ThreePanel Lv."..meter)
			elseif diff == "COUPLE" then
					self:settext("Couple Lv."..meter)
			elseif diff == "SINGLE" then
					self:settext("Single Lv."..meter)
			elseif diff == "DOUBLE" then
					self:settext("Double Lv."..meter)
			elseif diff == "ROUTINE" then
					self:settext("Co-Op Lv."..meter)
			else
				self:settext(diff);
			end
		else
			self:settext("---");
			self:diffusealpha(0.3);
		end
	end
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,40);
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(y,34;x,-26;zoom,0.5;vertalign,top;maxwidth,220);
		OnCommand=function(self)

			if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() then
				author = GAMESTATE:GetCurrentCourse():GetScripter();
				if author == "" then
					author = "N/A"
				end
			else
				author = GAMESTATE:GetCurrentSteps(player):GetAuthorCredit();		--Cortes got lazy and opt to use Description tag lol
				if author == "" then
					author = "N/A"
				end;
			end;			
			self:settext(author);
		end;
	};
};

return t
