return Def.ActorFrame{
	BeginCommand=function(s)
		if math.random(1,10) == 10 then
			SCREENMAN:SetNewScreen("ScreenUnlockPoem");
		end
	end,
};
