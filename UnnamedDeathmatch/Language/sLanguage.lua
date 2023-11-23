function loc(player,var,name)
	local playerLanguage = getElementData(player,"Sprache");
	if(not(playerLanguage))then playerLanguage = "DE" end
	if(Language[playerLanguage])then
		if(Language[playerLanguage][var])then
			return Language[playerLanguage][var];
		else
			return var;
		end
	end
end

addCommandHandler("language",function(player)
	if(getElementData(player,"Sprache") == "DE")then
		setElementData(player,"Sprache","EN");
		infobox(player,"Language has been changed.",0,125,0);
	else
		setElementData(player,"Sprache","DE");
		infobox(player,"Sprache geändert.",0,125,0);
	end
end)