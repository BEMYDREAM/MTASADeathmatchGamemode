Lootbox = {};

--// Lootbox vergeben
setTimer(function()
	local time = getRealTime();
	if(#getElementsByType("player") >= 10)then
		if(time.hour >= 16 and time.hour <= 18 or time.hour >= 21 and time.hour <= 23)then
			if(math.random(1,1) == 1)then
				local allPlayers = {};
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1)then
						table.insert(allPlayers,getPlayerName(v));
					end
				end
				local rnd = math.random(1,#allPlayers);
				local target = getPlayerFromName(allPlayers[rnd]);
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1)then
						outputChatBox(loc(v,"LootboxMessage8"):format(getPlayerName(v)),v,255,255,255,true);
					end
				end
				setElementData(target,"Lootbox",getElementData(target,"Lootbox")+1);
			end
		end
	end
end,1800000,0)

--// Skin vergeben
addEvent("Lootbox.givePlayerSkin",true)
addEventHandler("Lootbox.givePlayerSkin",root,function(skin)
	local skin = tonumber(skin);
	local newSkins = getPlayerData("userdata","Username",getPlayerName(client),"Skins")..skin.."|";
	dbExec(handler,"UPDATE userdata SET Skins = '"..newSkins.."' WHERE Username = '"..getPlayerName(client).."'");
	dbExec(handler,"UPDATE userdata SET SkinNumbers = '"..getPlayerData("userdata","Username",getPlayerName(client),"SkinNumbers")+1 .."' WHERE Username = '"..getPlayerName(client).."'");
end)

--// Lootbox öffnen
addEvent("Lootbox.open",true)
addEventHandler("Lootbox.open",root,function()
	if(getElementData(client,"loggedin") == 1)then
		if(getElementData(client,"Lootbox") >= 1)then
			setElementData(client,"LootboxenOpen",getElementData(client,"LootboxenOpen")+1);
			setElementData(client,"Lootbox",getElementData(client,"Lootbox")-1);
			triggerClientEvent(client,"Lootbox.open",client);
			local LootboxenOpen = getElementData(client,"LootboxenOpen");
			if(LootboxenOpen == 1)then setPlayerAchievement(client,26)end
			if(LootboxenOpen == 10)then setPlayerAchievement(client,27)end
			if(LootboxenOpen == 100)then setPlayerAchievement(client,28)end
		else infobox(client,loc(client,"LootboxMessage17"),125,0,0)end
	end
end)

--// Skins laden
addEvent("Lootbox.loadStuff",true)
addEventHandler("Lootbox.loadStuff",root,function()
	local tbl = {};
	local Skins = getPlayerData("userdata","Username",getPlayerName(client),"Skins");
	local SkinNumbers = getPlayerData("userdata","Username",getPlayerName(client),"SkinNumbers");
	for i = 1,SkinNumbers do
		local wstring = gettok(Skins,i,string.byte("|"));
		table.insert(tbl,{wstring});
	end
	triggerClientEvent(client,"Lootbox.refreshSkins",client,tbl);
end)

--// Lootbox kaufen
addEvent("Lootbox.buy",true)
addEventHandler("Lootbox.buy",root,function()
	if(getElementData(client,"loggedin") == 1)then
		if(getElementData(client,"UnnamedCoins") >= 1)then
			setElementData(client,"UnnamedCoins",getElementData(client,"UnnamedCoins")-1);
			setElementData(client,"Lootbox",getElementData(client,"Lootbox")+2);
			triggerClientEvent(client,"Lootbox.refreshSkins",client);
			infobox(client,loc(client,"LootboxMessage19"),0,125,0);
		else infobox(client,loc(client,"LootboxMessage18"),125,0,0)end
	end
end)

--// Lootbox Skin anziehen
addEvent("Lootbox.useSkin",true)
addEventHandler("Lootbox.useSkin",root,function(skin)
	if(getElementData(client,"loggedin") == 1)then
		local skin = tonumber(skin);
		setElementModel(client,skin);
		setElementData(client,"SkinID",skin);
		infobox(client,loc(client,"LootboxMessage20"),0,125,0);
	end
end)