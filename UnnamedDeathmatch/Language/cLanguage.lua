function loc(var)
	local playerLanguage = getElementData(localPlayer,"Sprache");
	if(not(playerLanguage))then playerLanguage = "DE" end
	if(Language[playerLanguage])then
		if(Language[playerLanguage][var])then
			return Language[playerLanguage][var];
		else
			return var;
		end
	end
end