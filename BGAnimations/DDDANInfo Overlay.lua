local Text = {
	"This is a Doki Doki Literature Club fan game that is not affiliated with\nTeam Salvato. It is designed to be played only after the official game\nhas been completed.\n\nYou can download Doki Doki Literature Club at: http://ddlc.moe",
	"This game is not suitable for children or those who are easily\ndisturbed.\n\nIndividuals suffering from anxiety or depression may not have a\nsafe experience playing this game.",
	"By playing Doki Doki Dancing All Night, you agree that you are at\nleast 13 years of age, and you consent to your exposure of hightly\ndisturbing content."
}
local TableText = {}
local CurText = ""
local TextCount = 0
local CurTextVer = 1

for i = 1,#Text do
	local TextCon = {}
	string.gsub(Text[i],".",function(c) table.insert(TextCon,c) end)
	TableText[#TableText+1] = TextCon
end

local Circles = Def.ActorFrame{}

for i = 1,10 do
	for i2 = 1,5 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","BGCircle.png"),
			OnCommand=function(self) self:zoom(.15):xy(128*(i-1),128*(i2-1)) end
		}
	end
end

for i = 1,10 do
	for i2 = 1,5 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","BGCircle.png"),
			OnCommand=function(self) self:zoom(.15):xy(64+128*(i-1),64+128*(i2-1)) end
		}
	end
end


return Def.ActorFrame{
	Def.ActorFrame{
		Def.Quad{
			OnCommand=function(self)
				self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(1,.9,.8,1)
			end
		},
		Circles..{OnCommand=function(self) self:diffuse(.9,.8,.7,1) end},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/sayori_g.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X-160)
					:zoom(.4)
					:diffuse(1,.9,.75,1)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/yuri_g.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X-40)
					:zoom(.4)
					:diffuse(1,.9,.75,1)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/monika_g.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X+40)
					:zoom(.4)
					:diffuse(1,.9,.75,1)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/natsuki_g.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X+160)
					:zoom(.4)
					:diffuse(1,.9,.75,1)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","logo_g.png"),
			OnCommand=function(self)
				self:halign(0)
					:valign(0)
					:zoom(.2)
					:diffuse(1,.9,.75,1)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Gradient.png"),
			OnCommand=function(self)
				self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
					:blend("BlendMode_Add")
					:diffuse(1,.9,.8,.75)
			end
		}
	},
	Def.ActorFrame{
		Name="Normal",
		OnCommand=function(self) self:diffusealpha(0) end,
		Def.Quad{
			OnCommand=function(self)
				self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(1,1,1,1)
			end
		},
		Circles..{OnCommand=function(self) self:diffuse(1,.8,.9,1) end},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/sayori.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X-160)
					:zoom(.4)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/yuri.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X-40)
					:zoom(.4)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/monika.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X+40)
					:zoom(.4)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Characters/natsuki.png"),
			OnCommand=function(self)
				self:CenterY()
					:x(SCREEN_CENTER_X+160)
					:zoom(.4)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","logo.png"),
			OnCommand=function(self)
				self:halign(0)
					:valign(0)
					:zoom(.2)
			end
		},
	},
	Def.ActorFrame{
		Def.Sprite{
			Texture=THEME:GetPathG("","TextBox/Background.png"),
			OnCommand=function(self) 
				self:CenterX()
					:zoom(.8)
					:y(SCREEN_BOTTOM-80)
					:diffuse(1,.6,.75,1)
				
				end 
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","TextBox/Frame.png"),
			OnCommand=function(self) 
				self:CenterX()
					:zoom(.8)
					:y(SCREEN_BOTTOM-80)
			end 
		},
		Def.BitmapText{
			Font="_aller 20px",
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X-240,SCREEN_BOTTOM-120)
					:zoom(.75)
					:halign(0)
					:valign(0)
					:strokecolor(0,0,0,1)
					:sleep(1.5)
					:queuecommand("TextUpdate")
			end,
			TextUpdateCommand=function(self)
				if CurTextVer < #TableText+1 then
					if TextCount < #TableText[CurTextVer] then
						TextCount = TextCount + 1
						CurText = CurText..TableText[CurTextVer][TextCount]
						self:sleep(0.02):settext(CurText):queuecommand("TextUpdate")
					else
						CurTextVer = CurTextVer + 1
						TextCount = 0
						CurText = ""
						self:sleep(2):queuecommand("TextUpdate")
					end
				end
				
				if CurTextVer == #TableText then
					if TextCount == #TableText[CurTextVer] then
						self:GetParent():GetChild("AgreeBox"):visible(1)
						SCREENMAN:GetTopScreen():AddInputCallback(DDDAN.Input(self))
					end
				end
			end,
			StartCommand=function(self) 
				self:GetParent()
					:visible(0)
					:GetParent()
					:GetChild("Normal")
					:linear(.5)
					:diffusealpha(1)
					:GetParent()
					:GetChild("fade")
					:sleep(1)
					:linear(.5)
					:diffusealpha(1)
					
				self:sleep(2):queuecommand("Transition")
			end,
			TransitionCommand=function(self)
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			end
		},
		Def.ActorFrame{
			Name="AgreeBox",
			OnCommand=function(self) self:visible(0) end,
			Def.Quad{
				OnCommand=function(self) 
					self:zoomto(300,30):Center():diffuse(1,.6,.75,1)
				end
			},	
			Def.Quad{
				OnCommand=function(self) 
					self:zoomto(296,26):Center():diffuse(1,.8,.9,1)
				end
			},	
			Def.BitmapText{
				Font="_aller 20px",
				Text="I Agree",
				OnCommand=function(self) 
					self:Center()
				end
			}
			
		}
	},
	Def.Quad{
		Name="fade",
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(0,0,0,1)
				:linear(.25)
				:diffuse(1,1,1,1)
				:linear(.25)
				:diffusealpha(0)
		end
	}
}