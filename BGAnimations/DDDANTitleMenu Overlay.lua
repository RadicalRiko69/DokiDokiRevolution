local Circles = Def.ActorFrame{}

GAMESTATE:UnjoinPlayer(PLAYER_1)

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

local selection = 1
local LockInput = false
local DisableCharInput = true
local NameString = ""

function NameInput(self)
	return function(event)		
		if not DisableCharInput then
			if ToEnumShortString(event.type) == "FirstPress" or ToEnumShortString(event.type) == "Repeat" then
				let = ToEnumShortString(event.DeviceInput.button)
				if let == "enter" then 
					if NameString ~= "" and NameString then
						local UserAlreadyExists = false
						for _,v in pairs(PROFILEMAN:GetLocalProfileDisplayNames()) do
							if string.lower(v) == string.lower(NameString) then UserAlreadyExists = true end
						end
						
						if not UserAlreadyExists then
							local count = 0
							local CheckProfile = true
							while CheckProfile do
								CheckProfile = false
								count = count + 1
								for _,v in pairs(PROFILEMAN:GetLocalProfileIDs()) do
									if v == string.format("%08d", count) then CheckProfile = true end
									print(v.."-"..string.format("%08d", count))
								end
							end
							
							--[[local file = RageFileUtil.CreateRageFile()
							
							file:Open("Save/LocalProfiles/"..string.format("%08d", count).."/Editable.ini", 2)
							file:Write("[Editable]\nBirthYear=0\nCharacterID=default\nDisplayName="..NameString.."\nIgnoreStepCountCalories=0\nIsMale=1\nLastUsedHighScoreName=\nVoomax=0.000000\nWeightPounds=0\n")
							file:Close()
							file:destroy()--]]
							
							GAMESTATE:LoadProfiles()
							
							GAMESTATE:JoinPlayer(PLAYER_1)
						
							DisableCharInput = true
							self:GetParent():GetChild("Input"):diffusealpha(0)
							self:GetParent():GetChild("Overlay"):linear(.5):diffusealpha(1)
							SCREENMAN:GetTopScreen():SetNextScreenName("DDDANSelectMusic")
							self:sleep(1):queuecommand("Transition")
						else
							self:GetParent():GetChild("Input"):GetChild("Info"):settext("Profile already exists\nPick a diffrent name")
							NameString = ""
						end
					end
				end
				if let == "escape" then
					DisableCharInput = true
					self:GetParent():GetChild("Input"):diffusealpha(0)
					LockInput = false
					NameString = ""
				end
				if let == "backspace" then
					if NameString then
						NameString = string.match(NameString, "(.+).")
					end
				else
					if string.len(let) > 1 then let = "" end
					if string.len(NameString or "") < 16 and string.match(let, "%w") then
						NameString = (NameString or "")..let
					end
				end
				self:GetParent():GetChild("Input"):GetChild("Name"):settext(NameString or "")
				self:GetParent():GetChild("Input"):GetChild("Cursor"):x(self:GetParent():GetChild("Input"):GetChild("Name"):GetWidth()*.4)
			end
		end
	end
end

local function InputNewUser(self)
	if not LockInput then
		LockInput = true
		DisableCharInput = false
		self:GetParent():GetChild("Input"):diffusealpha(1)
		self:GetParent():GetChild("Input"):GetChild("Info"):settext("Please enter your name")
	end
end

local function NextScreen(self,Screen)
	SCREENMAN:GetTopScreen():SetNextScreenName(Screen)
	self:queuecommand("Transition")
end

local scrollerChoiceNames = {
	{"New Game",function(self) InputNewUser(self) end},
	{"Load Game",""},
	{"Settings",""},
	{"Help",""},
	{"Quit",function(self) NextScreen(self,'ScreenExit') end}
}

local function MoveSelection(self,offset)
	if not LockInput then
		self:GetChild("ScrollItem"..selection):strokecolor(color("#cc00cc"))
		selection = selection + offset
		if selection > #scrollerChoiceNames then selection = 1 end
		if selection < 1 then selection = #scrollerChoiceNames end
		self:GetChild("ScrollItem"..selection):strokecolor(color("#ff99ff"))
		SOUND:PlayOnce(THEME:GetPathS("Common", "Value"), true)
	end
end

local custScrollerFrame = Def.ActorFrame{
	OnCommand=function(self) self:xy(30,SCREEN_CENTER_Y):sleep(11):queuecommand("ActivateInput") end,
	ActivateInputCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(DDDAN.Input(self)):AddInputCallback(NameInput(self)) end,
	MenuUpCommand=function(self) MoveSelection(self,-1) end,
	MenuLeftCommand=function(self) MoveSelection(self,-1) end,
	MenuDownCommand=function(self) MoveSelection(self,1) end,
	MenuRightCommand=function(self) MoveSelection(self,1) end,
	StartCommand=function(self)	scrollerChoiceNames[selection][2](self) end,
	TransitionCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end
}

for i = 1,#scrollerChoiceNames do
	custScrollerFrame[i] = Def.BitmapText{
		Name="ScrollItem"..i,
		Font="_riffic free medium 20px",
		Text=scrollerChoiceNames[i][1],
		OnCommand=function(self)
				self:halign(0)
					:y(30*i)
				if i == selection then 
					self:strokecolor(color("#ff99ff")) 
				else
					self:strokecolor(color("#cc00cc"))
				end
		end
	}
end

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

	custScrollerFrame,
	
	Def.ActorFrame{
		Name="Input",
		OnCommand=function(self)
			self:Center()
				:diffusealpha(0)
		end,
		Def.Quad{
			OnCommand=function(self)
				self:zoomto(220,160)
					:diffuse(1,.8,.9,1)
			end
		},
		Def.Quad{
			OnCommand=function(self)
				self:zoomto(212,152)
					:diffuse(1,.9,.95,1)
			end
		},
		Def.BitmapText{
			Name="Info",
			Font="_aller thin 20px",
			Text="Please enter your name",
			OnCommand=function(self) self:diffuse(0,0,0,1):zoom(.8):y(-40) end
		},
		Def.BitmapText{
			Font="_riffic free medium 20px",
			Text="OK",
			OnCommand=function(self) self:zoom(.8):y(40):strokecolor(color("#ff99ff")) end
		},
		Def.BitmapText{
			Name="Name",
			Font="_riffic free medium 20px",
			OnCommand=function(self) self:zoom(.8):strokecolor(0,0,0,1) end
		},
		Def.BitmapText{
			Name="Cursor",
			Font="_aller thin 20px",
			Text="|",
			OnCommand=function(self) self:zoom(.8):diffuseshift():effectcolor1(1,1,1,0):effectcolor2(.5,.3,.4,1) end
		}
	},

	Def.Quad{
		Name="Overlay",
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
	}
}

