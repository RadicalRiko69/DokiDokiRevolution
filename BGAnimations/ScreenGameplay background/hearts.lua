local Circles = Def.ActorFrame{}
local healthStates = { [PLAYER_1] = "HealthState_Alive", [PLAYER_2] = "HealthState_Alive" }

for i = 1,15 do
	for i2 = 1,15 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","gameplaybg 3x1.png"),
			OnCommand=function(self) self:zoom(.15):xy(128*(i-1),128*(i2-1)):animate(false):wag():effectmagnitude(0,0,15):effectclock('beatnooffset') end,
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 or param.PlayerNumber == PLAYER_2 then
					-- Store the state we just obtained.
					healthStates[param.PlayerNumber] = param.HealthState

					-- Now check both of them.
					local isSame = healthStates[PLAYER_1] == healthStates[PLAYER_2]
					if isSame then
						local state = healthStates[PLAYER_1]
						if state == "HealthState_Danger" then
							self:setstate(1):diffuse(Color("Red"))
						elseif state == "HealthState_Dead" then
							self:setstate(2):queuecommand("Shake1"):linear(1):diffuse(Color("Black"))
						elseif state == "HealthState_Alive" then
							self:setstate(0):diffuse(Color("White"))
						end
					else
					-- Both states are different, store back to normal.
					self:setstate(0):diffuse(Color("White"))
					end
				end
			end,
			Shake1Command=function(self) self:vibrate():effectmagnitude(50,50,50):effectperiod(0.1):sleep(0.5):queuecommand("Shake2") end,
			Shake2Command=function(self) self:bounce():effectmagnitude(0,0,0):effectperiod(1) end,
		}
	end
end

for i = 1,15 do
	for i2 = 1,15 do
		Circles[#Circles+1] = Def.Sprite{
			Texture=THEME:GetPathG("","gameplaybg 3x1.png"),
			OnCommand=function(self) self:zoom(.15):xy(64+128*(i-1),64+128*(i2-1)):animate(false):wag():effectmagnitude(0,0,15):effectclock('beatnooffset') end,
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 or param.PlayerNumber == PLAYER_2 then
					-- Store the state we just obtained.
					healthStates[param.PlayerNumber] = param.HealthState

					-- Now check both of them.
					local isSame = healthStates[PLAYER_1] == healthStates[PLAYER_2]
					if isSame then
						local state = healthStates[PLAYER_1]
						if state == "HealthState_Danger" then
							self:setstate(1):diffuse(Color("Red"))
						elseif state == "HealthState_Dead" then
							self:setstate(2):queuecommand("Shake1"):linear(1):diffuse(Color("Black"))
						elseif state == "HealthState_Alive" then
							self:setstate(0):diffuse(Color("White"))
						end
					else
					-- Both states are different, store back to normal.
					self:setstate(0):diffuse(Color("White"))
					end
				end
			end,
			Shake1Command=function(self) self:vibrate():effectmagnitude(50,50,50):effectperiod(0.1):sleep(0.5):queuecommand("Shake2") end,
			Shake2Command=function(self) self:bounce():effectmagnitude(0,0,0):effectperiod(1) end,
		}
	end
end

return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuseshift():effectcolor1(color("#be24be")):effectcolor2(color("#8f1f8f")):effectclock('beatnooffset');
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == PLAYER_1 or param.PlayerNumber == PLAYER_2 then
				-- Store the state we just obtained.
				healthStates[param.PlayerNumber] = param.HealthState

				-- Now check both of them.
				local isSame = healthStates[PLAYER_1] == healthStates[PLAYER_2]
				if isSame then
					local state = healthStates[PLAYER_1]
					if state == "HealthState_Danger" then
						self:linear(0.5):diffuseshift():diffusealpha(1):effectcolor1(color("#b40000")):effectcolor2(color("#920000")):effectclock('beatnooffset')
					elseif state == "HealthState_Dead" then
						self:linear(0.5):diffuseshift():diffusealpha(1):effectcolor1(color("#181818")):effectcolor2(color("#000000")):effectperiod(10)
					elseif state == "HealthState_Alive" then
						self:linear(0.5):diffuseshift():diffusealpha(1):effectcolor1(color("#be24be")):effectcolor2(color("#8f1f8f")):effectclock('beatnooffset')
					elseif state == "HealthState_Hot" then
						self:linear(0.5):diffusealpha(0.5):rainbow():effectperiod(10)
					end
				else
					self:linear(0.5):diffuseshift():diffusealpha(1):effectcolor1(color("#be24be")):effectcolor2(color("#8f1f8f")):effectclock('beatnooffset')
				end
			end
		end,
	},
	Def.ActorFrame{
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
			end,
		}
	},
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(color("#ff0000")):diffusealpha(0);
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == PLAYER_1 or param.PlayerNumber == PLAYER_2 then
				-- Store the state we just obtained.
				healthStates[param.PlayerNumber] = param.HealthState

				-- Now check both of them.
				local isSame = healthStates[PLAYER_1] == healthStates[PLAYER_2]
				if isSame then
					local state = healthStates[PLAYER_1]
					if state == "HealthState_Dead" then
						self:diffusealpha(1):diffuse(color("#ff0000")):sleep(0.1):linear(1):diffusealpha(0);
					elseif state == "HealthState_Alive" then
						self:diffusealpha(1):diffuse(color("#ffffff")):sleep(0.1):linear(0.25):diffusealpha(0);
					elseif state == "HealthState_Hot" then
						self:diffusealpha(1):diffuse(color("#ffffff")):sleep(0.1):linear(1):diffusealpha(0);
					end
				else
				-- Both states are different, store back to normal.
				self:diffusealpha(0);
				end
			end
		end,
	},
}