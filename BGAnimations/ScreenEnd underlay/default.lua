local function input(event,param)
    if not event.button then return false end
    if event.type ~= "InputEventType_Release" then
        if event.GameButton == "Start" or event.GameButton == "Select" then
            SCREENMAN:SetNewScreen("ScreenExitScare");
        end
    end

    return false
end

GAMESTATE:UnjoinPlayer(PLAYER_1)

return Def.ActorFrame{
	OnCommand=function(s) s:queuecommand("Capture") end,
	CaptureCommand=function(s) 
		SCREENMAN:GetTopScreen():AddInputCallback(input)
    end,
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(Color("White"))
		end
	},
	Def.Sound{
		File="ghost (loop)",
		OnCommand=function(self)
			self:playcommand("Play")
		end,
		PlayCommand=function(self)
			self:play()
		end,
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","chibi/yuri"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+220)
				:x(SCREEN_RIGHT-280)
				:animate(false)
				:setstate(2)
				:zoom(.7)
				:sleep(4.5)
				:zoom(.75)
				:linear(1)
				:xy(SCREEN_RIGHT-290,SCREEN_CENTER_Y-20)
				:zoom(0.8)
				:decelerate(.5)
				:x(SCREEN_RIGHT-300)
				:zoom(0.9)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","chibi/natsuki"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+220)
				:x(SCREEN_RIGHT-220)
				:animate(false)
				:setstate(2)
				:zoom(.6)
				:sleep(4.5)
				:zoom(.65)
				:linear(1)
				:xy(SCREEN_RIGHT-210,SCREEN_CENTER_Y)
				:zoom(0.7)
				:decelerate(.5)
				:x(SCREEN_RIGHT-200)
				:zoom(0.8)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","chibi/sayori"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+250)
				:x(SCREEN_RIGHT-380)
				:animate(false)
				:setstate(2)
				:zoom(.8)
				:sleep(4.5)
				:zoom(.85)
				:linear(1)
				:xy(SCREEN_RIGHT-390,SCREEN_CENTER_Y+140)
				:zoom(0.9)
				:decelerate(.5)
				:x(SCREEN_RIGHT-400)
				:zoom(1)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","chibi/monika"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+150)
				:x(SCREEN_RIGHT-140)
				:animate(false)
				:setstate(2)
				:zoom(0.9)
				:sleep(5)
				:zoom(0.95)
				:linear(.5)
				:xy(SCREEN_RIGHT-130,SCREEN_CENTER_Y+160)
				:zoom(1.1)
				:decelerate(.5)
				:x(SCREEN_RIGHT-120)
				:zoom(1.2)
		end
	},
}
