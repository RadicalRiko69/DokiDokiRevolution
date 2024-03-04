local player = ...
local alignment = 0;
if player == "PlayerNumber_P2" then alignment = 1 end;

local t = Def.ActorFrame{}

local spacing = 44;
local itembaseX = -20
local itembaseY = 20
local delay = 0.0
local labelZoomX = 0.375
local labelZoomY = 0.35
local numberZoom = 1;
		
local marvel = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W1")+
		STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_CheckpointHit");
local perfects = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W2");

local greats = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W3");
local goods = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W4");
local bads = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W5");

local misses = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_Miss")+
		STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_CheckpointMiss");

local combo = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo();

--local score = 	scorecap(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetScore());

local digits = string.len(math.max(perfects,greats,goods,bads,misses,combo));
if digits < 3 then digits = 0 end;

t[#t+1] = Def.ActorFrame{

	

	--MARVELOUS
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(diffusealpha,0;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(perfects);
				};
			self:AddAttribute(0,attr);
		end;
		Text=marvel;
	};
	--PERFECTS
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing;diffusealpha,0;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(perfects);
				};
			self:AddAttribute(0,attr);
		end;
		Text=perfects;
	};

	--GREATS
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing*2;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(greats);
				};
			self:AddAttribute(0,attr);
		end;
		Text=greats;
	};

	--GOODS
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing*3;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(goods);
				};
			self:AddAttribute(0,attr);
		end;
		Text=goods;
	};

	--BADS
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing*4;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(bads);
				};
			self:AddAttribute(0,attr);
		end;
		Text=bads;
	};

	--MISSES
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing*5;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(misses);
					Diffuse = color("#FF0000FF");
				};
			self:AddAttribute(0,attr);
		end;
		Text=misses;
	};

	--COMBO
	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,1000;zoom,numberZoom);
		OnCommand=cmd(y,spacing*6;diffusealpha,1;playcommand,"Cap");
		CapCommand=function(self)
				local attr = {
					Length = digits-string.len(combo);
				};
			self:AddAttribute(0,attr);
		end;
		Text=combo;
	};

	--SCORE

	LoadFont("_halogen 20px")..{
		InitCommand=cmd(maxwidth,320;zoom,numberZoom);
		OnCommand=cmd(y,spacing*7;decelerate,0.3;diffusealpha,1);
		Text=score;
	}
}


return t
