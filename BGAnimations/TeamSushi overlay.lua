return Def.ActorFrame {
	LoadFont("Common Normal")..{
		Text="Created by";
		InitCommand=cmd(Center;addy,-80);
	};
	OnCommand=function(self)
		self:sleep(4):queuecommand("Transition")
	end,
	TransitionCommand=function(self)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
	end,
	Def.Sprite{
		Texture=THEME:GetPathG("Team","Sushi/Team.png"),
        OnCommand=function(self)
			self:zoom(0.25)
				:xy(SCREEN_CENTER_X-30,SCREEN_CENTER_Y-400)
				:sleep(1)
				:linear(0.1)
				:addy(370)
				:sleep(0.05)
				:addy(-1)
				:sleep(0.05)
				:addy(1)
				:sleep(2)
				:linear(0.5)
				:diffusealpha(0)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("Team","Sushi/Sushi.png"),
		OnCommand=function(self)
			self:zoom(0.25)
				:xy(SCREEN_CENTER_X+30,SCREEN_CENTER_Y+400)
				:sleep(1)
				:linear(0.1)
				:addy(-370)
				:sleep(0.05)
				:addy(1)
				:sleep(0.05)
				:addy(-1)
				:sleep(2)
				:linear(0.5)
				:diffusealpha(0)
		end
	};
      
  	LoadFont("Common Normal")..{
		Text="in collaboration with";
		InitCommand=cmd(Center;addy,80);
	};
	  Def.Sprite{
        Name= "rl",
        InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_BOTTOM-100;cropright,1);
        OnCommand= cmd(sleep,1;decelerate,.5;cropright,0),
        Texture= THEME:GetPathG("Team","Sushi/RhythmLunatic"),
      },
};
