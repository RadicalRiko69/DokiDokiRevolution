local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Actor{
		OnCommand=function(s)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				local bg = SCREENMAN:GetTopScreen():GetChild("SongBackground")
			end
		end,
		CurrentSongChangedMessageCommand=function(s) s:queuecommand("On") end,
	};
};

return t