return Def.ActorFrame{
    Def.Sprite{
        InitCommand=function(self)
            if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
                self:Load(THEME:GetPathG("","_BG/extra"));
            elseif ThemePrefs.Get("Target") == "Caught" then
                self:Load(THEME:GetPathG("","_BG/ghostbook"));
            else
                self:Load(THEME:GetPathG("","_BG/notebook"));                
            end;
            self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y);
            self:zoom(.45);
        end;
    }
}