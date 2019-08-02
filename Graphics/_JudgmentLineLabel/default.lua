local jl = Var "JudgmentLine";

return Def.ActorFrame {
	
	LoadFont("_ammys handwriting 20px") .. {
		InitCommand=cmd(zoom,1;addy,2;settext,string.upper(JudgmentLineToLocalizedString(jl));diffuse,Color("Black");maxwidth,180);
	};
};