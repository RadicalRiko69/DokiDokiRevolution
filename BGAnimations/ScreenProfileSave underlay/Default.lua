return Def.ActorFrame{
	BeginCommand=function(s)
		if math.random(1,5) == 5 then
			SCREENMAN:SetNewScreen("ScreenUnlockPoem");
		end
	end,
};
