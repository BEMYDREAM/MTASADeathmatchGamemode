DeathmatchArena = { lobbys = {}, activeLobbys = 0, timer = {} };

--// Die gespeicherten Deathmatch-Lobbys erstellen
function DeathmatchArena.loadSavedLobbys()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM deathmatchlobbys"),-1);
	if(#result >= 1)then
		for i,v in ipairs(result)do
			DeathmatchArena.activeLobbys = DeathmatchArena.activeLobbys + 1;
			DeathmatchArena.lobbys[DeathmatchArena.activeLobbys] = {
				["Besitzer"] = v["Besitzer"],
				["Limit"] = v["SpielerLimit"],
				["Willkommensnachricht"] = v["Willkommensnachricht"],
				["Passwort"] = v["Passwort"],
				["SpielerInLobby"] = 0,
				["ID"] = DeathmatchArena.activeLobbys,
				["Premium"] = 1,
				["Map"] = v["Map"],
				["Name"] = v["Name"],
			};
		end
		outputDebugString("[DEATHMATCH-ARENA] "..DeathmatchArena.activeLobbys.." lobbys loaded");
	end
end
DeathmatchArena.loadSavedLobbys();

--// Spieler erstellt eine Lobby
addEvent("DeathmatchArena.createLobby",true)
addEventHandler("DeathmatchArena.createLobby",root,function(limit,willkommensnachricht,passwort,map,name)
	if(DeathmatchArena.existLobby(getPlayerName(client)))then
		local limit = tonumber(limit);
		if(isPremium(client))then
			premium = 1;
			if(hasSilberPremium(client))then if(limit > 8)then limit = 8 end end
			if(hasBronzePremium(client))then if(limit > 6)then limit = 6 end end
		else
			premium = 0;
			map = 1;
			if(limit > 4)then limit = 4 end
			willkommensnachricht = loc(client,"DeathmatchArenaMessage54");
		end
		DeathmatchArena.activeLobbys = DeathmatchArena.activeLobbys + 1;
		DeathmatchArena.lobbys[DeathmatchArena.activeLobbys] = {
			["Besitzer"] = getPlayerName(client),
			["Limit"] = limit,
			["Willkommensnachricht"] = willkommensnachricht,
			["Passwort"] = passwort,
			["SpielerInLobby"] = 1,
			["ID"] = DeathmatchArena.activeLobbys,
			["Premium"] = premium,
			["Map"] = map,
			["Name"] = name,
		},
		setElementData(client,"Lobby","DeathmatchArena");
		setElementData(client,"LobbyID",DeathmatchArena.activeLobbys);
		DeathmatchArena.spawnPlayer(client);
		if(isPremium(client))then
			dbExec(handler,"INSERT INTO deathmatchlobbys (Besitzer,SpielerLimit,Willkommensnachricht,Passwort,Premium,Map,Name) VALUES ('"..getPlayerName(client).."','"..limit.."','"..willkommensnachricht.."','"..passwort.."','"..premium.."','"..map.."','"..name.."')");
		end
		outputDebugString("[DEATHMATCH-ARENA] Lobby "..DeathmatchArena.activeLobbys.." was created");
		triggerClientEvent(client,"setWindowDatas",client,"reset");
	else infobox(client,loc(client,"DeathmatchArenaMessage2"),125,0,0)end
end)

--// Hat der Spieler bereits eine Lobby erstellt?
function DeathmatchArena.existLobby(besitzer)
	local state = false;
	for _,v in pairs(DeathmatchArena.lobbys)do
		if(v["Besitzer"] == besitzer)then
			state = true;
			break
		end
	end
	if(state == false)then return true else return false end
end

--// Lobby-Einstellungen

-- Name
addEvent("DeathmatchArena.settingsName",true)
addEventHandler("DeathmatchArena.settingsName",root,function(name)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeathmatchArena.lobbys[LobbyID]["Name"] = name;
		infobox(client,loc(client,"DeathmatchArenaMessage4"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deathmatchlobbys SET Name = '"..name.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeathmatchArenaMessage3"),125,0,0)end
end)


-- Spielerlimit
addEvent("DeathmatchArena.settingsLimit",true)
addEventHandler("DeathmatchArena.settingsLimit",root,function(limit)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		local limit = tonumber(limit);
		if(limit > 4)then
			if(hasSilberPremium(client))then
				if(limit > 8)then
					infobox(client,loc(client,"DeathmatchArenaMessage7"),125,0,0);
					return false
				end
			elseif(hasBronzePremium(client))then
				if(limit > 6)then
					infobox(client,loc(client,"DeathmatchArenaMessage8"),125,0,0);
					return false
				end
			elseif(hasGoldPremium(client))then
				return true
			else
				if(limit > 4)then
					infobox(client,loc(client,"DeathmatchArenaMessage27"),125,0,0);
					return false
				end
			end
		end
		DeathmatchArena.lobbys[LobbyID]["Limit"] = limit;
		infobox(client,loc(client,"DeathmatchArenaMessage9"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deathmatchlobbys SET SpielerLimit = '"..limit.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeathmatchArenaMessage6"),125,0,0)end
end)

-- Willkommensnachricht
addEvent("DeathmatchArena.settingsWillkommensnachricht",true)
addEventHandler("DeathmatchArena.settingsWillkommensnachricht",root,function(willkommensnachricht)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		if(isPremium(client))then
			DeathmatchArena.lobbys[LobbyID]["Willkommensnachricht"] = willkommensnachricht;
			dbExec(handler,"UPDATE deathmatchlobbys SET Willkommensnachricht = '"..willkommensnachricht.."' WHERE Besitzer = '"..getPlayerName(client).."'");
			infobox(client,loc(client,"DeathmatchArenaMessage12"),0,125,0);
		else infobox(client,loc(client,"DeathmatchArenaMessage11"),125,0,0)end
	else infobox(client,loc(client,"DeathmatchArenaMessage10"),125,0,0)end
end)

-- Map
addEvent("DeathmatchArena.settingsMap",true)
addEventHandler("DeathmatchArena.settingsMap",root,function(map)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		if(isPremium(client) and hasGoldPremium(client))then
			DeathmatchArena.lobbys[LobbyID]["Map"] = map;
			dbExec(handler,"UPDATE deathmatchlobbys SET Map = '"..map.."' WHERE Besitzer = '"..getPlayerName(client).."'");
			infobox(client,loc(client,"DeathmatchArenaMessage15"),0,125,0);
			
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"Lobby") == "DeathmatchArena" and getElementDimension(v) == getElementData(client,"LobbyID"))then
					DeathmatchArena.spawnPlayer(v);
				end
			end
		else infobox(client,loc(client,"DeathmatchArenaMessage14"),125,0,0)end
	else infobox(client,loc(client,"DeathmatchArenaMessage13"),125,0,0)end
end)

-- Passwort
addEvent("DeathmatchArena.settingsPasswort",true)
addEventHandler("DeathmatchArena.settingsPasswort",root,function(passwort)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeathmatchArena.lobbys[LobbyID]["Passwort"] = passwort;
		infobox(client,loc(client,"DeathmatchArenaMessage17"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deathmatchlobbys SET Passwort = '"..passwort.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeathmatchArenaMessage16"),125,0,0)end
end)

-- Lobby löschen
addEvent("DeathmatchArena.deleteLobby",true)
addEventHandler("DeathmatchArena.deleteLobby",root,function()
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeathmatchArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeathmatchArena.lobbys[LobbyID] = nil;
		infobox(client,loc(client,"DeathmatchArenaMessage19"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"DELETE FROM deathmatchlobbys WHERE Besitzer = '"..getPlayerName(client).."'");
		end
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "DeathmatchArena")then
				if(getElementData(v,"LobbyID") == LobbyID)then
					RegisterLogin.spawnEingangshalle(v);
				end
			end
		end
		triggerClientEvent(client,"setWindowDatas",client,"reset");
	else infobox(client,loc(client,"DeathmatchArenaMessage18"),125,0,0)end
end)

--// Spieler will einer Deathmatch Lobby beitreten
addEvent("DeathmatchArena.joinLobby",true)
addEventHandler("DeathmatchArena.joinLobby",root,function(id,besitzer,passwort)
	local id = tonumber(id);
	if(DeathmatchArena.lobbys[id] and DeathmatchArena.lobbys[id]["Besitzer"] == besitzer)then
		if(passwort)then
			if(DeathmatchArena.lobbys[id]["Passwort"] ~= passwort)then
				infobox(client,loc(client,"DeathmatchArenaMessage5"),125,0,0)
				return false
			end
		end
		if(DeathmatchArena.lobbys[id]["SpielerInLobby"] < DeathmatchArena.lobbys[id]["Limit"])then
			local tbl = DeathmatchArena.lobbys[id];
			local lobbyID = tbl["ID"];
			setElementData(client,"Lobby","DeathmatchArena");
			setElementData(client,"LobbyID",lobbyID);
			DeathmatchArena.lobbys[lobbyID]["SpielerInLobby"] = DeathmatchArena.lobbys[lobbyID]["SpielerInLobby"] + 1;
			DeathmatchArena.spawnPlayer(client);
			triggerClientEvent(client,"setWindowDatas",client,"reset");
			outputChatBox(DeathmatchArena.lobbys[id]["Willkommensnachricht"],client,255,255,255);
		else infobox(client,loc(client,"DeathmatchArenaMessage26"),125,0,0)end
	else infobox(client,loc(client,"DeathmatchArenaMessage1"),125,0,0)end
end)

--// Spieler wird in der beigetretenden Lobby gespawnt
local DeathmatchArenaLobbySpawns = {
	[1] = {
		{-2242.0871582031,1191.3063964844,87.2109375,360},
		{-2242.0595703125,1241.0584716797,87.2109375,266},
		{-2229.1938476563,1253.4168701172,87.2109375,180},
		{-2185.1291503906,1253.173828125,87.2109375,180},
		{-2183.7568359375,1231.1728515625,87.2109375,90},
		{-2184.1887207031,1192.2388916016,87.2109375,90},
		{-2212.0686035156,1191.7072753906,87.2109375,0},
	},
	[2] = {
		{238.94821166992,139.3509979248,1003.0234375,360},
		{222.57006835938,143.51443481445,1003.0234375,270},
		{218.95967102051,170.35762023926,1003.0234375,360},
		{206.53797912598,172.26420593262,1003.0274658203,180},
		{195.15043640137,179.19355773926,1003.0234375,270},
		{252.64558410645,171.48121643066,1003.0234375,270},
		{289.32446289063,167.54489135742,1007.171875,360},
		{290.47198486328,191.25071716309,1007.171875,90},
		{257.81658935547,187.01142883301,1008.171875,360},
	},
	[3] = {
		{2158.9599609375,1597.1173095703,999.96997070313,360},
		{2172.1154785156,1606.1180419922,999.96789550781,90},
		{2170.3530273438,1623.4604492188,999.97467041016,270},
		{2204.8227539063,1608.0943603516,999.97039794922,0},
		{2222.4311523438,1596.7335205078,999.9765625,180},
		{2227.4211425781,1578.787109375,999.97119140625,90},
		{2204.8032226563,1553.3603515625,1008.5708618164,270},
		{2201.9064941406,1588.5777587891,999.97845458984,180},
		{2173.7973632813,1589.921875,999.97802734375,180},
		{2170.4416503906,1610.5343017578,999.97131347656,360},
	},
};

local LobbyMaps = {
	[1] = 0,
	[2] = 3,
	[3] = 1,
};

function DeathmatchArena.spawnPlayer(player)
	takeAllWeapons(player);
	local LobbyID = getElementData(player,"LobbyID");
	local rnd = math.random(1,#DeathmatchArenaLobbySpawns[DeathmatchArena.lobbys[LobbyID]["Map"]]);
	local tbl = DeathmatchArenaLobbySpawns[DeathmatchArena.lobbys[LobbyID]["Map"]][rnd];
	local x,y,z,rot = tbl[1],tbl[2],tbl[3],tbl[4];
	spawnPlayer(player,x,y,z,rot,getElementData(player,"SkinID"),LobbyMaps[DeathmatchArena.lobbys[LobbyID]["Map"]],getElementData(player,"LobbyID")+1000);
	giveWeapon(player,24,9999);
	giveWeapon(player,29,9999);
	giveWeapon(player,31,9999);
	giveWeapon(player,33,9999);
	setPedArmor(player,100);
	setPedHeadless(player,false);
end

--// Was passiert, wenn der Spieler in einer Deathmatch Lobby stirbt
addEventHandler("onPlayerWasted",root,function()
	if(getElementData(source,"Lobby") == "DeathmatchArena")then
		setElementData(source,"TodeDeathmatch",getElementData(source,"TodeDeathmatch")+1);
		setElementData(source,"TodeGesamt",getElementData(source,"TodeGesamt")+1);
		DeathmatchArena.timer[source] = setTimer(function(source)
			DeathmatchArena.spawnPlayer(source);
		end,5000,1,source)
		setElementData(source,"TemporaererDamage",0);
		setElementData(source,"TemporaererKill",0);
		checkTodeAchievement(source);
	end
end)

--// Was passiert, wenn der Spieler in einer Deathmatch Lobby ist und den Server verlässt
addEventHandler("onPlayerQuit",root,function()
	if(isTimer(DeathmatchArena[source]))then killTimer(DeathmatchArena[source])end
	if(getElementData(source,"Lobby") == "DeathmatchArena")then
		local ID = getElementData(source,"LobbyID");
		DeathmatchArena.lobbys[ID]["SpielerInLobby"] = DeathmatchArena.lobbys[ID]["SpielerInLobby"] - 1;
		if(DeathmatchArena.lobbys[ID]["SpielerInLobby"] == 0)then
			if(DeathmatchArena.lobbys[ID]["Premium"] == 0)then
				DeathmatchArena.lobbys[ID] = nil;
			end
		end
	end
end)

--// Spieler verlässt Lobby
addCommandHandler("leave",function(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "DeathmatchArena")then
		if(isTimer(DeathmatchArena[player]))then killTimer(DeathmatchArena[player])end
		local ID = getElementData(player,"LobbyID");
		DeathmatchArena.lobbys[ID]["SpielerInLobby"] = DeathmatchArena.lobbys[ID]["SpielerInLobby"] - 1;
		if(DeathmatchArena.lobbys[ID]["SpielerInLobby"] == 0)then
			if(DeathmatchArena.lobbys[ID]["Premium"] == 0)then
				DeathmatchArena.lobbys[ID] = nil;
			end
		end
		RegisterLogin.spawnEingangshalle(player);
		RegisterLogin.savePlayerDatas(player);
		setElementData(player,"TemporaererDamage",0);
		setElementData(player,"TemporaererKill",0);
	end
end)

--// Lobbys laden
addEvent("DeathmatchArena.loadLobbys",true)
addEventHandler("DeathmatchArena.loadLobbys",root,function()
	local lobbys = DeathmatchArena.lobbys;
	triggerClientEvent(client,"DeathmatchArena.refreshList",client,lobbys);
end)

--// Lobby Einstellungen öffnen
function DeathmatchArena.openEinstellungen(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "DeathmatchArena")then
		local ID = getElementData(player,"LobbyID");
		triggerClientEvent(player,"DeathmatchArena.openEinstellungen",player,DeathmatchArena.lobbys[ID]["Besitzer"]);
	end
end