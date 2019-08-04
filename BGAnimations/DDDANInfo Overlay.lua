local Text = "This is a Doki Doki Literature Club fan game that is not affiliated with\nTeam Salvato. It is designed to be played only after the official game\nhas been completed.\n\nYou can download Doki Doki Literature Club at: http://ddlc.moe"
local TableText = {}
local CurText = ""
local TextCount = 0

string.gsub(Text,".",function(c) table.insert(TableText,c) end)

return Def.ActorFrame{
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
			if TextCount < #TableText then
				TextCount = TextCount + 1
				CurText = CurText..TableText[TextCount]
				self:sleep(0.02):settext(CurText):queuecommand("TextUpdate")
			end
		end
	},
	Def.Quad{
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