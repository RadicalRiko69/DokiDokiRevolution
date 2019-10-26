--[[
VNUtils is (mostly) written by Rhythm Lunatic and is CC BY NC.
Please do not use this for monetary gains.
]]

--=========================
-- Actor related functions
--=========================
function genTextBackground(TEXTBOX_HEIGHT)
	if not TEXTBOX_HEIGHT then
		TEXTBOX_HEIGHT = 150;
	end
	
	return Def.ActorFrame{
		--InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_HEIGHT*.85;vertalign,top;);

		--Textbox & lines
		Def.Quad{ --BG
			InitCommand=cmd(setsize,640,TEXTBOX_HEIGHT;diffuse,color("#ff00bf77");fadeleft,.1;faderight,.1;zoomy,0);
			OnCommand=cmd(decelerate,.8;zoomy,1);
		};
		Def.Quad{ --Top
			InitCommand=cmd(setsize,640,2;diffuse,Color("White");fadeleft,.1;faderight,.1;addy,-(TEXTBOX_HEIGHT/2 - 10));
		};
		--[[Def.Quad{ --Bottom
			InitCommand=cmd(setsize,SCREEN_WIDTH*.25,2;diffuse,Color("White");fadeleft,.1;horizalign,left;addx,-(SCREEN_WIDTH*.50);addy,TEXTBOX_HEIGHT/2 - 10);
		};
		Def.Quad{ --Arrow left part
			InitCommand=cmd(setsize,2,100;diffuse,Color("White");horizalign,left;vertalign,top;x,SCREEN_WIDTH*.25;addx,-(SCREEN_WIDTH*.50)-2;addy,TEXTBOX_HEIGHT/2 - 10)
		};]]
		Def.Quad{ --Bottom
			InitCommand=cmd(setsize,640,2;diffuse,Color("White");fadeleft,.1;faderight,.1;addy,TEXTBOX_HEIGHT/2 - 10);
		};
		
		--For debugging, left and right
		--[[Def.Quad{
			InitCommand=cmd(setsize,2,TEXTBOX_HEIGHT;diffuse,Color("Red");addx,-500);
		};
		Def.Quad{
			InitCommand=cmd(setsize,2,TEXTBOX_HEIGHT;diffuse,Color("Red");addx,500);
		};]]
		

		--[[LoadFont("Dialogue Character Names")..{
			Text="Reimu Hakurei";
			InitCommand=cmd(xy,-SCREEN_WIDTH/2+100,-TEXTBOX_HEIGHT/2 - 3;horizalign,left;vertalign,bottom;shadowcolor,Color("Black");shadowlength,1);
		};]]
	};

end

--Because it's better than adding the commands every time. Probably.
function GetPathVN(item)
	return "/"..THEME:GetCurrentThemeDirectory().."StoryMode/"..item;
end;

function Actor:Cover()
	self:scaletocover(0,0,SCREEN_RIGHT,SCREEN_BOTTOM);
end;

function Actor:VN_Dim()
	self:linear(.3):diffuse(color(".5,.5,.5,1"));
end;

function Actor:VN_Undim()
	self:linear(.3):diffuse(color("1,1,1,1"));
end;

function Actor:VN_Appear()
	self:sleep(.5):decelerate(.5):rotationy(0);
end;

function Actor:VN_Disappear()
	self:accelerate(.5):rotationy(90);
end;

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function string.ends(String,End)
   return End=='' or string.sub(String,-string.len(End))==End
end

--=========================
-- VN related functions
--=========================
function boolYesNo(b)
	if b then
		return "Yes";
	else
		return "No";
	end;
end;

--Old function! Useful if you want simple text though?
function LoadVNText(font, text, maxwidth, speed, noAutoPlay)

	if not speed then
		speed = .1
	else
		speed = 1/speed;
	end;
	
	return LoadFont(font)..{
			Name = "vntext";
			InitCommand=function(self)
				self:horizalign(left):vertalign(top):wrapwidthpixels(maxwidth); --Single line commands!
				if string.starts(text, "\c[") then
					local j = string.find(text, "%]", 3);
					if not j then
						text = "Bad color code!"
					else
						self:diffuse(color(text:sub(3,j)));
						text = text:sub(j+1, #text);
					end
				end;
			end;
			OnCommand=function(self)
				textActor = self;
				if not noAutoPlay then
					self:playcommand("Text");
				end;
			end;
			TextCommand=function(self)
				if #self:GetText() < #text then
					self:settext(string.sub(text, 1, string.len(self:GetText()) + 1))
					self:sleep(speed);
					self:queuecommand("Text");
				else
				
				end;
			end;
			SkipCommand=function(self)
				self:settext(text);
			end;
			
			--[[
			If you don't know how to call SkipCommand:
			Define the variable that holds the actor somewhere
			local vntextActor = vntext(parameters go here)
			
			Add it to the table (or an actorframe)
			t[#t+1] = vntextActor;
			
			And somewhere...
			vntextActor:playcommand("Skip");
			]]
		
		};
end;

--New, better function from Kyzentun
--DON'T USE SELF.TEXT! SELF.TEXT IS CONFUSING! -Rhythm Lunatic
function LoadVNText2()

	local vntext_mt= {
__index= {
        make_actor= function(self, font, text, maxwidth, spd, clr)
            self.cur_len= 0
			if type(text) == "table" then
				self.texttable = text
				self.text  = text[1];
				self.cur_txt = 1
			else
				self.texttable = {text};
			end
            self.spd= spd
            return Def.BitmapText{
                Font= font, Name= "vntext", Text= "", 
				InitCommand= function(subself)
                    -- note that self refers to the wrapper, subself is the actor.
                    self.text_actor= subself
                    subself:horizalign(left):vertalign(top):wrapwidthpixels(maxwidth)
                        :diffuse(clr)
					subself:vertspacing(10);
					--subself:queuecommand("Init2");
                end,
                OnCommand= function(subself)
					if self.cur_txt == 1 then
						subself:queuecommand("Check");
					end;
                end,
				CheckCommand= function(subself)
					--Check if line starts with a MessageCommand
					--TODO: Make it so it supports playing a command at any time using tmp_txt = self.text:sub(self.cur_txt, #self.text)?
					local tmp_txt = self.texttable[self.cur_txt]
					while tmp_txt:sub(1,1) == "/" do
						--SCREENMAN:SystemMessage("aaa");
						if string.starts(tmp_txt, "/c[") then
							local cmd_end = string.find(tmp_txt, "%]", 3);
							if not cmd_end then
								tmp_txt = "Bad color code!"
							else
								subself:diffuse(color(tmp_txt:sub(3,cmd_end)));
								--SCREENMAN:SystemMessage("diffused "..tmp_txt:sub(3,cmd_end)..", new msg is "..tmp_txt:sub(cmd_end+1, #tmp_txt));
								tmp_txt = tmp_txt:sub(cmd_end+1, #tmp_txt);
							end
						end;
						if string.starts(tmp_txt, "/mc[") then
							local cmd_end = string.find(tmp_txt, "%]", 4);
							if not cmd_end then
								SCREENMAN:SystemMessage("Bad message command!");
							else
								local command = tmp_txt:sub(5,cmd_end-1)
								local msg = split(",",command)
								--Second argument of Broadcast only takes tables, so shove it in a table.
								--SCREENMAN:SystemMessage(msg[2]);
								if msg[2] then
									MESSAGEMAN:Broadcast(msg[1],{msg[2]})
								else
									MESSAGEMAN:Broadcast(msg[1])
								end;
								--SCREENMAN:SystemMessage("Broadcasted "..command..", new msg is "..tmp_txt:sub(cmd_end+1, #tmp_txt));
								--SCREENMAN:SystemMessage("Broadcast "..msg[1]..", "..msg[2]);
								tmp_txt = tmp_txt:sub(cmd_end+1, #tmp_txt);
							end
						end;
						if string.starts(tmp_txt, "/dim[") then
							local cmd_end = string.find(tmp_txt, "%]", 4);
							if not cmd_end then
								SCREENMAN:SystemMessage("Bad dim command!");
							else
								local command = tmp_txt:sub(6,cmd_end-1)
								--SCREENMAN:SystemMessage("Broadcast VNDim,"..command);
								--Second argument of Broadcast only takes tables, so shove it in a table.
								MESSAGEMAN:Broadcast("VNDim",{command})
								
								tmp_txt = tmp_txt:sub(cmd_end+1, #tmp_txt);
							end
						end;
						--If it still has a slash
						--[[if tmp_txt:sub(1,1) == "/" then
							local cmd_end = string.find(tmp_txt, "%]", 4);
							SCREENMAN:SystemMessage("Unimplemented script command "..tmp_txt:sub(5,cmd_end-1).."? If this wasn't a typo, don't put forward slashes at the beginning of the line!")
							tmp_txt = tmp_txt:sub(cmd_end+1, #tmp_txt);
						end;]]
					end;
					--[[if tmp_txt:sub(1,1) == "/" then
						SCREENMAN:SystemMessage("true");
					else
						SCREENMAN:SystemMessage("false "..tmp_txt:sub(1,1))
					end;]]
					self.texttable[self.cur_txt] = tmp_txt
					subself:playcommand("Play");
				end,
				PlayCommand= function(subself)
					--Count up until it reaches the number of letters in the line.
					if self.cur_len == #self.texttable[self.cur_txt] then return end;
					subself:playcommand("Text"):sleep(1/self.spd):queuecommand("Play")

				end,
                TextCommand= function(subself)
                    self.cur_len= #subself:GetText()
                    if self.cur_len < #self.texttable[self.cur_txt] then
                        subself:settext(self.texttable[self.cur_txt]:sub(1, self.cur_len + 1))
                    end
                end,
            }
        end,
		advance= function(self)
			if self.texttable then
				if #self.texttable == self.cur_txt then
					SCREENMAN:SystemMessage("You already hit the end!")
				else
					self.text_actor:settext("")
					self.cur_len= 0
					self.cur_txt = self.cur_txt + 1
					self.text_actor:queuecommand("Check");
					--SCREENMAN:SystemMessage(tostring(self.cur_txt).."/"..tostring(#self.texttable));
				end
			else
				SCREENMAN:SystemMessage("You only passed in one message!")
			end
		end,
        skip= function(self)
            self.text_actor:settext(self.texttable[self.cur_txt])
            self.cur_len= #self.texttable[self.cur_txt]
        end,
        is_finished= function(self)
            return self.cur_len == #self.texttable[self.cur_txt];
        end,
		no_more_text=function(self)
			return #self.texttable == self.cur_txt
		end,
        set_new_text= function(self, text, color)
            self.text_actor:settext(""):diffuse(color)
            self.cur_len= 0
            self.text= text
        end,
}}
	return setmetatable({}, vntext_mt)
	
end;

--And the crappy hacked up one for multiple lines and colors
--TODO: Add \dim[char], \undim[char], \disappear[char], \appear[char], \setImage[char, image]
function LoadVNText3()

	local vntext_mt= {
__index= {
        make_actor= function(self, font, text, maxwidth, spd)
			self.text_actors = {}
			self.texttable = text
			self.cur_txt = 1
            self.spd= spd
            local t = Def.ActorFrame{}
			for i = 1, #self.texttable do
				t[i] = Def.BitmapText{
					Font= font, Name= "vntext", Text= "", InitCommand= function(subself)
						-- note that self refers to the wrapper, subself is the actor.
						self.text_actors[i] = subself
						subself:horizalign(left):vertalign(top):wrapwidthpixels(maxwidth):addy(30*(i-1));
						subself:queuecommand("Init2");
					end,
					Init2Command=function(subself)
						local tmp_txt = self.texttable[i];
						if string.starts(tmp_txt, "\c[") then
							local cmd_end = string.find(tmp_txt, "%]", 3);
							if not cmd_end then
								tmp_txt = "Bad color code!"
							else
								subself:diffuse(color(tmp_txt:sub(3,cmd_end)));
								tmp_txt = tmp_txt:sub(cmd_end+1, #tmp_txt);
							end
						end;
						self.texttable[i] = tmp_txt
					end;
					OnCommand=function(subself)
						if self.cur_txt == i then
							subself:queuecommand("Play");
						end;
					end;
					PlayCommand= function(subself)
						--Check if line starts with a MessageCommand
						--TODO: Make it so it supports playing a command at any time using tmp_txt = self.text:sub(self.cur_txt, #self.text)?
						local tmp_txt = self.texttable[self.cur_txt]
						if string.starts(tmp_txt, "\mc[") then
							local cmd_end = string.find(tmp_txt, "%]", 4);
							if not cmd_end then
								SCREENMAN:SystemMessage("Bad message command!");
							else
								local command = tmp_txt:sub(4,cmd_end-1)
								local msg = split(",",command)
								--Second argument of Broadcast only takes tables, so shove it in a table.
								--SCREENMAN:SystemMessage(msg[2]);
								if msg[2] then
									MESSAGEMAN:Broadcast(msg[1],{msg[2]})
								else
									MESSAGEMAN:Broadcast(msg[1])
								end;
								--SCREENMAN:SystemMessage("Broadcasted "..command..", new msg is "..tmp_txt:sub(cmd_end+1, #tmp_txt));
								self.texttable[self.cur_txt] = tmp_txt:sub(cmd_end+1, #tmp_txt);
								--SCREENMAN:SystemMessage(self.text);
							end
						end;
						--Count up until it reaches the number of letters in the line.
						if self.cur_len == #self.texttable[self.cur_txt] then return end;
						subself:playcommand("Text"):sleep(1/self.spd):queuecommand("Play")
					end,
					TextCommand= function(subself)
						self.cur_len= #subself:GetText()
						if self.cur_len < #self.texttable[self.cur_txt] then
							subself:settext(self.texttable[self.cur_txt]:sub(1, self.cur_len + 1))
						end
					end,
				}
			end;
			--self.text = "asdadsd"
			return t;
        end,
		advance= function(self)
			if #self.texttable == self.cur_txt then
				SCREENMAN:SystemMessage("You already hit the end!")
			else
				--Reset progress of text advancement for the line to 0.
				self.cur_len= 0
				--Increase the current text line.
				self.cur_txt = self.cur_txt + 1
				--Set the text
				--self.text = self.texttable[self.cur_txt];
				--Play the new line.
				self.text_actors[self.cur_txt]:queuecommand("Play");
			end
		end,
        skip= function(self)
            self.text_actors[self.cur_txt]:settext(self.texttable[self.cur_txt])
            self.cur_len= #self.texttable[self.cur_txt]
        end,
        is_finished= function(self)
            return self.cur_len == #self.texttable[self.cur_txt];
        end,
		no_more_text=function(self)
			return #self.texttable == self.cur_txt
		end,
		diagnostic=function(self)
			return "Line "..self.cur_txt.."/"..#self.texttable.." | Progress: "..self.cur_len.."/"..#self.texttable[self.cur_txt].." | Message: "..self.texttable[self.cur_txt].." | Fin? "..boolYesNo(self.cur_len == #self.texttable[self.cur_txt]);
		end,
		--Unfinished
        set_new_table = function(self, table)
        	if #table > #self.texttable then
        		SCREENMAN:SystemMessage("Can't supply a table with more than the first one.");
    		else
    			for i = 1, #self.texttable do
            		self.text_actors[i]:settext("");
        		end;
    			self.texttable = table;
    			for i = 1, #self.texttable do
            		self.text_actors[i]:queuecommand("Init2");
        		end;
            	self.cur_txt = 1;
            	self.cur_len = 0;
            	--self.text = self.texttable[1];
            	self.text_actors[1]:queuecommand("Play");
        	end;
        end,
}}
	return setmetatable({}, vntext_mt)
	
end;
