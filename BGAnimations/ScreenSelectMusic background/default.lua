return Def.ActorFrame{
    Def.Sprite{
        InitCommand=function(self)
            if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
                self:Load(THEME:GetPathG("","_BG/extra"));
            elseif ThemePrefs.Get("Target") == "Caught" and ThemePrefs.Get("Severity") == "Intense" then
                self:Load(THEME:GetPathG("","_BG/ghostbook"));
            else
                self:Load(THEME:GetPathG("","_BG/notebook"));                
            end;
            self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y);
            self:zoom(.45);
        end;
    },
    Def.Quad {
	    InitCommand=cmd(diffuse,color("#ffff00");scaletoclipped,300,28;diffusealpha,0.5;x,SCREEN_CENTER_X+178;y,SCREEN_CENTER_Y-4;faderight,0.5);
	    SongChosenMessageCommand=cmd(linear,0.1;faderight,1);
	    SongUnchosenMessageCommand=cmd(linear,0.1;faderight,0.5);
    }
}