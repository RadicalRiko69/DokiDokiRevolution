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



--Difficulties, I guess
--This is up here so it gets covered by the two part select.
for i,diff in ipairs(Difficulty) do
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(xy,SCREEN_CENTER_X-310,SCREEN_BOTTOM-235+15*i);
		LoadFont("_halogen 20px")..{
			Text=THEME:GetString("CustomDifficulty",ToEnumShortString(diff));
			InitCommand=cmd(horizalign,left);
		};
		LoadFont("_halogen 20px")..{
			Text="??";
			InitCommand=cmd(horizalign,right;addx,275);
			OnCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				if song then
					local steps = song:GetOneSteps(CUR_STEPS_TYPE,diff);
					if steps then
						self:visible(true);
						self:settext(steps:GetMeter())
					else
						self:visible(false);
					end;
				else
					self:visible(false);
				end;
			end;
			CurrentSongChangedMessageCommand=cmd(playcommand,"On");
		
		};
	}
end;

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
		--OnCommand=cmd(cropright,1);
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
				--self:GetChild("NoteCount"):settext("
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
			--self:cropright(1);
			--local song = GAMESTATE:GetCurrentSong();
			--GAMESTATE:GetCurrentSong():GetOneSteps(CUR_STEPS_TYPE,difficulty) == GAMESTATE:GetCurrentSteps(PLAYER_1)
			--SCREENMAN:SystemMessage(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty());
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
			end;
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
		--Sorry, I couldn't help it.
		Def.BitmapText{
			Name="StepsBy";
			Font="_halogen outline 20px";
			InitCommand=cmd(y,15;zoom,.5;horizalign,left;diffuse,Color("Black"));
			Text="Steps by Irisu Syndrome";
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
			InitCommand=cmd(xy,SCREEN_CENTER_X+32,SCREEN_CENTER_Y-180+i*60);
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
		self:zoomx(.4495):accelerate(.25):zoomx(0):queuecommand("page"):decelerate(.25):zoomx(-.4495)
	end;
	pageCommand=function(self)
		self:Load(THEME:GetPathG("","Book/page2"));
	end;
};

t[#t+1] = tps;

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	--The pen.
	t[#t+1] = Def.Sprite{
		Texture=THEME:GetPathG("","Book/Selector_"..pname(pn));
		InitCommand=cmd(zoom,.5;xy,SCREEN_CENTER_X+800,SCREEN_CENTER_Y);
		SongChosenMessageCommand=cmd(decelerate,0.3;x,SCREEN_CENTER_X+450);
		SongUnchosenMessageCommand=cmd(decelerate,0.3;x,SCREEN_CENTER_X+800);
		TwoPartConfirmCanceledMessageCommand=cmd(decelerate,0.3;x,SCREEN_CENTER_X+800);
		["CurrentSteps"..pname(pn).."ChangedMessageCommand"]=function(self)
			self:stoptweening();
			if not GAMESTATE:GetCurrentSteps(pn) then return end;
			local diff = Difficulty:Reverse()[GAMESTATE:GetCurrentSteps(pn):GetDifficulty()];
			self:decelerate(.3):y(-95+diff*60);
			--SCREENMAN:SystemMessage(CUR_STEPS_TYPE..", "..GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()..", "..diff);
		end;
	};
end;

-- Stuff on the left
t[#t+1] = Def.ActorFrame {

	LoadActor("banner frame.png")..{
		InitCommand=cmd(zoom,0.4;x,SCREEN_CENTER_X-175;y,SCREEN_TOP+110);
	};

	Def.Sprite{
		Name= "Sayori",
		Condition=(not GAMESTATE:IsExtraStage()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-285;y,SCREEN_BOTTOM-72;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "sayori 2x1.png",
	},

	Def.Sprite{
		Name= "Natsuki",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-215;y,SCREEN_BOTTOM-70;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "natsuki 2x1.png",
	},

	Def.Sprite{
		Name= "Yuri",
		Condition=(not GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-147;y,SCREEN_BOTTOM-70;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "yuri 2x1.png",
	},

	Def.Sprite{
		Name= "Monika",
		Condition=(not GAMESTATE:IsExtraStage2()),
		InitCommand= cmd(zoom,0.35;x,SCREEN_CENTER_X-70;y,SCREEN_BOTTOM-72;animate,false),
		OnCommand=cmd(stoptweening;setstate,0),
		OffCommand=cmd(setstate,1;decelerate,.145;addy,-30;accelerate,.145;addy,30;decelerate,.145;addy,-30;accelerate,.145;addy,30;queuecommand,"ResetAnim"),
		ResetAnimCommand=cmd(setstate,0);
		Texture= "monika 2x1.png",
	},
};

--Song Info Stuff
t[#t+1] = Def.ActorFrame{

	--GENRE DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-150;y,SCREEN_CENTER_Y-40;zoom,0.7);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("GENRE:");
		end;
	};
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_CENTER_X-125;y,SCREEN_CENTER_Y-40;zoom,0.7;maxwidth,130);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
			local genre = GAMESTATE:GetCurrentSong():GetGenre()
			if genre == "" then
				genre = "N/A"
			end
			self:settext(genre);
		else
			self:settext("N/A");
		end;
	end;
	};	

	--STAGE DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_CENTER_X-170;y,SCREEN_CENTER_Y-26;zoom,0.7);
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
	
	--LENGTH DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_CENTER_Y-26;zoom,0.7);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("LENGTH:");
			(cmd(finishtweening;zoom,0.7)) (self)
		end;
	};

	LoadFont("_halogen 20px")..{
		InitCommand=cmd(horizalign,left;x,SCREEN_CENTER_X-260;y,SCREEN_CENTER_Y-26;zoom,0.7;maxwidth,120);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
		if GAMESTATE:GetCurrentSong() then
			local length = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
			self:settext(SecondsToMMSS(length));
		else
			self:settext("N/A");
		end;
	end;
	};	

	--BPM DISPLAY
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-300;y,SCREEN_CENTER_Y-40;zoom,0.7);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("BPM:");
		end;
	};
	
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_CENTER_X-280;y,SCREEN_CENTER_Y-40;zoom,0.7;maxwidth,100);
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
				self:settext(speedvalue);
			else
				self:settext("N/A");
			end;
		end;
	};

	-- HELP TEXT
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X+32;y,SCREEN_BOTTOM-50;zoom,0.5;horizalign,left);
		SongChosenMessageCommand=cmd(visible,false);
		SongUnchosenMessageCommand=cmd(visible,true);
		OffCommand=cmd(decelerate,0.05;diffusealpha,0);
		Text="LEFT/RIGHT = Select Song     SHIFT+ENTER = Change Sort\nPress ENTER to choose a song.",
	};
	
	LoadFont("_halogen 20px")..{	
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_BOTTOM-140;diffusealpha,0;zoom,0.5;horizalign,left);
		SongChosenMessageCommand=cmd(sleep,0.435;diffusealpha,1);
		SongUnchosenMessageCommand=cmd(diffusealpha,0);
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
	LoadActor(THEME:GetPathS("Common","Page Flip")) .. {
		CurrentSongChangedMessageCommand=cmd(stop;play);
	};

	--Lazy hack because I don't know how to make the bookmark stay behind the music wheel and the page when a song isn't picked...
	LoadActor("lazy")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-0.45;y,SCREEN_CENTER_Y);
		OnCommand=cmd(zoom,0.45);
	};
		
};


return t
