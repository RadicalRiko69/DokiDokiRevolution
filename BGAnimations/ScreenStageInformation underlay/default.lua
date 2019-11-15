local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

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
			self:linear(0.25)
			self:diffusealpha(1)
			self:sleep(3)
		end;
	};
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
