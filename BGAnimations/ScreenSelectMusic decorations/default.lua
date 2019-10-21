local t = LoadFallbackB();

-- Legacy StepMania 4 Function
local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player );
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplay",GAMESTATE:GetPlayerState(pn););
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end

--Stuff on the right
t[#t+1] = Def.ActorFrame{

		-- CURRENT SONG ARTIST
		LoadFont("_halogen 20px")..{	
			InitCommand=cmd(x,SCREEN_CENTER_X+48;y,SCREEN_CENTER_Y+18;zoom,0.5;maxwidth,500;horizalign,left);
			OffCommand=cmd(decelerate,0.05;diffusealpha,0);
			CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
				if song then
					self:settext(song:GetDisplayArtist());
					self:finishtweening();self:diffusealpha(0);
					self:sleep(0.2);self:decelerate(0.05);self:diffusealpha(1);
				else
					self:stoptweening();self:linear(0.05);self:diffusealpha(0);
				end;
			end;
		};

		-- HELP TEXT
		LoadFont("_halogen 20px")..{	
			InitCommand=cmd(x,SCREEN_CENTER_X+32;y,SCREEN_BOTTOM-50;zoom,0.5;horizalign,left);
			OffCommand=cmd(decelerate,0.05;diffusealpha,0);
			Text="LEFT/RIGHT = Select Song     UP/DOWN = Choose Difficulty\nPress ENTER to choose a song.",
		};

		-- HEADER TEXT
		LoadFont("_halogen 20px")..{	
			InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_TOP+60;zoom,1;horizalign,left);
			OffCommand=cmd(decelerate,0.05;diffusealpha,0);
			Text="Select Music",
		};
};



-- Stuff on the left
t[#t+1] = Def.ActorFrame {

	LoadActor("banner frame.png")..{
		InitCommand=cmd(zoom,0.4;x,SCREEN_CENTER_X-175;y,SCREEN_TOP+110);
	};

	Def.Sprite{
		Name= "Sayori",
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-285;y,SCREEN_BOTTOM-72;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "sayori 2x1.png",
	},

	Def.Sprite{
		Name= "Natsuki",
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-215;y,SCREEN_BOTTOM-70;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "natsuki 2x1.png",
	},

	Def.Sprite{
		Name= "Yuri",
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-147;y,SCREEN_BOTTOM-70;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "yuri 2x1.png",
	},

	Def.Sprite{
		Name= "Monika",
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-70;y,SCREEN_BOTTOM-72;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "monika 2x1.png",
	},
		
};


return t
