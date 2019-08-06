local DiffTab = { 
	["Difficulty_Beginner"] = 1,
	["Difficulty_Easy"] = 2,
	["Difficulty_Medium"] = 3,
	["Difficulty_Hard"] = 4,
	["Difficulty_Challenge"] = 5,
	["Difficulty_Edit"] = 6,
}

local function LoadSongs(Style)

	local AllCompSongs = {}
		
	for _, CurSong in pairs(SONGMAN:GetAllSongs()) do
		local DiffCon = {}
		local CurSongCon = {CurSong}		
		for i, CurStep in ipairs(CurSong:GetAllSteps()) do
			if string.find(CurStep:GetStepsType():lower(), Style) then
				DiffCon[tonumber(DiffTab[CurStep:GetDifficulty()])] = CurStep	
			end
		end
		
		local Keys = {}
		for k in pairs(DiffCon) do table.insert(Keys, k) end
		table.sort(Keys)
		
		for _, k in pairs(Keys) do
			if DiffCon[k] then
				CurSongCon[#CurSongCon+1] = DiffCon[k]
			end
		end
		
		if CurSongCon[2] then				
			AllCompSongs[#AllCompSongs+1] = CurSongCon
		end
	end	
	
	return AllCompSongs
end

local SongPos = 1
if not CurSong then CurSong = 1 end
local UnlockedInput = true

local function MovePage(self,offset,Songs)
	self:GetParent():GetChild("Page"):sleep(0.000001):zoomx(.4*offset):accelerate(.25):zoomx(0):decelerate(.25):zoomx(.4*(offset*-1))
end

local function MoveSelection(self,offset,Songs)
	UnlockedInput = false
	
	SongPos = SongPos + offset
	if SongPos < 1 then SongPos = 5 MovePage(self,offset,Songs) end
	if SongPos > 5 then SongPos = 1 MovePage(self,offset,Songs) end
	CurSong = CurSong + offset
	CurSong = CurSong + offset
	if CurSong > #Songs then CurSong = 1 end
	if CurSong < 1 then CurSong = #Songs end
	
	self:GetParent():GetChild("Selector"):decelerate(.1):y(100+(62*(SongPos-1)))
	
	SOUND:StopMusic()
	SOUND:PlayMusicPart(Songs[CurSong][1]:GetMusicPath(),Songs[CurSong][1]:GetSampleStart(),Songs[CurSong][1]:GetSampleLength(),0,0,true)
	self:sleep(.2):queuecommand("UnlockInput")
end

local function MusicWheel()
	local Songs = LoadSongs("dance_single")
	
	local t = Def.ActorFrame{
		OnCommand=function(self) 
			SCREENMAN:GetTopScreen():AddInputCallback(DDDAN.Input(self))
			self:sleep(1):queuecommand("PlayCurrentSong")
		end,
		PlayCurrentSongCommand=function(self)
			SOUND:PlayMusicPart(Songs[CurSong][1]:GetMusicPath(),Songs[CurSong][1]:GetSampleStart(),Songs[CurSong][1]:GetSampleLength(),0,0,true)
		end,
		MenuUpCommand=function(self) if UnlockedInput then MoveSelection(self,-1,Songs) end end,
		MenuDownCommand=function(self) if UnlockedInput then MoveSelection(self,1,Songs) end end,
		UnlockInputCommand=function() UnlockedInput = true end
	}
	
	return t
end

return Def.ActorFrame{
	Def.ActorFrame{
	
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/Table.png"),
			OnCommand=function(self) self:FullScreen() end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/Inside.png"),
			OnCommand=function(self) 
				self:halign(0)
					:zoom(.4)
					:CenterY()
					:x(SCREEN_CENTER_X-self:GetWidth()/2*.4)
			end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/Inside.png"),
			OnCommand=function(self) 
				self:halign(0)
					:zoomy(.4)
					:zoomx(0)
					:CenterY()
					:x(SCREEN_CENTER_X-self:GetWidth()/2*.4)
					:sleep(.5)
					:decelerate(.5)
					:zoomx(-.4)
			end
		},
		Def.Sprite{
			Name="Page",
			Texture=THEME:GetPathG("","Book/Page.png"),
			OnCommand=function(self) 
				self:halign(0)
					:x(SCREEN_CENTER_X-self:GetWidth()/2*.4)
					:CenterY()
					:zoom(.4)
			end
		},	
		MusicWheel(),
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/Front.png"),
			OnCommand=function(self) 
				self:halign(0)
					:zoom(.4)
					:CenterY()
					:x(SCREEN_CENTER_X-self:GetWidth()/2*.4)
					:accelerate(.5)
					:zoomx(0) 
			end
		},
		Def.Sprite{
			Name="Selector",
			Texture=THEME:GetPathG("","Book/Selector.png"),
			OnCommand=function(self) 
				self:xy(SCREEN_CENTER_X+100,-10)
					:halign(0)
					:valign(1)
					:zoom(.4)
					:sleep(.5)
					:decelerate(.5)
					:y(100)
			end
		}
	}
}