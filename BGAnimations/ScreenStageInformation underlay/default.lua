local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black"));
};
if GAMESTATE:IsCourseMode() then
	t[#t+1] = LoadActor("CourseDisplay");
else
	t[#t+1] = Def.Sprite {
		InitCommand=cmd(Center;diffusealpha,0);
		BeginCommand=cmd(LoadFromCurrentSongBackground);
		OnCommand=function(self)
			self:scale_or_crop_background()
			self:sleep(0.5)
			self:linear(0.50)
			self:diffusealpha(1)
			self:sleep(3)
		end;
	};
end

local stage_num_actor= THEME:GetPathG("ScreenStageInformation", "Stage " .. ToEnumShortString(sStage), true)
if stage_num_actor ~= "" and FILEMAN:DoesFileExist(stage_num_actor) then
	stage_num_actor= LoadActor(stage_num_actor)
else
	-- Midiman:  We need a "Stage Next" actor or something for stages after
	-- the 6th. -Kyz
	local curStage = GAMESTATE:GetCurrentStage();
	stage_num_actor= Def.BitmapText{
		Font= "Common Normal",  Text= thified_curstage_index(false) .. " Stage",
		InitCommand= function(self)
			self:zoom(1.5)
			self:strokecolor(Color.Black)
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end
	}
end

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","TextBox/background"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffuse,color("#fe80e0"));
		OnCommand=cmd(zoom,0.7;sleep,3;linear,0.5;diffusealpha,0);
	};
};
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","TextBox/frame"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170);
		OnCommand=cmd(zoom,0.7;sleep,3;linear,0.5;diffusealpha,0);
	};
};

t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+130;zoom,0.8);
  OnCommand=cmd();
  	
	LoadFont("Common Normal") .. {
		Text=GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=cmd(strokecolor,Color("Outline");skewx,-0.3;horizalign,left;maxwidth,520);
		OnCommand=cmd(sleep,3;linear,0.5;diffusealpha,0);
	};
	LoadFont("Common Normal") .. {
		Text=GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=cmd(strokecolor,Color("Outline");addy,20;skewx,-0.3;horizalign,left;maxwidth,520);
		OnCommand=cmd(sleep,3;linear,0.5;diffusealpha,0);
	};
};

return t
