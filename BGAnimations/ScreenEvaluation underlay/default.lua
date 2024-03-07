local t = Def.ActorFrame{};

-- Stuff on the left
t[#t+1] = Def.ActorFrame {

	LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/banner frame.png"))..{
		InitCommand=cmd(zoom,0.5;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y);
	};

	Def.Sound{
		File=GAMESTATE:GetCurrentSong():GetMusicPath();
		OnCommand=function(self)
			local audio = self:get()
			audio:volume(0.5)
			self:play()
		end;
		OffCommand=function(self)
			self:stop()
		end;
	};

	Def.Sprite{
		Name= "Sayori",
		Condition=(not GAMESTATE:IsExtraStage()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-285;y,SCREEN_BOTTOM-72;animate,false),
		WalkAroundCommand=function(self)
			self:decelerate(0.1):addx(4):addy(-10):decelerate(0.1):addy(10):sleep(1):decelerate(0.1):
			addx(-4):addy(-10):decelerate(0.1):addy(10):sleep(0.5):queuecommand("WalkAround");
		end,
		OnCommand=cmd(stoptweening;setstate,0;queuecommand,"WalkAround"),
		SongChosenMessageCommand=cmd(stoptweening;decelerate,0.1;x,SCREEN_CENTER_X-285;y,SCREEN_BOTTOM-72;),
		SongUnchosenMessageCommand=cmd(queuecommand,"WalkAround"),
		OffCommand=function(self)
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "Pop" or genre == "Dance Pop" or genre == "Synthpop" or genre == "Pop Rock" or genre == "Pop-Rock" or genre == "Alternative Pop" or genre == "Country"
			or genre == "Alternative Rock" or genre == "Teen Pop" or genre == "Electropop" or genre == "Electro-Pop" or genre == "Eurodance" or genre == "K-Pop" or genre == "K-POP" then
				self:finishtweening():setstate(1):decelerate(.145):addy(-50):accelerate(.145):addy(50):decelerate(.145):addy(-50):accelerate(.145):addy(50):queuecommand("ResetAnim")
			end
		end,
		ResetAnimCommand=cmd(setstate,0);
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/sayori 2x1.png"),
	},

	Def.Sprite{
		Name= "Natsuki",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-215;y,SCREEN_BOTTOM-70;animate,false),
		WalkAroundCommand=function(self)
			self:decelerate(0.1):addx(4):addy(-10):decelerate(0.1):addy(10):sleep(3):decelerate(0.1):
			addx(-4):addy(-10):decelerate(0.1):addy(10):sleep(2):queuecommand("WalkAround");
		end,
		OnCommand=cmd(stoptweening;setstate,0;sleep,0.5;queuecommand,"WalkAround"),
		SongChosenMessageCommand=cmd(stoptweening;decelerate,0.1;x,SCREEN_CENTER_X-215;y,SCREEN_BOTTOM-70),
		SongUnchosenMessageCommand=cmd(sleep,0.8;queuecommand,"WalkAround"),
		OffCommand=function(self)
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "Hip-Hop" or genre == "Hip Hop" or genre == "Trap" or genre == "R&B" or genre == "R'n'B" or genre == "Dancehall"
			or genre == "Pop Rap" or genre == "Reggaeton" or genre == "Moombahton" or genre == "Hip House"  or genre == "XROSS" then
				self:finishtweening():setstate(1):decelerate(.145):addy(-50):accelerate(.145):addy(50):decelerate(.145):addy(-50):accelerate(.145):addy(50):queuecommand("ResetAnim")
			end
		end,
		ResetAnimCommand=cmd(setstate,0);
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/natsuki 2x1.png"),
	},

	Def.Sprite{
		Name= "Yuri",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-147;y,SCREEN_BOTTOM-70;animate,false),
		WalkAroundCommand=function(self)
			self:decelerate(0.1):addx(4):addy(-10):decelerate(0.1):addy(10):sleep(4):decelerate(0.1):
			addx(-4):addy(-10):decelerate(0.1):addy(10):sleep(1):queuecommand("WalkAround");
		end,
		OnCommand=cmd(stoptweening;setstate,0;sleep,1;queuecommand,"WalkAround"),
		SongChosenMessageCommand=cmd(stoptweening;decelerate,0.1;x,SCREEN_CENTER_X-147;y,SCREEN_BOTTOM-70),
		SongUnchosenMessageCommand=cmd(sleep,1;queuecommand,"WalkAround"),
		OffCommand=function(self)
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "Soul" or genre == "Heavy Metal" or genre == "Latin Pop" or genre == "Post-Grunge" or genre == "Bachata"
			or genre == "Ballad" or genre == "Vallenato" or genre == "Tropical House"  or genre == "WORLD MUSIC" then
				self:finishtweening():setstate(1):decelerate(.145):addy(-50):accelerate(.145):addy(50):decelerate(.145):addy(-50):accelerate(.145):addy(50):queuecommand("ResetAnim")
			end
		end,
		ResetAnimCommand=cmd(setstate,0);
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/yuri 2x1.png"),
	},

	Def.Sprite{
		Name= "Monika",
		Condition=(not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-70;y,SCREEN_BOTTOM-72;animate,false),
		WalkAroundCommand=function(self)
			self:decelerate(0.1):addx(4):addy(-10):decelerate(0.1):addy(10):sleep(1):decelerate(0.1):
			addx(-4):addy(-10):decelerate(0.1):addy(10):sleep(2):queuecommand("WalkAround");
		end,
		OnCommand=cmd(stoptweening;setstate,0;sleep,2.3;queuecommand,"WalkAround"),
		SongChosenMessageCommand=cmd(stoptweening;decelerate,0.1;x,SCREEN_CENTER_X-70;y,SCREEN_BOTTOM-72),
		SongUnchosenMessageCommand=cmd(sleep,0.3;queuecommand,"WalkAround"),
		OffCommand=function(self)
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "EDM" or genre == "Dubstep" or genre == "Drum & Bass" or genre == "Funk" or genre == "Underground Rap"  or genre == "ORIGINAL"
			or genre == "Funk-Pop" or genre == "Electronic" or genre == "Progressive House" or genre == "Trance" or genre == "Eurobeat" then
				self:finishtweening():setstate(1):decelerate(.145):addy(-50):accelerate(.145):addy(50):decelerate(.145):addy(-50):accelerate(.145):addy(50):queuecommand("ResetAnim")
			end
		end,
		ResetAnimCommand=cmd(setstate,0);
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/monika 2x1.png"),
	},
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		Name="Frame";
		InitCommand=cmd(zoom,0.5;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y;MaskSource);
		Texture=THEME:GetPathB("","ScreenSelectMusic decorations/banner glass.png"),
	};
	Def.Sprite {
		InitCommand=cmd(rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y;MaskDest);
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				local song = GAMESTATE:GetCurrentSong();
				if song:HasJacket() then
					self:LoadBackground(song:GetJacketPath());
					self:scaletoclipped(137,137);
				elseif song:HasBanner() then
					self:LoadBackground(song:GetBannerPath());
					self:scaletoclipped(253,88);
					if IsGame("pump") then
						self:visible(true);
						self:Load(song:GetBannerPath());
						self:scaletoclipped(189,137);
					end
				elseif song:HasBackground() then
					self:LoadBackground(song:GetBackgroundPath());
					self:scaletoclipped(253,137);
				else
					self:Load(THEME:GetPathG("","Common fallback banner"))
					self:scaletoclipped(253,137);
				end;
			else
				self:visible(false);
			end
		end;
	};
	Def.Quad {
		InitCommand=cmd(diffuseshift;effectcolor1,color("#808080");effectcolor2,color("#a8a8a8");MaskDest;blend,Blend.Multiply;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
				self:scaletoclipped(265,145);
		end;
	};
};

--Song Info Stuff
t[#t+1] = Def.ActorFrame{

	LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/banner shine.png"))..{
		InitCommand=cmd(zoom,0.5;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y);
	};

	--STAGE DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;x,SCREEN_CENTER_X-176;y,SCREEN_CENTER_Y-144;zoom,0.7);
		OnCommand=function(self)
			local stage = GAMESTATE:GetCurrentStage()
			self:settext(THEME:GetString("Stage",ToEnumShortString(stage)).." Poem");
		end;
	};
	-- HELP TEXT	
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_BOTTOM-58;zoom,0.5);
		OffCommand=cmd(diffusealpha,0);
		Text="Press ENTER to continue.",
	};

	-- HEADER TEXT
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_TOP+60;zoom,1;horizalign,left);
		Text="Song Results",
	};

	-- PLAYER TEXT
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_TOP+94;zoom,0.6;horizalign,left;visible,GAMESTATE:IsHumanPlayer(PLAYER_1));
		Text="Player 1",
	};
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+290;y,SCREEN_TOP+94;zoom,0.6;horizalign,right;visible,GAMESTATE:IsHumanPlayer(PLAYER_2));
		Text="Player 2",
	};

	--JUDGEMENT DISPLAY
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-124;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("OUTSTANDING");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-92;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("EXCELLENT");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-62;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("IMPRESSIVE");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-32;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("PASSABLE");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-2;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("CRUDE");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+28;zoom,0.7;diffuse,color("#FF0000"));
		OnCommand=function(self)
			self:settext("UNINTELLIGIBLE");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+58;zoom,0.7;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("VERSE CHAIN");
		end;
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+86;zoom,0.7;diffuse,color("#000000"));
		Text="COMPLETION";
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+116;zoom,0.7;diffuse,color("#000000"));
		Text="DIFFICULTY";
	};
	LoadFont("_as i lay dying 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+146;zoom,0.7;diffuse,color("#000000"));
		Text="WRITER";
	};
};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	--Calculate positioning of items based on aspect ratio. (16:9 is the default.)
	local numbers_xPos = 100;
	local grades_xPos = 100;
	-- position = pn==PLAYER_2 ? 1 : -1;
	local position = (pn == "PlayerNumber_P2") and 1 or -1;
	local sPosition = 115;
	local profile = PROFILEMAN:GetProfile(pn)
	
	t[#t+1] = LoadActor("PlayerNumbers", pn)..{
		InitCommand=cmd(zoom,0.7;xy,SCREEN_CENTER_X+170+numbers_xPos*position,sPosition);
		OnCommand=function(self)
		end;
	};
	t[#t+1] = LoadActor("PlayerGrade", pn)..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+170+grades_xPos*position,SCREEN_CENTER_Y-50);
	};
	t[#t+1] = LoadActor(THEME:GetPathG("","PlayerSteps"), PLAYER_1)..{
		InitCommand=cmd(draworder,100;zoom,1.25;x,SCREEN_CENTER_X+56;y,SCREEN_CENTER_Y+100;visible,GAMESTATE:IsSideJoined(PLAYER_1));
	};
	t[#t+1] = LoadActor(THEME:GetPathG("","PlayerSteps"), PLAYER_2)..{
		InitCommand=cmd(draworder,100;x,SCREEN_CENTER_X+255;y,SCREEN_CENTER_Y+100;zoom,1.25;visible,GAMESTATE:IsSideJoined(PLAYER_2));
	};
	
end

return t
