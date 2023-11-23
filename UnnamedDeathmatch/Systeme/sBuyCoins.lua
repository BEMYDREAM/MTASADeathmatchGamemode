--// Nachricht abschicken
addEvent("BuyCoins.server",true)
addEventHandler("BuyCoins.server",root,function(text)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM buycoins WHERE Username = '"..getPlayerName(client).."'"),-1);
	if(#result == 0)then
		dbExec(handler,"INSERT INTO buycoins (Username,Text) VALUES ('"..getPlayerName(client).."','"..text.."')");
		infobox(client,loc(client,"UnnamedCoinsMessage5"),0,125,0);
	else infobox(client,loc(client,"UnnamedCoinsMessage4"),125,0,0)end
end)