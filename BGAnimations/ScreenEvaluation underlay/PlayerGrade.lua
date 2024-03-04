local player = ...

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "2f", num))
end

local dancepoints = round(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()*100.0)

return Def.ActorFrame{
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(horizalign,center;vertalign,top;zoom,0.8);
		--OnCommand=cmd(x,-75;y,125;diffusealpha,0;sleep,1+delay*9;decelerate,0.3;diffusealpha,1);
		OnCommand=cmd(y,135;diffusealpha,0;decelerate,0.3;diffusealpha,1);
		Text=dancepoints.."%";
	};
}