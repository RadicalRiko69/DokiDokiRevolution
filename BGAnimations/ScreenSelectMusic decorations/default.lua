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


--Difficulties, I guess
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
					local steps = song:GetOneSteps("StepsType_Dance_Single",diff);
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


t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("Common","Page Flip")) .. {
		CurrentSongChangedMessageCommand=cmd(stop;play);
	};
		
};


--The function that... Draws the items in the two part select list.
local CUR_STEPS_TYPE = GAMESTATE:GetCurrentStyle():GetStepsType();
function drawDiffListItem(difficulty)
	return Def.ActorFrame{
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
				self:GetChild("StepsBy"):settext("Steps By "..steps:GetAuthorCredit());
			else
				self:visible(false);
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=function(self)
			--local song = GAMESTATE:GetCurrentSong();
			--GAMESTATE:GetCurrentSong():GetOneSteps(CUR_STEPS_TYPE,difficulty) == GAMESTATE:GetCurrentSteps(PLAYER_1)
			--SCREENMAN:SystemMessage(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty());
			if GAMESTATE:GetCurrentSong():GetOneSteps(CUR_STEPS_TYPE,difficulty) == GAMESTATE:GetCurrentSteps(PLAYER_1) then
				self:GetChild("DifficultyAndMeter"):strokecolor(color("#ff9ef2"));
				self:GetChild("NoteCount"):strokecolor(color("#ff9ef2"));
				self:GetChild("StepsBy"):strokecolor(color("#ff9ef2"));
			else
				self:GetChild("DifficultyAndMeter"):NoStroke();
				self:GetChild("NoteCount"):NoStroke();
				self:GetChild("StepsBy"):NoStroke();
			end
			
		end;
		Def.BitmapText{
			Name="DifficultyAndMeter";
			Font="_aller thin 20px";
			InitCommand=cmd(y,-10;zoom,.7;horizalign,left;diffuse,Color("Black"));
			Text="DIFFICULTY HERE (Lv.??)";
		};
		Def.BitmapText{
			Name="NoteCount";
			Font="_aller thin 20px";
			InitCommand=cmd(y,3;zoom,.7;horizalign,left;diffuse,Color("Black"));
			Text="?? notes";
		};
		--Sorry, I couldn't help it.
		Def.BitmapText{
			Name="StepsBy";
			Font="_aller thin 20px";
			InitCommand=cmd(y,15;zoom,.5;horizalign,left;diffuse,Color("Black"));
			Text="Steps by Irisu Syndrome";
		};
	};
end;

--The two part select...
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(visible,false);
	SongChosenMessageCommand=cmd(visible,true);
	TwoPartConfirmCanceledMessageCommand=cmd(visible,false);
	SongUnchosenMessageCommand=cmd(visible,false);
	--The page under the page.
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/page1");
		InitCommand=cmd(zoom,.4475;horizalign,left;vertalign,bottom;xy,SCREEN_CENTER_X,SCREEN_BOTTOM;);
	
	};
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/bookmark");
		InitCommand=cmd(zoom,.4475;vertalign,bottom;xy,SCREEN_CENTER_X+10,SCREEN_BOTTOM-93;);
		
	};
	--The difficulty list items...
	drawDiffListItem('Difficulty_Beginner')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y-120);
	};
	drawDiffListItem('Difficulty_Easy')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y-60);
	};
	drawDiffListItem('Difficulty_Medium')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y);
	};
	drawDiffListItem('Difficulty_Hard')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y+60);
	};
	drawDiffListItem('Difficulty_Challenge')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y+120);
	};
	drawDiffListItem('Difficulty_Edit')..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+35,SCREEN_CENTER_Y+180);
	};
	
	--The pen.
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/Selector");
		InitCommand=cmd(zoom,.5;xy,SCREEN_CENTER_X+450,SCREEN_CENTER_Y);
		CurrentStepsP1ChangedMessageCommand=function(self)
			self:stoptweening();
			if not GAMESTATE:GetCurrentSteps(PLAYER_1) then return end;
			local diff = Difficulty:Reverse()[GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()];
			self:decelerate(.3):y(-95+diff*60);
			--SCREENMAN:SystemMessage(CUR_STEPS_TYPE..", "..GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()..", "..diff);
		end;
	};
	
	
	--The page that gets turned.
	Def.Sprite{
		Texture=THEME:GetPathG("","Book/page1");
		InitCommand=cmd(zoom,.4475;horizalign,left;vertalign,bottom;xy,SCREEN_CENTER_X,SCREEN_BOTTOM;);
		SongChosenMessageCommand=function(self)
			self:zoomx(.4475):accelerate(.25):zoomx(0):queuecommand("page"):decelerate(.25):zoomx(-.4475)
		end;
		pageCommand=function(self)
			self:Load(THEME:GetPathG("","Book/page2"));
		end;
	};

};


return t
