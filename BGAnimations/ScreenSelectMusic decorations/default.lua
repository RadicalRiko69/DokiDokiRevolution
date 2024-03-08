local CUR_STEPS_TYPE = GAMESTATE:GetCurrentStyle():GetStepsType();

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

--The function that... Draws the items in the two part select list.
--There are two of these drawn at once since both p1 and p2 need to be colored. Yes it's hacky, but it makes gradients work.

local function oppositePlayer(pn)
	return (pn == PLAYER_1) and PLAYER_2 or PLAYER_1
end;

local function drawDiffListItem(difficulty, pn)

	local pnColors = {
		[PLAYER_1] = color("#ff9ef2"),
		[PLAYER_2] = Color("HoloBlue")
	}

	return Def.ActorFrame{
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongChosen");
		SongChosenMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song:HasStepsTypeAndDifficulty(CUR_STEPS_TYPE,difficulty) then
				self:visible(true);
				local steps = song:GetOneSteps(CUR_STEPS_TYPE,difficulty);
				if difficulty == "Difficulty_Edit" then
					local chName = steps:GetChartName();
					if chName == "" or chName == nil then chName = THEME:GetString("CustomDifficulty","Edit") end;
					self:GetChild("DifficultyAndMeter"):settext(chName.." (Lv."..steps:GetMeter()..")");
				else
					self:GetChild("DifficultyAndMeter"):settext(THEME:GetString("CustomDifficulty",ToEnumShortString(difficulty)).." (Lv."..steps:GetMeter()..")");
				end;
				if steps:GetAuthorCredit() ~= "" then
					self:GetChild("StepsBy"):settext("Steps By "..steps:GetAuthorCredit()):visible(true);
				else
					self:GetChild("StepsBy"):visible(false);
				end
				
				self:GetChild("NoteCount"):settext(steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds').." notes")
			else
				self:visible(false);
			end;
		end;
		["CurrentSteps"..pname(pn).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSong():GetOneSteps(CUR_STEPS_TYPE,difficulty) == GAMESTATE:GetCurrentSteps(pn) then
				self:GetChild("DifficultyAndMeter"):strokecolor(pnColors[pn]);
				self:GetChild("NoteCount"):strokecolor(pnColors[pn]);
				self:GetChild("StepsBy"):strokecolor(pnColors[pn]);
				if GAMESTATE:GetCurrentSteps(pn) == GAMESTATE:GetCurrentSteps(oppositePlayer(pn)) then
					if pn == PLAYER_1 then
						self:GetChild("DifficultyAndMeter"):faderight(1);
					else
						self:GetChild("DifficultyAndMeter"):fadeleft(1);
					end;
				else
					self:GetChild("DifficultyAndMeter"):faderight(0):fadeleft(0);
				end;
			else
				self:GetChild("DifficultyAndMeter"):NoStroke();
				self:GetChild("NoteCount"):NoStroke();
				self:GetChild("StepsBy"):NoStroke();
			end
		end;
		["CurrentSteps"..pname(oppositePlayer(pn)).."ChangedMessageCommand"]=function(self)
			if GAMESTATE:GetCurrentSteps(pn) == GAMESTATE:GetCurrentSteps(oppositePlayer(pn)) and GAMESTATE:GetCurrentSong():GetOneSteps(CUR_STEPS_TYPE,difficulty) == GAMESTATE:GetCurrentSteps(pn) then
				if pn == PLAYER_1 then
					self:GetChild("DifficultyAndMeter"):faderight(1);
				else
					self:GetChild("DifficultyAndMeter"):fadeleft(1);
				end;
			else
				self:GetChild("DifficultyAndMeter"):faderight(0):fadeleft(0);
			end
		end;
		Def.BitmapText{
			Name="DifficultyAndMeter";
			Font="_halogen outline 20px";
			InitCommand=cmd(y,-10;zoom,.7;horizalign,left;diffuse,Color("Black");maxwidth,370);
			Text="DIFFICULTY HERE (Lv.??)";
		};
		Def.BitmapText{
			Name="NoteCount";
			Font="_halogen outline 20px";
			InitCommand=cmd(y,3;zoom,.7;horizalign,left;diffuse,Color("Black"));
			Text="?? notes";
		};
		Def.BitmapText{
			Name="StepsBy";
			Font="_halogen outline 20px";
			InitCommand=cmd(y,15;zoom,.5;horizalign,left;diffuse,Color("Black"));
			Text="Steps by a good writer";
		};
	};
end;

--The two part select...
local tps = Def.ActorFrame{
	InitCommand=cmd(visible,false);
	SongChosenMessageCommand=cmd(visible,true);
	TwoPartConfirmCanceledMessageCommand=cmd(visible,false);
	SongUnchosenMessageCommand=cmd(visible,false);
	--The page under the page.
	
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/page1");
		InitCommand=cmd(zoom,.4495;horizalign,left;vertalign,bottom;xy,SCREEN_CENTER_X+0.5,SCREEN_BOTTOM+2.25;);
	};
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/bookmark");
		InitCommand=cmd(zoom,.4475;vertalign,bottom;xy,SCREEN_CENTER_X+10,SCREEN_BOTTOM-93;);
	};
};

--[[
The difficulty list items...
Since I'm drawing 6 difficulty items each for num joined players, we have to add up to 12 items to the tps frame..
]]
for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	for i,diff in ipairs(Difficulty) do
		tps[#tps+1] = drawDiffListItem(diff,pn)..{
			InitCommand=cmd(xy,SCREEN_CENTER_X+32,SCREEN_CENTER_Y-206.85+i*60);
		};
	end;
end;

tps[#tps+1] = LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_TOP+60;visible,false;zoom,1;horizalign,left);
		SongChosenMessageCommand=cmd(visible,true);
		SongUnchosenMessageCommand=cmd(visible,false);
		OffCommand=cmd(decelerate,0.05;diffusealpha,0);
		Text="Select Difficulty",
	};
	
--The page that gets turned.
tps[#tps+1] = Def.Sprite{
	Texture=THEME:GetPathG("","Book/page1");
	InitCommand=cmd(zoom,.4495;horizalign,left;vertalign,bottom;xy,SCREEN_CENTER_X-0.25,SCREEN_BOTTOM+2.25;);
	SongChosenMessageCommand=function(self)
		self:zoomx(.4495):accelerate(.1):zoomx(0):queuecommand("page"):decelerate(.1):zoomx(-.4495)
	end;
	pageCommand=function(self)
		self:Load(THEME:GetPathG("","Book/page2"));
	end;
};

t[#t+1] = tps;

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		--The pen.
		t[#t+1] = Def.Sprite{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:zoom(0.35):rotationz(45):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y);
				else
					self:zoom(0.35):rotationz(-135):rotationy(180):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y);
				end
			end;
			SongChosenMessageCommand=cmd(finishtweening;decelerate,0.3;x,SCREEN_CENTER_X+440);
			SongUnchosenMessageCommand=cmd(finishtweening;decelerate,0.3;x,SCREEN_CENTER_X+800);
			CurrentSongChangedMessageCommand=cmd(finishtweening;x,SCREEN_CENTER_X+800);
			TwoPartConfirmCanceledMessageCommand=cmd(finishtweening;decelerate,0.3;x,SCREEN_CENTER_X+800);
			OffCommand=cmd(decelerate,1;x,SCREEN_CENTER_X+800);
			Texture=THEME:GetPathG("","Book/Selector_"..pname(pn));
			["CurrentSteps"..pname(pn).."ChangedMessageCommand"]=function(self)
				if not GAMESTATE:GetCurrentSteps(pn) then return end;
				local diff = Difficulty:Reverse()[GAMESTATE:GetCurrentSteps(pn):GetDifficulty()];
				self:finishtweening():addx(-60):decelerate(.12):addx(60):y(50+diff*60);
				if pn == PLAYER_2 then
					self:finishtweening():addx(-60):addy(80):decelerate(.12):addx(60):addy(-80):y(126+diff*60);
				end
			end;
		};
		t[#t+1] = Def.BitmapText{
			Font="_halogen 20px";
			InitCommand=cmd(zoom,0.7;diffusealpha,0;horizalign,right;xy,SCREEN_CENTER_X+800,SCREEN_CENTER_Y);
			SongChosenMessageCommand=cmd(finishtweening;x,SCREEN_CENTER_X+256;diffusealpha,1);
			SongUnchosenMessageCommand=cmd(finishtweening;diffusealpha,0);
			TwoPartConfirmCanceledMessageCommand=cmd(finishtweening;diffusealpha,0);
			OffCommand=cmd(diffusealpha,0);
			CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
			['CurrentSteps'..ToEnumShortString(pn)..'ChangedMessageCommand']=cmd(playcommand,"Set");
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				self:stoptweening();
				if not GAMESTATE:GetCurrentSteps(pn) then return end;
				local diff = Difficulty:Reverse()[GAMESTATE:GetCurrentSteps(pn):GetDifficulty()];
				self:finishtweening():y(80+diff*60);
				if pn == PLAYER_2 then
					self:finishtweening():y(93+diff*60);
				end

				local song = GAMESTATE:GetCurrentSong();
				if song and GAMESTATE:GetCurrentSteps(pn) then
					profile = PROFILEMAN:GetProfile(pn);
					scorelist = profile:GetHighScoreList(song,GAMESTATE:GetCurrentSteps(pn));
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					local topscore = scores[1];
	
					if topscore then
						text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
						if text == "100.00%" then
							text = "I love you";
						end;
					else
						text = "____";
					end;
					self:faderight(1);
					self:linear(0.1);
					self:faderight(0);
					self:settext(text);
				else
					self:settext("");
				end;
	
			end;
		};
end;

-- Stuff on the left
t[#t+1] = Def.ActorFrame {
	
	LoadActor("banner frame.png")..{
		InitCommand=cmd(zoom,0.525;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_TOP+122);
	};
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
		Texture= "sayori 2x1.png",
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
		Texture= "natsuki 2x1.png",
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
		Texture= "yuri 2x1.png",
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
		Texture= "monika 2x1.png",
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
				banner:scaletoclipped(145,145);
				banner:MaskDest();
			elseif song:HasBanner() then
				banner:visible(true);
				banner:Load(song:GetBannerPath());
				banner:scaletoclipped(265,106);
				banner:MaskDest();
				if IsGame("pump") then
					banner:visible(true);
					banner:Load(song:GetBannerPath());
					banner:scaletoclipped(205,145);
					banner:MaskDest();
				end
			elseif song:HasBackground() then
				banner:visible(true);
				banner:Load(song:GetBackgroundPath());
				banner:scaletoclipped(265,145);
				banner:MaskDest();
			else
				banner:visible(true);
				banner:Load(THEME:GetPathG("","Common fallback banner"));
				banner:scaletoclipped(265,145);
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
		OnCommand=cmd(x,SCREEN_CENTER_X-175;y,SCREEN_TOP+122;rotationz,-6;SetUpdateFunction,CDTitleUpdate);
		Def.Sprite {
			Name="Frame";
			InitCommand=cmd(zoom,0.525;MaskSource);
			Texture="banner glass.png"
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
		InitCommand=cmd(diffuseshift;effectcolor1,color("#525252");effectcolor2,color("#2e2e2e");effectclock,'beatnooffset';MaskDest;blend,Blend.Multiply;rotationz,-6;x,SCREEN_CENTER_X-175;y,SCREEN_TOP+122);
		CurrentSongChangedMessageCommand=function(self)
					self:scaletoclipped(265,145);
		end;
	};
	
end;

--Song Info Stuff
t[#t+1] = Def.ActorFrame{
	--PHONE GLARE
	LoadActor("banner shine.png")..{
		InitCommand=cmd(zoom,0.525;rotationz,-6;blend,Blend.Add;x,SCREEN_CENTER_X-175;y,SCREEN_TOP+122);
	};
	--STAGE DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,right;x,SCREEN_CENTER_X-36;y,SCREEN_CENTER_Y-4;zoom,0.8);
		OffCommand=cmd(visible,false);
		OnCommand=function(self)
			local stage = GAMESTATE:GetCurrentStage()
			self:settext(THEME:GetString("Stage",ToEnumShortString(stage)).." Poem");
		end;
	};
	--SORT DISPLAY
	LoadFont("_aller thin 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+140;y,SCREEN_BOTTOM-25;zoom,0.5;horizalign,left;diffuse,color("#552222"));
		SongChosenMessageCommand=cmd(visible,false);
		SongUnchosenMessageCommand=cmd(visible,true);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			local sort = GAMESTATE:GetSortOrder()
			self:settext("Sort: "..ToEnumShortString(sort));
		end;
	};
	--SONG GENRE
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_CENTER_X-312;y,SCREEN_CENTER_Y+26;zoom,0.8;maxwidth,350;diffuse,Color("Black"));
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "" then
				genre = "N/A"
			end
			self:settext("GENRE: "..genre);
		else
			self:settext("GENRE: N/A");
		end;
	end;
	};	
	--SONG LENGTH
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(horizalign,left;x,SCREEN_CENTER_X-312;y,SCREEN_CENTER_Y+56;zoom,0.8;maxwidth,620);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
		if GAMESTATE:GetCurrentSong() then
			local length = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
			self:settext("LENGTH: "..SecondsToMMSS(length));
		else
			self:settext("LENGTH: N/A");
		end;
	end;
	};	
	--SONG BPM
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_CENTER_X-312;y,SCREEN_CENTER_Y-4;zoom,0.8;maxwidth,2900);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)

			local song = GAMESTATE:GetCurrentSong();
			-- ROAD24: more checks,
			-- TODO: decide what to do if no song is chosen, ignore or hide ??
			if song then
				local speedvalue;
				if song:IsDisplayBpmRandom() then
					speedvalue = "unknown";
				else
					local rawbpm = GAMESTATE:GetCurrentSong():GetDisplayBpms();
					local lobpm = math.ceil(rawbpm[1]);
					local hibpm = math.ceil(rawbpm[2]);
					if lobpm == hibpm then
						speedvalue = hibpm
					else
						speedvalue = lobpm.."-"..hibpm
					end;
				end;
				self:settext("BPM: "..speedvalue);
			else
				self:settext("BPM: N/A");
			end;
		end;
	};
	-- HELP TEXT
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(faderight,1;x,SCREEN_CENTER_X+32;y,SCREEN_BOTTOM-50;zoom,0.5;horizalign,left;linear,0.5;faderight,0);
		SongChosenMessageCommand=cmd(finishtweening;linear,0.1;faderight,1);
		SongUnchosenMessageCommand=cmd(finishtweening;linear,0.5;faderight,0);
		OffCommand=cmd(decelerate,0.05;diffusealpha,0);
		Text="LEFT/RIGHT = Select Song     SHIFT+ENTER = Change Sort\nPress ENTER to choose a song.",
	};	
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_BOTTOM-140;zoom,0.5;horizalign,left;faderight,1);
		SongChosenMessageCommand=cmd(finishtweening;sleep,0.45;linear,0.5;faderight,0);
		SongUnchosenMessageCommand=cmd(finishtweening;linear,0.25;faderight,1);
		OffCommand=cmd(diffusealpha,0);
		Text="LEFT/RIGHT = Select Level     UP/DOWN = Cancel\nPress ENTER to confirm.",
	};
	-- HEADER TEXT
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_TOP+60;zoom,1;horizalign,left);
		SongChosenMessageCommand=cmd(visible,false);
		SongUnchosenMessageCommand=cmd(visible,true);
		OffCommand=cmd(decelerate,0.05;diffusealpha,0);
		Text="Select Music",
	};
};

t[#t+1] = Def.ActorFrame {
	OffCommand=function(s) SOUND:DimMusic(0,0.25) end,
	LoadActor(THEME:GetPathS("Common","Page Flip")) .. {
		CurrentSongChangedMessageCommand=cmd(stop;play);
	};
	--Lazy hack because I don't know how to make the bookmark stay behind the music wheel and the page when a song isn't picked...
	LoadActor("lazy")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-0.85;y,SCREEN_CENTER_Y-0.9);
		OnCommand=cmd(zoom,0.448);
		SongChosenMessageCommand=cmd(visible,false);
		SongUnchosenMessageCommand=cmd(visible,true);
	};
		
};


return t
