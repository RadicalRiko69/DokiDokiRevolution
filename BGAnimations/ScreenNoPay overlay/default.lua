return Def.ActorFrame{
	LoadActor("glitch")..{
		InitCommand=cmd(Center;zoom,0.5;vibrate;effectmagnitude,2,2,2);
	};
	LoadFont("_aller thin 20px")..{
        Text="Coin Mode/Arcade use is prohibited on this theme.\nDo not use use this theme commercially as this is free to download for everybody!\nPlease go back into the service menu by pressing Scroll Lock to change the game back to Home Mode.";
        InitCommand=cmd(Center;wrapwidthpixels,SCREEN_WIDTH;zoom,.85;strokecolor,color("#fe81ae"));
    };
}
