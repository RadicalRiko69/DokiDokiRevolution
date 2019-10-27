--[[
If you're trying to figure out how to do button inputs, don't use this.
this function uses DeviceInput because I need /mouse/ input, you normally
don't need that.
]]
local function inputs(event)
	--Check if player clicked screen, then skip to next screen if they did.
	local pn= event.PlayerNumber
	local button = event.button
	-- If the PlayerNumber isn't set, the button isn't mapped.  Ignore it.
	-- ...Unless it's the mouse.
	if not pn and event.DeviceInput.is_mouse == false then return end
	if event.DeviceInput.is_mouse then
		button = ToEnumShortString(event.DeviceInput.button)
	end
	-- If it's a release, ignore it.
	if event.type == "InputEventType_Release" then return end
	
	if button == "left mouse button" or button == "Start" then
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
	end
end;


local course = _G.CurrentFakeCourse;
local dir = course:GetCourseDir():sub(1, -5);
local stg = {
"Ending",
"EX_Ending",
"OMES_Ending"
}
local path = dir.."/"..stg[_G.StageType]..".lua";

if FILEMAN:DoesFileExist(path) then
	return Def.ActorFrame{
		LoadActor(path)..{};
	};
else
	return Def.ActorFrame{
		LoadFont("Common Normal")..{
			Text=path.." not found.\nPress Start or click to go to next screen.";
			InitCommand=cmd(Center);
			OnCommand=function(self)
				SCREENMAN:GetTopScreen():AddInputCallback(inputs);
			end;
			CodeMessageCommand=function(self, param)
				if param.Name == "start" then
					SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
				else
					SCREENMAN:SystemMessage(tostring(param));
				end;
			end;
		};
	};
end;
