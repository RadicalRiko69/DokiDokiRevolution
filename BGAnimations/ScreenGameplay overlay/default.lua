local t = Def.ActorFrame {};

--Lifebar
Def.Quad{
    InitCommand=cmd(draworder,999;setsize,322,18;diffuse,color("#FF8805");cropleft,1);
    OnCommand=cmd(decelerate,1;cropleft,.5);
    LifeChangedMessageCommand=function(self,params)
        if params.Player == pn then    
            local lifeP1 = params.LifeMeter:GetLife();
            self:stoptweening():decelerate(.2):cropleft(1-lifeP1);
        end;
    end;
};
--FFFB7D
Def.Quad{
    InitCommand=cmd(draworder,999;setsize,322,18;diffuse,color("#FFFB7D");cropleft,1;faderight,1);
    OnCommand=cmd(decelerate,1;cropleft,.5);
    LifeChangedMessageCommand=function(self,params)
        if params.Player == pn then    
            local lifeP1 = params.LifeMeter:GetLife();
            self:stoptweening():decelerate(.2):cropleft(1-lifeP1);
        end;
    end;
};

return t;
