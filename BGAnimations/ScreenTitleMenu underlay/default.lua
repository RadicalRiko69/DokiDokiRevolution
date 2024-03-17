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
				:sleep(4.75)
				:linear(1.5)
				:xy(math.random(-300,300),math.random(-300,300))
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
			self:sleep(4)
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
		Texture=THEME:GetPathG("","chibi/yuri"),
		OnCommand=function(self)
			self:y(SCREEN_BOTTOM+220)
				:x(SCREEN_RIGHT-280)
				:animate(false)
				:setstate(0)
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
				:setstate(1)
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
				:setstate(1)
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
				:setstate(0)
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
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(Color("Black"))
				:sleep(0.1)
				:diffusealpha(0)
		end
	},
	LoadActor(THEME:GetPathG("","hub")) .. {
		InitCommand=cmd(zoom,0.45;x,SCREEN_LEFT-110;y,SCREEN_CENTER_Y);
		OnCommand=cmd(sleep,4;decelerate,0.8;x,SCREEN_LEFT+110;);
	};
	LoadActor(THEME:GetPathG("","logo")) .. {
		InitCommand=cmd(zoom,0.2;x,SCREEN_LEFT+160;y,SCREEN_TOP-200);
		OnCommand=cmd(sleep,4.5;linear,0.25;y,SCREEN_TOP+100;decelerate,0.25;addy,-50;accelerate,0.25;addy,50;
		decelerate,0.1;addy,-5;accelerate,0.1;addy,5);
	};
	Explosion..{
		OnCommand=function(self)
			self:xy(160,30)
				:diffusealpha(0)
				:sleep(4.75)
				:diffusealpha(1)
				:accelerate(1)
				:y(500)
				:diffusealpha(0)
		end
	},
	Def.Quad{
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center;diffusealpha,0);
		OnCommand=cmd(sleep,4.8;diffusealpha,0.25;diffuse,Color("White");linear,0.5;diffusealpha,0);
	},
}
