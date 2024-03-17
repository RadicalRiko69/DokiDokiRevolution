--[[
If you're trying to figure out how to do button inputs, don't use this.
this function uses DeviceInput because I need /mouse/ input, you normally
don't need that.
]]
local function inputs(event)
	--Check if player clicked screen, then skip to next screen if they did.
	local button = ToEnumShortString(event.DeviceInput.button)
	if button == "left mouse button" then
		--SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
	end
end;


return Def.ActorFrame{
	--Fade out
	OnCommand=function(self)
		self:sleep(3);
		self:linear(0.5);
		self:diffusealpha(0);
		SCREENMAN:GetTopScreen():AddInputCallback(inputs);
	end;
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
				:diffuse(Color("Black"))
		end
	},
	LoadActor(THEME:GetPathG("","end"))..{
		InitCommand=cmd(zoom,0.14;Center;diffusealpha,0;linear,0.5;diffusealpha,1;sleep,1;linear,0.5;diffusealpha,0);
	};
};
