local Circles = Def.ActorFrame{}

for i = 1,15 do
	for i2 = 1,15 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","BGCircle.png"),
			OnCommand=function(self) self:zoom(.15):xy(128*(i-1),128*(i2-1)) end
		}
	end
end

for i = 1,15 do
	for i2 = 1,15 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","BGCircle.png"),
			OnCommand=function(self) self:zoom(.15):xy(64+128*(i-1),64+128*(i2-1)) end
		}
	end
end

local Explosion = Def.ActorFrame{}

for i = 1,100 do
	Explosion[#Explosion+1] = Def.Sprite{
		Texture=THEME:GetPathG("","EXPCircle.png"),
		OnCommand=function(self)
			self:zoom(.05)
				:diffusealpha(.8)
				:sleep(11)
				:linear(1.5)
				:xy(math.random(-300,300),math.random(-300,300))
		end
	}
end


--lmao what?
local selection = 1;
local scrollerChoiceNames = {
	{"New Game","DDDANStoryMode"},
	{"Free Play","DDDANSelectMusic"},
	{"Settings","ScreenOptionsService"},
	{"Help","aa"},
	{"Quit","ScreenQuitGame"}
}
--Jousway fix this for me -RL
local custScrollerFrame = Def.ActorFrame{
	CodeMessageCommand=function(self, param)
		local inputLocked = false;
		if not inputLocked then
			
			--Wow this is super fun and not at all extremely stupid
			--ActorScrollers are so fucking dumb
			self:playcommandonchildren("LoseFocus");
			--SCREENMAN:SystemMessage(self:GetDestinationItem())
			--self:GetChild("ScrollItem"..self:GetDestinationItem()):playcommand("GainFocus")
			
			if param.Name == "up" then
				if selection > 1 then
					self:GetChild("ScrollItem"..selection):playcommand("LoseFocus")
					selection = selection - 1;
					self:GetChild("ScrollItem"..selection):playcommand("GainFocus")
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				end;
			elseif param.Name == "down" then
				if selection < #scrollerChoiceNames then
					self:GetChild("ScrollItem"..selection):playcommand("LoseFocus")
					selection = selection + 1;
					self:GetChild("ScrollItem"..selection):playcommand("GainFocus")
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				end;
			elseif param.Name == "left" then
				if selection > 1 then
					self:GetChild("ScrollItem"..selection):playcommand("LoseFocus")
					selection = selection - 1;
					self:GetChild("ScrollItem"..selection):playcommand("GainFocus")
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				end;
			elseif param.Name == "right" then
				if selection < #scrollerChoiceNames then
					self:GetChild("ScrollItem"..selection):playcommand("LoseFocus")
					selection = selection + 1;
					self:GetChild("ScrollItem"..selection):playcommand("GainFocus")
					SOUND:PlayOnce(THEME:GetPathS("Common", "value"), true);
				end;
				--SCREENMAN:SystemMessage(_G.selectedDifficulty);
			elseif param.Name == "start" then
				SCREENMAN:GetTopScreen():SetNextScreenName(scrollerChoiceNames[selection][2]);
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
			elseif param.Name == "back" then
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToPrevScreen");
			end;

		end
	end;
	-- Scroller commands
	InitCommand=cmd(xy,30,SCREEN_CENTER_Y),
};
for i = 1,#scrollerChoiceNames do
	custScrollerFrame[i] = Def.BitmapText{
		Name="ScrollItem"..i,
		Font="_riffic free medium 20px",
		Text=scrollerChoiceNames[i][1],
		InitCommand=cmd(diffuse,Color("White");playcommand,(i==selection and "GainFocus" or "LoseFocus");horizalign,left;y,30*i;addx,-200),
		OnCommand=cmd(sleep,11+.1*i;decelerate,.3;addx,200);
		GainFocusCommand=cmd(Stroke,color("#ff99ff"));
		LoseFocusCommand=cmd(Stroke,color("#cc00cc"));
		--GainFocusCommand=cmd(visible,true);
		--LoseFocusCommand=cmd(visible,false);
	}
end;

return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(1,1,1,1)
		end
	},
	Def.ActorFrame{
		OnCommand=function(self) 
			self:sleep(9)
				:accelerate(.75)
				:addy(-128)
				:decelerate(.75)
				:addy(-128)
				:sleep(.000001)
				:addy(256)
		end,
		Circles..{
			OnCommand=function(self) 
				self:diffuse(1,.8,.9,1)
					:queuecommand("Loop")
			end,
			LoopCommand=function(self)
				self:linear(5)
					:addy(-128)
					:addx(-128)
					:sleep(.000001)
					:addy(128)
					:addx(128)
					:queuecommand("Loop")
			end
		}
	},
	
	
	Def.Sprite{
		Texture=THEME:GetPathG("","Characters/yuri.png"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+200)
				:x(SCREEN_CENTER_X-40)
				:zoom(.2)
				:sleep(9)
				:linear(1)
				:y(SCREEN_CENTER_Y+60)
				:zoom(.3)
				:linear(.5)
				:CenterY()
				:zoom(.35)
				:decelerate(.5)
				:zoom(.4)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","Characters/natsuki.png"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+150)
				:x(SCREEN_CENTER_X+40)
				:zoom(.2)
				:sleep(9)
				:linear(1)
				:y(SCREEN_CENTER_Y+60)
				:zoom(.3)
				:linear(.5)
				:CenterY()
				:zoom(.35)
				:decelerate(.5)
				:zoom(.4)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","Characters/sayori.png"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+250)
				:x(SCREEN_CENTER_X-40)
				:zoom(.2)
				:sleep(9.5)
				:zoom(.35)
				:linear(1)
				:xy(SCREEN_CENTER_X-80,SCREEN_CENTER_Y+120)
				:zoom(.4)
				:decelerate(.5)
				:x(SCREEN_CENTER_X-120)
				:zoom(.5)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","Characters/monika.png"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+150)
				:x(SCREEN_CENTER_X+40)
				:zoom(.2)
				:sleep(10)
				:zoom(.35)
				:linear(.5)
				:xy(SCREEN_CENTER_X+120,SCREEN_CENTER_Y+160)
				:zoom(.5)
				:decelerate(.5)
				:x(SCREEN_CENTER_X+160)
				:zoom(.6)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","hub.png"),
		OnCommand=function(self)
			self:CenterY()
				:zoom(.8)
				:x(-self:GetWidth()/2)
				:sleep(10)
				:decelerate(.5)
				:x(0)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","logo.png"),
		OnCommand=function(self)
			self:zoom(.2)
				:xy(140,-160)
				:sleep(10.5)
				:linear(.5)				
				:y(80)
				:decelerate(.25)
				:y(40)
				:accelerate(.25)
				:y(80)
				:decelerate(.125)
				:y(60)
				:accelerate(.125)
				:y(80)
				:decelerate(.0625)
				:y(70)
				:accelerate(.0625)
				:y(80)
		end
	},
	Explosion..{
		OnCommand=function(self)
			self:xy(140,80)
				:diffusealpha(0)
				:sleep(11)
				:diffusealpha(1)
				:sleep(.5)
				:accelerate(1)
				:y(500)
				:diffusealpha(0)
		end
	},


	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(1,1,1,1)
				:sleep(8)
				:linear(.5)
				:diffusealpha(0)
				:sleep(2.5)
				:diffusealpha(0.8)
				:linear(.2)
				:diffusealpha(0)
		end
	},
	Def.ActorFrame{
		OnCommand=function(self) 
			self:diffusealpha(0)
				:linear(.5)
				:diffusealpha(1)
				:sleep(2)
				:linear(.5)
				:diffusealpha(0)
		end,
		Def.BitmapText{
			Font="_aller thin 20px",
			Text="Original Game By:\nTeam Salvato",
			OnCommand=function(self) self:Center():diffuse(0,0,0,1) end
		}
	},
	Def.BitmapText{
		Font="_aller thin 20px",
		Text="This game is not suitable for children\nor those who are easily disturbed.",
		OnCommand=function(self)
			self:Center() 
				:diffuse(0,0,0,0)
				:sleep(4)
				:linear(.5)
				:diffusealpha(1)
				:sleep(2)
				:linear(.5)
				:diffusealpha(0)
		end
	},
	custScrollerFrame
}

