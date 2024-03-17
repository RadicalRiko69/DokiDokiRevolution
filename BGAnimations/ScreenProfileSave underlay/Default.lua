return Def.ActorFrame{
	BeginCommand=function(s)
		if math.random(1,1) == 1 then
			SCREENMAN:SetNewScreen("ScreenUnlockPoem");
		end
	end,
};
