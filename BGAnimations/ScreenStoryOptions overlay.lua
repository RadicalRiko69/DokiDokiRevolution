local t = Def.ActorFrame{

	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,0");faderight,1;Center);
		OptionsScreenOnMessageCommand=cmd(linear,.5;diffuse,color("0,0,0,.8"));
	};
	--[[OptionsScreenOnMessageCommand=function(self)
		
	end;]]


};

local opt = {"Continue", "Skip To Next Cutscene", "Text Speed: ?", "Auto Read: OFF", "Quit"}

local function updateFocus(self)
	--SCREENMAN:SystemMessage(self:GetDestinationItem())
	for i=1, self:GetNumChildren() do
		if i == self:GetDestinationItem()+1 then
			self:GetChild("Frame"..i):GetChild("Text"):playcommand("GainFocus");
		else
			self:GetChild("Frame"..i):GetChild("Text"):playcommand("LoseFocus");
		end;
	end;
end;

local as = Def.ActorScroller{
	-- (float) Number of items to have visible at one time.
	-- ScrollThroughAllItems divides this value by 2.
	--NumItemsToDraw=0, -- Default value is 7 if this parameter is omitted.
	NumItemsToDraw=#opt*2,

	-- (float) The number of seconds to show each item.
	SecondsPerItem=0, -- Default value is 1 if this parameter is omitted.

	-- Transforms the ActorScroller's children. Usually used for scrolling.
	-- The most important part of an ActorScroller.
	-- This example spaces each item out 32 pixels vertically.

	-- "offset" represents the offset from the center of the scroller.
	TransformFunction=function(self,offset,itemIndex,numItems)
		--self:x(300*offset)
		self:y(30*offset);
		--math.sin(offset*math.pi/2)
	end,
	

	-- Scroller commands
	InitCommand=cmd(xy,25,SCREEN_CENTER_Y;SetFastCatchup,true),
	OnCommand=function(self)
		updateFocus(self);
		--updateRightBar(self, true);
		--Testing
		--[[local c = SONGMAN:GetCoursesInGroup("Touhou StepMania",true);
		local s = "";
		for i,v in ipairs(c) do
			s=s..v:GetDisplayFullTitle()..", ";
		end
		SCREENMAN:SystemMessage(s)]]
	end;
	CodeMessageCommand=
		function(self, param)
			if true then
				local ch;
				if param.Name == "Up" or param.Name == "MenuUp" then
					if self:GetDestinationItem() > 0 then
						self:SetDestinationItem(self:GetDestinationItem()-1);
					end;
					updateFocus(self);
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				elseif param.Name == "Down" or param.Name == "MenuDown" then
					if self:GetDestinationItem() < self:GetNumItems()-1 then
						self:SetDestinationItem(self:GetDestinationItem()+1);
					end;
					updateFocus(self);
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				elseif param.Name == "Left" or param.Name == "MenuLeft" then
					--SCREENMAN:SystemMessage(_G.selectedDifficulty);
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				elseif param.Name == "Right" or param.Name == "MenuRight" then

					--SCREENMAN:SystemMessage(_G.selectedDifficulty);
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				elseif param.Name == "Start" then
					if self:GetDestinationItem() == 0 then
						SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
					elseif self:GetDestinationItem() == 4 then
						MESSAGEMAN:Broadcast("VNQuit");
						SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
					end;
				end;
				--[[elseif param.Name == "back" then
					SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToPrevScreen");
				end;]]

			end
		end;
	
	SetNextScrollerCommand=function(self)
		isSelectingTutorial = true;
		inputLocked = false;
	end;
	
}


-- children (items to scroll)
-- CAVEAT: BitmapTexts have to be wrapped in ActorFrames in order to be colored.
-- This is a long standing issue (ITG? ITG2?)
for i,v in ipairs(opt) do
	as[#as+1] = Def.ActorFrame{
		Name="Frame"..i;
		Def.BitmapText{
			Name="Text";
			Font="Common Normal";
			Text=v;
			InitCommand=cmd(horizalign,left);
			GainFocusCommand=cmd(stoptweening;linear,.1;zoom,1;diffuse,color("fde3f2"));
			LoseFocusCommand=cmd(stoptweening;linear,.1;zoom,0.9;diffuse,color("ffffff"));
		}
	}
end;
t[#t+1] = as;

return t;
