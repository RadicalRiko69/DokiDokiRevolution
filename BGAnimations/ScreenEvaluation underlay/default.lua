local t = Def.ActorFrame{};

-- Stuff on the left
t[#t+1] = Def.ActorFrame {
	Def.Sound{
		File=GAMESTATE:GetCurrentSong():GetMusicPath();
		OnCommand=function(self)
			local audio = self:get()
			audio:volume(1)
			self:play()
		end;
		OffCommand=function(self)
			self:stop()
		end;
	};
};

-- Chibis
t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if ThemePrefs.Get("Target") == "Caught" then
			self:visible(false);
		else
			self:visible(true);
		end
	end,
	
	--SAYORI
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
			if genre == "Pop" or genre == "Dance Pop" or genre == "Synthpop" or genre == "Pop Rock" or genre == "Pop-Rock" or genre == "Alternative Pop" or genre == "Country" or genre == "Bubblegum Dance"
			or genre == "Alternative Rock" or genre == "Teen Pop" or genre == "Electropop" or genre == "Electro-Pop" or genre == "Eurodance" or genre == "K-Pop" or genre == "K-POP" then
				self:finishtweening():setstate(1):decelerate(.145):addy(-50):accelerate(.145):addy(50):decelerate(.145):addy(-50):accelerate(.145):addy(50):queuecommand("ResetAnim")
			end
		end,
		ResetAnimCommand=cmd(setstate,0);
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/sayori 3x1.png"),
	},
	--NATSUKI
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
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/natsuki 3x1.png"),
	},
	--YURI
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
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/yuri 3x1.png"),
	},
	--MONIKA
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
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/monika 3x1.png"),
	},
};

-- Ghosts
t[#t+1] = Def.ActorFrame {
	OnCommand=function(self)
		if ThemePrefs.Get("Target") == "Caught" then
			self:visible(true);
		else
			self:visible(false);
		end
	end,
	
	--SAYORI
	Def.Sprite{
		Name= "Sayori",
		Condition=(not GAMESTATE:IsExtraStage()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-285;y,SCREEN_BOTTOM-60;animate,false;setstate,2),
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/sayori 3x1.png"),
	},
	--NATSUKI
	Def.Sprite{
		Name= "Natsuki",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-215;y,SCREEN_BOTTOM-70;animate,false;setstate,2),
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/natsuki 3x1.png"),
	},
	--YURI
	Def.Sprite{
		Name= "Yuri",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-147;y,SCREEN_BOTTOM-70;animate,false;setstate,2),
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/yuri 3x1.png"),
	},
	--MONIKA
	Def.Sprite{
		Name= "Monika",
		Condition=(not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-70;y,SCREEN_BOTTOM-72;animate,false;setstate,2),
		Texture= THEME:GetPathB("","ScreenSelectMusic decorations/monika 3x1.png"),
	},
};

--PHONE SCREEN
if not GAMESTATE:IsCourseMode() then
	local function CDTitleUpdate(self)
		local song = GAMESTATE:GetCurrentSong();
		local banner = self:GetChild("Banner");
		
		if song then
			if song:HasJacket() then
				banner:visible(true);
				banner:Load(song:GetJacketPath());
				banner:scaletoclipped(137,137);
				banner:MaskDest();
			elseif song:HasBanner() then
				banner:visible(true);
				banner:Load(song:GetBannerPath());
				banner:scaletoclipped(253,105);
				banner:MaskDest();
				if IsGame("pump") then
					banner:visible(true);
					banner:Load(song:GetBannerPath());
					banner:scaletoclipped(205,137);
					banner:MaskDest();
				end
			elseif song:HasBackground() then
				banner:visible(true);
				banner:Load(song:GetBackgroundPath());
				banner:scaletoclipped(253,137);
				banner:MaskDest();
			else
				banner:visible(true);
				banner:Load(THEME:GetPathG("","Common fallback banner"));
				banner:scaletoclipped(253,137);
				banner:MaskDest();
			end;
		end;
		
		if not song then
			banner:visible(false);
			banner:zoom(1);
			banner:MaskDest();
		end;
		banner:zoom(1)
		banner:MaskDest();
	end;
	t[#t+1] = Def.ActorFrame {
		OnCommand=cmd(x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y;rotationz,-6;SetUpdateFunction,CDTitleUpdate);
		LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/banner frame.png"))..{
			InitCommand=cmd(zoom,0.5);
		};
		Def.Sprite {
			Name="Frame";
			InitCommand=cmd(zoom,0.5;MaskSource);
			Texture=THEME:GetPathB("","ScreenSelectMusic decorations/banner glass.png"),
		};	
		Def.Sprite {
			Name="Banner";
			CurrentSongChangedMessageCommand=function(self)
				(cmd(finishtweening;Load,nil;zoom,1.1;rotationz,0;decelerate,0.1;zoom,1))(self);
			end;
		};	
	};
	--PHONE BURN
	t[#t+1] = Def.Quad {
		InitCommand=cmd(scaletoclipped,253,137;diffuseshift;effectcolor1,color("#525252");effectcolor2,color("#2e2e2e");effectperiod,1;
		MaskDest;blend,Blend.Multiply;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y);
	};
	
end;

--Song Info Stuff
t[#t+1] = Def.ActorFrame{

	LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/banner shine.png"))..{
		InitCommand=cmd(zoom,0.5;rotationz,-6;blend,Blend.Add;x,SCREEN_CENTER_X-175;y,SCREEN_CENTER_Y);
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
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-124;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("OUTSTANDING");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-92;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("EXCELLENT");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-62;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("IMPRESSIVE");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-32;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("PASSABLE");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y-2;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("CRUDE");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+28;zoom,0.6;diffuse,color("#FF0000"));
		OnCommand=function(self)
			self:settext("UNINTELLIGIBLE");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+58;zoom,0.6;diffuse,color("#000000"));
		OnCommand=function(self)
			self:settext("VERSE CHAIN");
		end;
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+86;zoom,0.6;diffuse,color("#000000"));
		Text="COMPLETION";
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+116;zoom,0.6;diffuse,color("#000000"));
		Text="DIFFICULTY";
	};
	LoadFont("_journal 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+170;y,SCREEN_CENTER_Y+146;zoom,0.6;diffuse,color("#000000"));
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
