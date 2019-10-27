local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				local song = GAMESTATE:GetCurrentSong();
				if song:HasBackground() then
					self:LoadBackground(song:GetBackgroundPath());
				end;
				self:x(SCREEN_CENTER_X)
				self:y(SCREEN_CENTER_Y)
				self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
			else
				self:visible(false);
			end
		end;
	};
	Def.Quad {
		InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000000");diffusebottomedge,color("#000000");diffusealpha,0.45);
	};
};

return t
