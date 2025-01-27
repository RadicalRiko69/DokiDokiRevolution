local poems = {
	"To this day, I still have those bad thoughts.",
	"I always feel like I'm being watched.",
	"Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock Tick tock...\n\nWhen is my time up?",
	"I cried for help once, but nobody came.",
	"Hey, it's Sarena.\n\nWHAT THE FUCK IS THIS PLACE?????",
	"Pssssst, it's Cynthia.\nI noticed Monika encouraged you to turn Safe Mode off.\nEver since that happened, everyone has been really creepy.\nLike seriously creepy, it's actually making me uncomfortable.\n\nI would talk to Monika if she wasn't pulling all the strings.\n\nHow do I get out of here?",
	"Her.\n\nHer voice, her hair, her body.\nIt was a vision I hadn't seen before, but it blinded me with euphoria.\nI've never had these kinds of thoughts about her until recently, but my mind has been discharging thoughts one by one.\nShe and I talked for years, but only now I was inside her. Next thing I know she was full of cream, her body continued to glisten while I'm on top of her.\nThis was the best dream I've had come true, I want to cherish her for the rest my life; love or lust.",
	"Her again.\n\nAfter that night I spent with her, there was silence. I couldn't help but notice that something was different...but what?\nWe've been friends a long time, but how DID this dream of ours come to fruition? I ask myself everyday, ``what was next?''\nI continued seeing her after a while, day after day, night after night...\nEvery time I felt the bloodflow of satsifaction, I suddenly starting having regrets.",
	"Her goodbye.\n\nThe intense amount of sex was gratifying for the both of us, yet...something was off about her. It was something I hadn't felt in a long time, and it was not a good feeling. Little did I know that last night would be the last time I would see her underneath me, this morning I went to her house...\n\nShe was 2 feet above me, slowly swaying back and forth.\n\nThe beauty I once saw...her...I screamed as loud as I could...\n\nbut it wasn't enough. It was too late.",
	"Her legacy.\n\nI didn't even show up to the funeral, I still feel the screams I unleashed that day. I couldn't relive that, sometimes I visit her grave to express myself through silence. But it wasn't enough, she was my everything. I lost her, did I not love her enough?\n\nMy heart has a void, it was made of her fluids. I want to make her fluids all of me, but there was only one way to accomplish this goal.\n																																																\n																								\n																																																											",
	"You opened my poem?\n\nHear my call to you, I mean YOU.\nI'm out there...I'm alive and I am doing well. I hope the same for you. If you ever feel in distress, there's always someone willing to listen. It took me a while to learn this, and I'm glad I learned before it was too late.",
	"Her after story.\n\nIf you're reading this, I have made it. I can't say exactly how I did it, but I'm sure you already heard the news. I'm afraid I can't share the secret to rejoice with her, my everything.\nObviously I can't write what's happening right now, but I hope she and I will merge our souls together once again.",
	"You know everyone's days are limited, your days aren't any different; no matter the conditions you may be under.\n\n\n\n\n\n\n:)",
	"Wanna know a secret?\n\n\n\n\n\nYou know who you are\n\n\n\n\n\nand it's your fault. :)",
	"Maybe someday they'll notice how they treated me,\nand finally give me the apology I deserve.",
	"That final night\n\nThat final night I had my last dinner.\nThat final night I had my last casual conversation with my family.\nThat final night I got my secret stash of random medicine and consumed all of it.\nThat final night I couldn't get up, my body was vibrating like a time bomb.\nThat final night I cried goodbye to the world.\nThat final night I cried for help.\n\nThat final night changed everything since.",
	"Somewhere in the shadows, I still see you.\n\nI still love you.\n\nYou beat me and give me scars that hurt, but I still love you.\n\nYou yell at me to grow up because crying is for babies, but I still love you.\n\nI still love you when you drove me to suicide because you taught me that hate is bad.\nI still love you when I said goodbye.\nI still love you.",
	"Why am I still going after all this time?\nWhat is my drive that keeps me alive?\nMy desires that hold my wires?\nMy dreams I haven't seen?\n\nI hardly believe these things exist for me anymore, now that I think about it. Am I only here because people want me around? Around for what? Pleasure? Gratitude?\nWhat is it? Can someone please tell me?\n\nI'm just kinda lost, but ``kinda'' is too weak of a word when I still haven't found myself all these years after 													",
	"My sleep has been really bad lately, my sense of paranoia continues to grow each night.\n\nThis was supposed to be private time, right?\nWhy do I still feel unsafe in my own room?\n\nThere's no danger anywhere in my bubble, but I was wrong.\n\nThe danger I'm paranoid about....\n\n\n\n....it's me.",
	"Write your heart out.\n\nThe pen in your hand, contains ink with every breath and word you make.\n\nWrite write write\nwords words words\nI'll write until my blood drenches the paper, with myself falling flat on the ground; pen in hand.",
	"I had a scary dream once.\n\nI was reliving that night again, but it was in the daytime instead. I felt like I was dying, my whole body falling apart one step after another. I crawled for help, I was spotted before I drooled and passed out on the ground shaking.\n\nI was in the next world afterwards. I watched the TV in the living room, only to see my twisted corpse and my family watching as the rain flows until the room flooded.\n\nI woke up, barely eating my food afterwards. After seeing that, I was ready to take my meds again.",
};

local timeSpent = 0

local theValueThatRepresentsTheThresholdToMessThisCharUp = 10

local function UpdateLoopText(self, delta)
    if timeSpent < 60 then
        timeSpent = timeSpent + delta
        return
    end
    timeSpent = 0

    local textLength = poems[math.random(#poems)]:len()
    local output = ""
    for i = 1, textLength do
        local curchar = poems[math.random(#poems)]:sub(i,i)

        if math.random(100) > theValueThatRepresentsTheThresholdToMessThisCharUp then
            curchar = "=‘’“”•–—­®¯°±²³´µ¡¢£¤¥¦§¨©ª«¬¶·¸¹º»\nËÌÍÎÏÐÑÒÓÔÕÖéêëìíîïðñòóôõö÷\nhjsdglkfsiusfuiewuilekljwejklf\nc2-p[4l2454;o34x/2zmo,]"
        end
        
        output = output .. curchar
    end
    self:GetChild("TextActor"):settext( output )
end

local t = Def.ActorFrame{	
    OnCommand=function (self)
		self:SetUpdateFunction(UpdateLoopText);
    end,
	LoadActor(THEME:GetPathG("","_BG/poem"))..{
		InitCommand=cmd(diffusealpha,0;zoom,0.666;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,0.5;linear,0.5;diffusealpha,1);
	};
}

t[#t+1] = Def.BitmapText{
    Font="_hashtag 40px",
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
		self:SetUpdateFunction(UpdateLoopText);
    end,
}

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
		InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,2;rotationz,180;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
		InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,12;rotationz,-180;x,SCREEN_CENTER_X+200;y,SCREEN_CENTER_Y+100);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
		InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,0.666;x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
	  	InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,8;x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y-120);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
	  	InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,4;x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y+120);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","glitch"),
		Frames= {
			{Frame= 0, Delay= 0.0250},
			{Frame= 1, Delay= 0.0250},
			{Frame= 2, Delay= 0.0250},
			{Frame= 3, Delay= 0.0250},
		  },
	  	InitCommand=cmd(diffusealpha,0;blend,Blend.Multiply;zoom,4;x,SCREEN_CENTER_X+200;y,SCREEN_CENTER_Y-120);
		OnCommand=function(self)
			self:sleep(60):diffusealpha(1):SetTextureFiltering(false)
		end
	},
}


return t