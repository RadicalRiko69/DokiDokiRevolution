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
local OldSongs = {{},{}}

local function MovePage(self,offset,Songs)
	self:GetParent():GetChild("Page"):zoomx(offset):accelerate(.25):zoomx(0):decelerate(.25):zoomx(offset*-1)
	if offset > 0 then
		self:GetParent():GetChild("Page"):GetChild("Page"):playcommand("Page"):sleep(.25):queuecommand("Page2")
		self:GetParent():GetChild("Page"):GetChild("SongText"):diffusealpha(1):sleep(.25):diffusealpha(0)
		self:GetParent():GetChild("Page"):GetChild("BannerCon"):diffusealpha(0):sleep(.25):diffusealpha(1)
		for i = 1,6 do
			pos = CurSong+i
			if pos > #Songs then pos = (CurSong+i)-#Songs end
			if pos < 1 then pos = #Songs+(CurSong+i) end
			self:GetParent():GetChild("Page"):GetChild("SongText"):GetChild("Song"..i):GetChild("Title"):settext(OldSongs[i][1])		
			self:GetParent():GetChild("Page2"):GetChild("SongText"):GetChild("Song"..i):GetChild("Title"):settext(Songs[pos][1]:GetDisplayMainTitle())
			self:GetParent():GetChild("Page"):GetChild("SongText"):GetChild("Song"..i):GetChild("Artist"):settext(OldSongs[i][2])		
			self:GetParent():GetChild("Page2"):GetChild("SongText"):GetChild("Song"..i):GetChild("Artist"):settext(Songs[pos][1]:GetDisplayArtist())
			OldSongs[i] = {Songs[pos][1]:GetDisplayMainTitle(),Songs[pos][1]:GetDisplayArtist()}
		end
	else
		self:GetParent():GetChild("Page"):GetChild("Page"):playcommand("Page2"):sleep(.25):queuecommand("Page")
		self:GetParent():GetChild("Page"):GetChild("SongText"):diffusealpha(0):sleep(.25):diffusealpha(1)
		self:GetParent():GetChild("Page"):GetChild("BannerCon"):diffusealpha(1):sleep(.25):diffusealpha(0)
		for i = 1,6 do
			pos = CurSong+i-7
			if pos > #Songs then pos = (CurSong+i-7)-#Songs end
			if pos < 1 then pos = #Songs+(CurSong+i-7) end
			self:GetParent():GetChild("Page2"):GetChild("SongText"):GetChild("Song"..i):GetChild("Title"):settext(OldSongs[i][1])		
			self:GetParent():GetChild("Page"):GetChild("SongText"):GetChild("Song"..i):GetChild("Title"):settext(Songs[pos][1]:GetDisplayMainTitle())
			self:GetParent():GetChild("Page2"):GetChild("SongText"):GetChild("Song"..i):GetChild("Artist"):settext(OldSongs[i][2])		
			self:GetParent():GetChild("Page"):GetChild("SongText"):GetChild("Song"..i):GetChild("Artist"):settext(Songs[pos][1]:GetDisplayArtist())
			OldSongs[i] = {Songs[pos][1]:GetDisplayMainTitle(),Songs[pos][1]:GetDisplayArtist()}
		end
	end
	self:sleep(.5):queuecommand("UnlockInput")
end

local function MoveSelection(self,offset,Songs)
	UnlockedInput = false
	UpdateBanner = 0
	
	SongPos = SongPos + offset
	if SongPos < 1 then SongPos = 6 MovePage(self,offset,Songs) UpdateBanner = offset end
	if SongPos > 6 then SongPos = 1 MovePage(self,offset,Songs) UpdateBanner = offset end
	CurSong = CurSong + offset
	if CurSong > #Songs then CurSong = 1 end
	if CurSong < 1 then CurSong = #Songs end
	
	self:GetParent():GetChild("Selector"):decelerate(.1):y(160+(53*(SongPos-1)))
	
	local Banner = Songs[CurSong][1]:GetBannerPath()
	
	if not Songs[CurSong][1]:HasBanner() then
		Banner = THEME:GetPathG("Common fallback","banner.png")
	end
	
	if UpdateBanner ~= 1 then
	self:GetParent():GetChild("Left"):GetChild("BannerCon"):GetChild("Banner"):Load(Banner)
		:zoom(DDDAN.Resize(self:GetParent():GetChild("Left"):GetChild("BannerCon"):GetChild("Banner"):GetWidth(),self:GetParent():GetChild("Left"):GetChild("BannerCon"):GetChild("Banner"):GetHeight(),192,60))
	end
	if UpdateBanner ~= -1 then
	self:GetParent():GetChild("Page"):GetChild("BannerCon"):GetChild("Banner"):Load(Banner)
		:zoom(DDDAN.Resize(self:GetParent():GetChild("Page"):GetChild("BannerCon"):GetChild("Banner"):GetWidth(),self:GetParent():GetChild("Page"):GetChild("BannerCon"):GetChild("Banner"):GetHeight(),192,60))
	end
	
	SOUND:StopMusic()
	SOUND:PlayMusicPart(Songs[CurSong][1]:GetMusicPath(),Songs[CurSong][1]:GetSampleStart(),Songs[CurSong][1]:GetSampleLength(),0,0,true)
	self:sleep(.2):queuecommand("UnlockInput")
end

local Songs = LoadSongs("dance_single")

local function MusicWheel()
	
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

local SongText = Def.ActorFrame{
	Name="SongText"
}

for i = 1,6 do
	local pos = CurSong+i-1
	if pos > #Songs then pos = (CurSong+i)-#Songs end
	if pos < 1 then pos = #Songs+(CurSong+i) end
	SongText[#SongText+1] =	Def.ActorFrame{
		Name="Song"..i,
		Def.BitmapText{
			Name="Title",
			Text=Songs[pos][1]:GetDisplayMainTitle(),
			OnCommand=function(self)		
				self:diffuse(0,0,0,1) 
					:halign(0)
					:xy(30,-112+(53*(i-1)))
					:zoom(.6)
					:maxwidth(400)
			end
		},
		Def.BitmapText{
			Name="Artist",
			Text=Songs[pos][1]:GetDisplayArtist(),
			OnCommand=function(self)		
				self:diffuse(0,0,0,1) 
					:halign(0)
					:xy(30,-96+(53*(i-1)))
					:zoom(.6)
					:maxwidth(400)
			end
		},
		
	}
	OldSongs[i] = {Songs[pos][1]:GetDisplayMainTitle(),Songs[pos][1]:GetDisplayArtist()}
end

return Def.ActorFrame{
	Def.ActorFrame{
	
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/Table.png"),
			OnCommand=function(self) self:FullScreen() end
		},
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/right.png"),
			OnCommand=function(self) 
				self:halign(0)
					:zoom(.4)
					:xy(SCREEN_CENTER_X-self:GetWidth()/4*.4,SCREEN_BOTTOM-self:GetHeight()/2*.4)
			end
		},
		Def.ActorFrame{
			Name="Left",
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X-798/4*.4,SCREEN_BOTTOM-1042/2*.4)
					:zoomx(0)
					:sleep(.5)
					:decelerate(.5)
					:zoomx(1)
			end,
			Def.Sprite{
				Texture=THEME:GetPathG("","Book/left.png"),
				OnCommand=function(self) 
					self:halign(1)
						:zoom(.4)						
				end
			},
			Def.ActorFrame{
				Name="BannerCon",
				Def.Sprite{
					Texture=THEME:GetPathG("banner","frame.png"),
					OnCommand=function(self)
						self:xy(-150,-100):zoom(.45)
					end
				},
				Def.Sprite{
					Name="Banner",
					Texture=Songs[CurSong][1]:GetBannerPath(),
					OnCommand=function(self)
						if not Songs[CurSong][1]:HasBanner() then
							self:Load(THEME:GetPathG("Common fallback","banner.png"))
						end
					
						self:zoom(DDDAN.Resize(self:GetWidth(),self:GetHeight(),192,60))
							:xy(-150,-100):rotationz(-6)
					end
				}
			},
		},
		Def.ActorFrame{
			Name="Page2",
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X-798/4*.4,SCREEN_BOTTOM-1042/2*.4)
			end,
			SongText
		},	
		Def.ActorFrame{
			Name="Page",
			OnCommand=function(self)
				self:xy(SCREEN_CENTER_X-798/4*.4,SCREEN_BOTTOM-1042/2*.4)
			end,
			Def.Sprite{
				Name="Page",
				Texture=THEME:GetPathG("","Book/page.png"),
				OnCommand=function(self) 
					self:halign(0)
						:zoom(.4)
				end,
				PageCommand=function(self) self:Load(THEME:GetPathG("","Book/Page.png")) end,
				Page2Command=function(self) self:Load(THEME:GetPathG("","Book/Page2.png")) end
			},
			Def.ActorFrame{
				Name="BannerCon",
				OnCommand=function(self) self:zoomx(-1):diffusealpha(0) end,
				Def.Sprite{
					Texture=THEME:GetPathG("banner","frame.png"),
					OnCommand=function(self)
						self:xy(-150,-100):zoom(.45)
					end
				},
				Def.Sprite{
					Name="Banner",
					Texture=Songs[CurSong][1]:GetBannerPath(),
					OnCommand=function(self)
						if not Songs[CurSong][1]:HasBanner() then
							self:Load(THEME:GetPathG("Common fallback","banner.png"))
						end
					
						self:zoom(DDDAN.Resize(self:GetWidth(),self:GetHeight(),192,60))
							:xy(-150,-100):rotationz(-6)
					end
				},
			},
			SongText
		},	
		MusicWheel(),
		Def.Sprite{
			Texture=THEME:GetPathG("","Book/cover.png"),
			OnCommand=function(self) 
				self:halign(0)
					:zoom(.4)
					:xy(SCREEN_CENTER_X-self:GetWidth()/4*.4,SCREEN_BOTTOM-self:GetHeight()/2*.4)
					:accelerate(.5)
					:zoomx(0) 
			end
		},
		Def.Sprite{
			Name="Selector",
			Texture=THEME:GetPathG("","Book/Selector.png"),
			OnCommand=function(self) 
				self:xy(SCREEN_CENTER_X+200,-10)
					:halign(0)
					:valign(1)
					:zoom(.4)
					:sleep(.5)
					:decelerate(.5)
					:y(160)
			end
		}
	}
}