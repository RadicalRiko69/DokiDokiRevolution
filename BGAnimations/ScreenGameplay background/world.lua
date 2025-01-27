local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("hearts") .. {
	};
	Def.Actor{
		OnCommand=function(s)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				local bg = SCREENMAN:GetTopScreen():GetChild("SongBackground")
				if bg then
					bg:basezoom(0.32):xy(SCREEN_CENTER_X-137,SCREEN_CENTER_Y+77):faderight(0.25):fadeleft(0.25);
				else
					bg:diffusealpha(0);
				end
			end
		end,
		CurrentSongChangedMessageCommand=function(s) s:queuecommand("On") end,
	};
};

return t