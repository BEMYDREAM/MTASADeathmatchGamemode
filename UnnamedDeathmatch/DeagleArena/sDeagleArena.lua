DeagleArena = { lobbys = {}, activeLobbys = 0, timer = {} };

--// Die gespeicherten Deagle-Lobbys erstellen
function DeagleArena.loadSavedLobbys()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM deaglelobbys"),-1);
	if(#result >= 1)then
		for i,v in ipairs(result)do
			DeagleArena.activeLobbys = DeagleArena.activeLobbys + 1;
			DeagleArena.lobbys[DeagleArena.activeLobbys] = {
				["Besitzer"] = v["Besitzer"],
				["Limit"] = v["SpielerLimit"],
				["Willkommensnachricht"] = v["Willkommensnachricht"],
				["Passwort"] = v["Passwort"],
				["SpielerInLobby"] = 0,
				["ID"] = DeagleArena.activeLobbys,
				["Premium"] = 1,
				["Map"] = v["Map"],
				["Name"] = v["Name"],
			};
		end
		outputDebugString("[DEAGLE-ARENA] "..DeagleArena.activeLobbys.." lobbys loaded");
	end
end
DeagleArena.loadSavedLobbys();

--// Spieler erstellt eine Lobby
addEvent("DeagleArena.createLobby",true)
addEventHandler("DeagleArena.createLobby",root,function(limit,willkommensnachricht,passwort,map,name)
	if(DeagleArena.existLobby(getPlayerName(client)))then
		local limit = tonumber(limit);
		if(isPremium(client))then
			premium = 1;
			if(hasSilberPremium(client))then if(limit > 8)then limit = 8 end end
			if(hasBronzePremium(client))then if(limit > 6)then limit = 6 end end
		else
			premium = 0;
			map = 1;
			if(limit > 4)then limit = 4 end
			willkommensnachricht = loc(client,"DeagleArenaMessage54");
		end
		DeagleArena.activeLobbys = DeagleArena.activeLobbys + 1;
		DeagleArena.lobbys[DeagleArena.activeLobbys] = {
			["Besitzer"] = getPlayerName(client),
			["Limit"] = limit,
			["Willkommensnachricht"] = willkommensnachricht,
			["Passwort"] = passwort,
			["SpielerInLobby"] = 1,
			["ID"] = DeagleArena.activeLobbys,
			["Premium"] = premium,
			["Map"] = map,
			["Name"] = name,
		},
		setElementData(client,"Lobby","DeagleArena");
		setElementData(client,"LobbyID",DeagleArena.activeLobbys);
		DeagleArena.spawnPlayer(client);
		if(isPremium(client))then
			dbExec(handler,"INSERT INTO deaglelobbys (Besitzer,SpielerLimit,Willkommensnachricht,Passwort,Premium,Map,Name) VALUES ('"..getPlayerName(client).."','"..limit.."','"..willkommensnachricht.."','"..passwort.."','"..premium.."','"..map.."','"..name.."')");
		end
		outputDebugString("[DEAGLE-ARENA] Lobby "..DeagleArena.activeLobbys.." was created");
		triggerClientEvent(client,"setWindowDatas",client,"reset");
	else infobox(client,loc(client,"DeagleArenaMessage2"),125,0,0)end
end)

--// Hat der Spieler bereits eine Lobby erstellt?
function DeagleArena.existLobby(besitzer)
	local state = false;
	for _,v in pairs(DeagleArena.lobbys)do
		if(v["Besitzer"] == besitzer)then
			state = true;
			break
		end
	end
	if(state == false)then return true else return false end
end

--// Lobby-Einstellungen

-- Name
addEvent("DeagleArena.settingsName",true)
addEventHandler("DeagleArena.settingsName",root,function(name)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeagleArena.lobbys[LobbyID]["Name"] = name;
		infobox(client,loc(client,"DeagleArenaMessage4"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deaglelobbys SET Name = '"..name.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeagleArenaMessage3"),125,0,0)end
end)

-- Spielerlimit
addEvent("DeagleArena.settingsLimit",true)
addEventHandler("DeagleArena.settingsLimit",root,function(limit)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		local limit = tonumber(limit);
		if(limit > 4)then
			if(hasSilberPremium(client))then
				if(limit > 8)then
					infobox(client,loc(client,"DeagleArenaMessage7"),125,0,0);
					return false
				end
			elseif(hasBronzePremium(client))then
				if(limit > 6)then
					infobox(client,loc(client,"DeagleArenaMessage8"),125,0,0);
					return false
				end
			elseif(hasGoldPremium(client))then
				return true
			else
				if(limit > 4)then
					infobox(client,loc(client,"DeagleArenaMessage27"),125,0,0);
					return false
				end
			end
		end
		DeagleArena.lobbys[LobbyID]["Limit"] = limit;
		infobox(client,loc(client,"DeagleArenaMessage9"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deaglelobbys SET SpielerLimit = '"..limit.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeagleArenaMessage6"),125,0,0)end
end)

-- Willkommensnachricht
addEvent("DeagleArena.settingsWillkommensnachricht",true)
addEventHandler("DeagleArena.settingsWillkommensnachricht",root,function(willkommensnachricht)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		if(isPremium(client))then
			DeagleArena.lobbys[LobbyID]["Willkommensnachricht"] = willkommensnachricht;
			dbExec(handler,"UPDATE deaglelobbys SET Willkommensnachricht = '"..willkommensnachricht.."' WHERE Besitzer = '"..getPlayerName(client).."'");
			infobox(client,loc(client,"DeagleArenaMessage12"),0,125,0);
		else infobox(client,loc(client,"DeagleArenaMessage11"),125,0,0)end
	else infobox(client,loc(client,"DeagleArenaMessage10"),125,0,0)end
end)

-- Map
addEvent("DeagleArena.settingsMap",true)
addEventHandler("DeagleArena.settingsMap",root,function(map)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		if(isPremium(client) and hasGoldPremium(client))then
			DeagleArena.lobbys[LobbyID]["Map"] = map;
			dbExec(handler,"UPDATE deaglelobbys SET Map = '"..map.."' WHERE Besitzer = '"..getPlayerName(client).."'");
			infobox(client,loc(client,"DeagleArenaMessage15"),0,125,0);
			
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"Lobby") == "DeagleArena" and getElementDimension(v) == getElementData(client,"LobbyID"))then
					DeagleArena.spawnPlayer(v);
				end
			end
		else infobox(client,loc(client,"DeagleArenaMessage14"),125,0,0)end
	else infobox(client,loc(client,"DeagleArenaMessage13"),125,0,0)end
end)

-- Passwort
addEvent("DeagleArena.settingsPasswort",true)
addEventHandler("DeagleArena.settingsPasswort",root,function(passwort)
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeagleArena.lobbys[LobbyID]["Passwort"] = passwort;
		infobox(client,loc(client,"DeagleArenaMessage17"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"UPDATE deaglelobbys SET Passwort = '"..passwort.."' WHERE Besitzer = '"..getPlayerName(client).."'");
		end
	else infobox(client,loc(client,"DeagleArenaMessage16"),125,0,0)end
end)

-- Lobby löschen
addEvent("DeagleArena.deleteLobby",true)
addEventHandler("DeagleArena.deleteLobby",root,function()
	local LobbyID = getElementData(client,"LobbyID");
	local besitzer = DeagleArena.lobbys[LobbyID]["Besitzer"];
	if(besitzer == getPlayerName(client))then
		DeagleArena.lobbys[LobbyID] = nil;
		infobox(client,loc(client,"DeagleArenaMessage19"),0,125,0);
		if(isPremium(client))then
			dbExec(handler,"DELETE FROM deaglelobbys WHERE Besitzer = '"..getPlayerName(client).."'");
		end
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "DeagleArena")then
				if(getElementData(v,"LobbyID") == LobbyID)then
					RegisterLogin.spawnEingangshalle(v);
				end
			end
		end
		triggerClientEvent(client,"setWindowDatas",client,"reset");
	else infobox(client,loc(client,"DeagleArenaMessage18"),125,0,0)end
end)

--// Spieler will einer Deagle Lobby beitreten
addEvent("DeagleArena.joinLobby",true)
addEventHandler("DeagleArena.joinLobby",root,function(id,besitzer,passwort)
	local id = tonumber(id);
	if(DeagleArena.lobbys[id] and DeagleArena.lobbys[id]["Besitzer"] == besitzer)then
		if(passwort)then
			if(DeagleArena.lobbys[id]["Passwort"] ~= passwort)then
				infobox(client,loc(client,"DeagleArenaMessage5"),125,0,0)
				return false
			end
		end
		if(DeagleArena.lobbys[id]["SpielerInLobby"] < DeagleArena.lobbys[id]["Limit"])then
			local tbl = DeagleArena.lobbys[id];
			local lobbyID = tbl["ID"];
			setElementData(client,"Lobby","DeagleArena");
			setElementData(client,"LobbyID",lobbyID);
			DeagleArena.lobbys[lobbyID]["SpielerInLobby"] = DeagleArena.lobbys[lobbyID]["SpielerInLobby"] + 1;
			DeagleArena.spawnPlayer(client);
			triggerClientEvent(client,"setWindowDatas",client,"reset");
			outputChatBox(DeagleArena.lobbys[id]["Willkommensnachricht"],client,255,255,255);
		else infobox(client,loc(client,"DeagleArenaMessage26"),125,0,0)end
	else infobox(client,loc(client,"DeagleArenaMessage1"),125,0,0)end
end)

--// Spieler wird in der beigetretenden Lobby gespawnt
local DeagleArenaLobbySpawns = {
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

function DeagleArena.spawnPlayer(player)
	takeAllWeapons(player);
	local LobbyID = getElementData(player,"LobbyID");
	local rnd = math.random(1,#DeagleArenaLobbySpawns[DeagleArena.lobbys[LobbyID]["Map"]]);
	local tbl = DeagleArenaLobbySpawns[DeagleArena.lobbys[LobbyID]["Map"]][rnd];
	local x,y,z,rot = tbl[1],tbl[2],tbl[3],tbl[4];
	spawnPlayer(player,x,y,z,rot,getElementData(player,"SkinID"),LobbyMaps[DeagleArena.lobbys[LobbyID]["Map"]],getElementData(player,"LobbyID"));
	giveWeapon(player,24,9999);
	setPedArmor(player,100);
	setPedHeadless(player,false);
end

--// Was passiert, wenn der Spieler in einer Deagle Lobby stirbt
addEventHandler("onPlayerWasted",root,function()
	if(getElementData(source,"Lobby") == "DeagleArena")then
		setElementData(source,"TodeDeagleArena",getElementData(source,"TodeDeagleArena")+1);
		setElementData(source,"TodeGesamt",getElementData(source,"TodeGesamt")+1);
		DeagleArena.timer[source] = setTimer(function(source)
			DeagleArena.spawnPlayer(source);
		end,5000,1,source)
		setElementData(source,"TemporaererDamage",0);
		setElementData(source,"TemporaererKill",0);
		checkTodeAchievement(source);
	end
end)

--// Was passiert, wenn der Spieler in einer Deagle Lobby ist und den Server verlässt
addEventHandler("onPlayerQuit",root,function()
	if(isTimer(DeagleArena.timer[source]))then killTimer(DeagleArena.timer[source])end
	if(getElementData(source,"Lobby") == "DeagleArena")then
		local ID = getElementData(source,"LobbyID");
		DeagleArena.lobbys[ID]["SpielerInLobby"] = DeagleArena.lobbys[ID]["SpielerInLobby"] - 1;
		if(DeagleArena.lobbys[ID]["SpielerInLobby"] == 0)then
			if(DeagleArena.lobbys[ID]["Premium"] == 0)then
				DeagleArena.lobbys[ID] = nil;
			end
		end
	end
end)

--// Spieler verlässt Lobby
addCommandHandler("leave",function(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "DeagleArena")then
		if(isTimer(DeagleArena.timer[player]))then killTimer(DeagleArena.timer[player])end
		local ID = getElementData(player,"LobbyID");
		DeagleArena.lobbys[ID]["SpielerInLobby"] = DeagleArena.lobbys[ID]["SpielerInLobby"] - 1;
		if(DeagleArena.lobbys[ID]["SpielerInLobby"] == 0)then
			if(DeagleArena.lobbys[ID]["Premium"] == 0)then
				DeagleArena.lobbys[ID] = nil;
			end
		end
		RegisterLogin.spawnEingangshalle(player);
		RegisterLogin.savePlayerDatas(player);
		setElementData(player,"TemporaererDamage",0);
		setElementData(player,"TemporaererKill",0);
	end
end)

--// Lobbys laden
addEvent("DeagleArena.loadLobbys",true)
addEventHandler("DeagleArena.loadLobbys",root,function()
	local lobbys = DeagleArena.lobbys;
	triggerClientEvent(client,"DeagleArena.refreshList",client,lobbys);
end)

--// Lobby Einstellungen öffnen
function DeagleArena.openEinstellungen(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "DeagleArena")then
		local ID = getElementData(player,"LobbyID");
		triggerClientEvent(player,"DeagleArena.openEinstellungen",player,DeagleArena.lobbys[ID]["Besitzer"]);
	end
end