local function PercentScore( pn )
	local t = LoadFont("_halogen 20px")..{
		InitCommand=cmd(zoom,1.1;player,pn);
		BeginCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			-- todo: color by difficulty
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse()
				StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
			else
				SongOrCourse = GAMESTATE:GetCurrentSong()
				StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
			end;
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				local cd = GetCustomDifficulty(st, diff, courseType);
				self:diffuse(CustomDifficultyToColor(cd));
			end

			local pss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn);
			if pss then
				local pct = pss:GetPercentDancePoints();
				if pct == 1 then
					self:settext("100%");
				else
					self:settext(FormatPercentScore(pct));
				end;
			end;
		end;
	};
	return t;
end

local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");


if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(PlayerNumber) do
		local t2 = Def.StepsDisplay {
			InitCommand=cmd(Load,"StepsDisplayEvaluation",pn;SetFromGameState,pn;);
			UpdateNetEvalStatsMessageCommand=function(self,param)
				if GAMESTATE:IsPlayerEnabled(pn) then
					self:SetFromSteps(param.Steps)
				end;
			end;
		};
		t[#t+1] = StandardDecorationFromTable( "StepsDisplay" .. ToEnumShortString(pn), t2 );
		t[#t+1] = StandardDecorationFromTable( "PercentScore" .. ToEnumShortString(pn), PercentScore(pn) );
	end
end

local song = GAMESTATE:GetCurrentSong();

t[#t+1] = Def.ActorFrame{

	LoadFont("_halogen 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-176;y,SCREEN_CENTER_Y-120;maxwidth,250;zoom,1;diffuse,color("#000000"));
		OnCommand=function(self)
			if song:GetDisplaySubTitle() == "" then
				self:settext(song:GetDisplayMainTitle());
			else
				self:settext(song:GetDisplayMainTitle().." "..song:GetDisplaySubTitle());
			end
		end
	};
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-176;y,SCREEN_CENTER_Y-100;maxwidth,360;zoom,0.6;diffuse,color("#000000"));
		Text=song:GetDisplayArtist()
	};
};

return t
