local Circles = Def.ActorFrame{}

for i = 1,10 do
	for i2 = 1,5 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","BGCircle.png"),
			OnCommand=function(self) self:zoom(.2):diffuse(.9,.8,.7,1):xy(128*(i-1),128*(i2-1)) end
		}
	end
end

return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(1,.9,.8,1)
		end
	},
	Circles,
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
				:zoom(.4)
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
}