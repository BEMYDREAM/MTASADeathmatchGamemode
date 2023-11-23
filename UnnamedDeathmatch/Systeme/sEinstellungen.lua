Einstellungen = {};

--// Status ändern
addCommandHandler("status",function(player,cmd,status)
	if(getElementData(player,"loggedin") == 1)then
		if(status)then
			if(isPremium(player))then
				setElementData(player,"Status",status);
				infobox(player,loc(player,"EinstellungenMessage3"),0,125,0);
			else infobox(player,loc(player,"EinstellungenMessage2"),125,0,0)end
		else infobox(player,loc(player,"EinstellungenMessage1"),125,0,0)end
	end
end)