local vStats = STATSMAN:GetCurStageStats();

local function CreateStats( pnPlayer )
	-- Actor Templates
	local aLabel = LoadFont("_halogen 20px") .. { InitCommand=cmd(zoom,0.5;horizalign,left); };
	local aText = LoadFont("_halogen 20px") .. { InitCommand=cmd(zoom,0.5;horizalign,left); };
	-- DA STATS, JIM!!
	local pnStageStats = vStats:GetPlayerStageStats( pnPlayer );
	-- Organized Stats.
	local tStats = {
		W1			= pnStageStats:GetTapNoteScores('TapNoteScore_W1');
		W2			= pnStageStats:GetTapNoteScores('TapNoteScore_W2');
		W3			= pnStageStats:GetTapNoteScores('TapNoteScore_W3');
		W4			= pnStageStats:GetTapNoteScores('TapNoteScore_W4');
		W5			= pnStageStats:GetTapNoteScores('TapNoteScore_W5');
		Miss		= pnStageStats:GetTapNoteScores('TapNoteScore_Miss');
		--HitMine		= pnStageStats:GetTapNoteScores('TapNoteScore_HitMine');
		--AvoidMine	= pnStageStats:GetTapNoteScores('TapNoteScore_AvoidMine');
		--Held		= pnStageStats:GetHoldNoteScores('HoldNoteScore_Held');
		--LetGo		= pnStageStats:GetHoldNoteScores('HoldNoteScore_LetGo');
	};
end;

local t = Def.ActorFrame {};
GAMESTATE:IsPlayerEnabled(PLAYER_1)
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(hide_if,not GAMESTATE:IsPlayerEnabled(PLAYER_1);x,WideScale(math.floor(SCREEN_CENTER_X*0.3)-8,math.floor(SCREEN_CENTER_X*0.5)-8);y,SCREEN_CENTER_Y-20);
	CreateStats( PLAYER_1 );
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(hide_if,not GAMESTATE:IsPlayerEnabled(PLAYER_2);x,WideScale(math.floor(SCREEN_CENTER_X*1.7)+8,math.floor(SCREEN_CENTER_X*1.5)+8);y,SCREEN_CENTER_Y-20);
	CreateStats( PLAYER_2 );
};

return t
