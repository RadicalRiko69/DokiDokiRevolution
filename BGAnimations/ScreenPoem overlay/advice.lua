local poems = {
	"Here's Monika's Gaming Tip of the Day!\n\nHolding Shift+PrintScreen will save your screenshots in high quality.\nIf you want to save a poem for later, remember to use that combination. Some poems have secrets!\n\n\nSo let's take lots of pictures together!\n\n\n\nThanks for listening~!",
	"Look at the sky\nI'm still here\nI'll be alive next year\nI can make something good\n\n\n\nsomething good",
	"Hey.\n\n\n\n\n\n\n\n\n\n\nI love you.",
	"Here's Monika's Gaming Tip of the Day!\n\nIf you're ever feeling spicy, you can adjust the content severity on this theme by turning off Safe Mode!\nHowever, changing content severity may cause problems and show you things you may not want to see. If you decide to change your mind, you can change Safe Mode back on and have a normal experience!\n\n\n\nThanks for listening~!",
	"Here's Monika's Gaming Tip of the Day!\n\nIf you stay playing one song over and over, you'll barely improve your skills. Muscle memory is important but you have to consider other songs that may have more difficult patterns than your intended goal.\nBut always remember this; I believe in you!\n\nThanks for listening~!",
	"I wouldn't look there if I were you.\n\nBut I'm not your mom, do whatever you want but don't say I didn't warn you.",
	"Rhythm games are fun",
	"Hey, it's Sarena.\n\nWhy am I here? lmao",
	"Greetings, call me Cynthia if you want.\nI'm not entirely sure where I am right now.\nEveryone seems a bit off, except for that Sarena girl.\n\nAm I crazy or do these girls seem....unrealistic?",
	"Turn off Safe Mode, you won't.",
	"Play Sushi Violation, you won't regret it lol",
	"When I'm falling down\nWill you pick me up again?\nWhen I'm too far gone\nDead in the eyes of my friends\n\nTake me out of here\nTAKE ME OUT OF HERE\nT A K E\nM E\nO U T\nO F\nH E R E",
	"The mind is a labyrinth ladies & gentlemen...a puzzle. And while the paths of the brain are plainly visible, its ways deceptively apparent, its destinations are unknown. Its secrets still secret. And, if we are honest, it is the lure of the labyrinth that draws us to our chosen field to unlock those secrets.\nOthers have been here before us and have left us signs, but we, as explorers of the mind, must devote our lives and energies to going further to tread the unknown corridors in order to find ultimately, the final solution.\n\nWe have to see, we have to know.",
	"Heaven is a place I will always believe in cuz u make me feel, feel like loving you.",
	"In the next world, we'll meet again.\n\n\n\n\n\n\nI promise.",
	"Here's Monika's Gaming Tip of the Day!\n\nIf you are experiencing severe levels of discomfort while using this theme, uninstall the theme IMMEDIATELY. This theme not only contains horror elements while Safe Mode is turned off, but also contains very sensitive subjects.\nYou did read the waiver and GitHub page, right?\n\n\n\nAre you listening?",
	"Metal Heart\n\nA tale of two lovers from the future, they were soulmates, destined to be together. Until one day the heart of one became corrupted, the corruption set destruction towards the universe.\nThe world couldn't stop the corruption in sight, but only one person could. Reluctant, the soul ripped the heart out of the corrupted and ended the tyranny. The heart had turned metal, as if it never beated to the rhythm of love.\n\nThe aftermath left a scar on the world, creating the hate we see today. What was it, though? We will never know for sure.",
	"I call her, she cries away from me.\nI call her again, but the same cry she makes shoot at me like bullets.\nI called her once more, but there was silence.\nShe walked away, I suddenly stopped existing to her.\nI reach out my hand onto her shoulder, she screams at me.\n\nShe runs away as soon as I could catch her. I never saw her again, but it was still as if she was playing with the strings on my body.\nWhat was it? I don't get it. Did I find her or did she find me?",
};

local t = Def.ActorFrame{	
	LoadActor(THEME:GetPathG("","_BG/poem"))..{
		InitCommand=cmd(diffusealpha,0;zoom,0.666;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.5;linear,0.5;diffusealpha,1);
	};
}

t[#t+1] = Def.BitmapText{
    Font="_journal 40px",
    Name="TextActor",
    Text=poems[math.random(#poems)],
    OnCommand=function (self)
        self:Center();
		self:xy(SCREEN_CENTER_X-250,SCREEN_CENTER_Y-200);
		self:wrapwidthpixels(700);
		self:vertalign(0);
		self:horizalign(left);
		self:zoom(0.7);
		self:diffuse(Color("Black"));
    end,
}


return t