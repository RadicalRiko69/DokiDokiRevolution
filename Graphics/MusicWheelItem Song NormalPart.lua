--[[if not GAMESTATE:GetPreferredDifficulty(GAMESTATE:GetMasterPlayerNumber()) then
	SCREENMAN:SystemMessage("The preferred difficulty should have been set somewhere. Defaulting to Beginner.");
	GAMESTATE:SetPreferredDifficulty(PLAYER_1,"Difficulty_Beginner");
end;]]
local t = Def.ActorFrame{
	--[[LoadFont("Common Normal")..{
		InitCommand=cmd(xy,150,-5;horizalign,right);
		SetMessageCommand=function(self,param)
			if param.Song then
				if param.Song:HasStepsTypeAndDifficulty('StepsType_Dance_Single',GAMESTATE:GetPreferredDifficulty(GAMESTATE:GetMasterPlayerNumber())) then
					self:visible(true);
					self:settext("Lv."..param.Song:GetOneSteps('StepsType_Dance_Single',GAMESTATE:GetPreferredDifficulty(GAMESTATE:GetMasterPlayerNumber())):GetMeter());
				end;
			else
				self:visible(false);
			end;
		end;
		PreferredDifficultyP1ChangedMessageCommand=function(self)
			self:diffuse(GameColor["Difficulty"][ToEnumShortString(GAMESTATE:GetPreferredDifficulty(GAMESTATE:GetMasterPlayerNumber()))]);
		end;
	};]]
};

return t;
