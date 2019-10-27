return Def.ActorFrame{

	LoadFont("_aller 20px")..{
		Text="Dialogue Text: 1234567890\nABCDEFGHIJKLMNOPQRSTUVWXYZ";
		InitCommand=cmd(Center;addy,-100;shadowcolor,color("0,0,0,1");shadowlengthx,3;shadowlengthy,3);
	};
	
	Def.BitmapText{
		Font="_aller 20px";
		Text="This is a wrapping test.";
		InitCommand=cmd(xy,SCREEN_RIGHT-100,SCREEN_CENTER_Y;wrapwidthpixels,25;shadowcolor,color("0,0,0,1");shadowlengthx,3;shadowlengthy,3);
	
	};

	LoadFont("Combo Numbers")..{
		Text="1234567890";
		InitCommand=cmd(Center;shadowcolor,color("0,0,0,1");shadowlengthx,3;shadowlengthy,3);
	};
	
	LoadFont("Common Label")..{
		Text="Common Label: 1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		InitCommand=cmd(Center;addy,100;shadowcolor,color("0,0,0,1");shadowlengthx,3;shadowlengthy,3);
	};
	
	LoadFont("_timer numbers")..{
		Text="1234567890";
		InitCommand=cmd(Center;addy,150;shadowcolor,color("0,0,0,1"););
	};

	--[[LoadFont("Common Normal")..{
		Text="MBSTATE Testing...";
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-100);
			assert(MBSTATE, "MBSTATE doesn't exist?!");
			MBSTATE:SetCharacter(PLAYER_1, "Arcueid");
			MBSTATE:SetRandomEncounterList({"item 1","item 2","item 3","item 4"});
			MBSTATE:SetEnemyCharacter(MBSTATE:GetRandomEncounter());
		end;
	};]]
	--[[LoadFont("Common Normal")..{
		Text="MBSTATE Player 2 info: "..MBSTATE:GetCharacter(PLAYER_2);
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-80);
		end;
	};]]
	
	--[[LoadActor("Here comes a new challenger")..{
		CodeMessageCommand=function(self, param)
			if param.Name == "Select" then
				MESSAGEMAN:Broadcast("NewChallenger");
				--SCREENMAN:SystemMessage("NCTest");
			else
				MESSAGEMAN:Broadcast(param.Name);
			end;
		end;
	
	};]]
};
