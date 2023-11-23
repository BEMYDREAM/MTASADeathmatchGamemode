Tactics = { angelsofdeath = 0, yakuza = 0, angelsofdeathPlayers = {}, yakuzaPlayers = {}, specID = {}, aktuelleMap = nil, nextMap = nil, kill = {}, roundAktiv = false,
	["Namen"] = {
		[1] = "Angels of Death",
		[2] = "Yakuza",
	},
	["Skin"] = {
		[1] = 181,
		[2] = 141,
	},
	["Maps"] = {
		["Namen"] = {"Drogenlabor SF","Drogenschiff","Lagerhalle SF","Skaterpark","Glen Park","Ghetto LS","Einkaufszentrum","Einkaufsstraße","Friedhof LS","Piratenschiff","Lagerhalle LV","LV Stadthalle"},
		["Spawn"] = { -- x,y,z,rot,int
			["Drogenlabor SF"] = {
				[1] = {-2099.2319335938,-278.01873779297,35.3203125,0,0},
				[2] = {-2152.4384765625,-97.944152832031,35.3203125,180,0},
			},
			["Drogenschiff"] = {
				[1] = {-1471.0573730469,1489.2056884766,8.2578125,270,0},
				[2] = {-1364.8922119141,1489.3759765625,11.039063453674,90,0},
			},
			["Lagerhalle SF"] = {
				[1] = {-611.70098876953,-498.86032104492,25.5234375,270,0},
				[2] = {-477.16180419922,-539.70562744141,25.529611587524,90,0},
			},
			["Skaterpark"] = {
				[1] = {1865.1938476563,-1449.3616943359,13.49472618103,0,0},
				[2] = {1962.6671142578,-1362.7640380859,18.578125,180,0},
			},
			["Glen Park"] = {
				[1] = {2055.2043457031,-1227.7006835938,23.864761352539,90,0},
				[2] = {1882.2764892578,-1151.7680664063,24.015689849854,270,0},
			},
			["Ghetto LS"] = {
				[1] = {2083.76953125,-1601.5306396484,13.537823677063,0,0},
				[2] = {2058.5554199219,-1540.1590576172,13.476563453674,180,0},
			},
			["Einkaufszentrum"] = {
				[1] = {1127.2017822266,-1561.4427490234,22.746551513672,0,0},
				[2] = {1128.9581298828,-1424.5174560547,22.775131225586,180,0},
			},
			["Einkaufsstraße"] = {
				[1] = {1035.6071777344,-1231.4058837891,16.854965209961,180,0},
				[2] = {974.20709228516,-1309.1142578125,13.382813453674,0,0},
			},
			["Friedhof LS"] = {
				[1] = {950.83721923828,-1103.4671630859,23.974866867065,90,0},
				[2] = {823.03332519531,-1102.8675537109,25.797966003418,270,0},
			},
			["Piratenschiff"] = {
				[1] = {1965.5998535156,1623.1431884766,12.862547874451,270,0},
				[2] = {1893.0341796875,1595.9675292969,10.553008079529,180,0},
			},
			["Lagerhalle LV"] = {
				[1] = {1579.3692626953,2332.7351074219,10.820313453674,270,0},
				[2] = {1741.8402099609,2316.5966796875,10.820313453674,90,0},
			},
			["LV Stadthalle"] = {
				[1] = {2361.4809570313,2401.6020507813,10.820313453674,180,0},
				[2] = {2316.6953125,2244.9333496094,10.820313453674,0,0},
			},
		},
		["Mapgrenze"] = { -- x1,y1,x2,y2
			["Drogenlabor SF"] = {-2203.154296875,-284.34454345703,-2094.2270507813,-78.926330566406},
			["Drogenschiff"] = {-1490.0876464844,1475.0433349609,-1350.1525878906,1503.2384033203},
			["Lagerhalle SF"] = {-624.19976806641,-565.49951171875,-463.24728393555,-466.82052612305},
			["Skaterpark"] = {1861.3679199219,-1452.1564941406,1977.6717529297,-1349.9234619141},
			["Glen Park"] = {1861.2435302734,-1252.0042724609,2057.65625,-1144.6918945313},
			["Ghetto LS"] = {2054.8627929688,-1603.8852539063,2104.5205078125,-1535.5390625},
			["Einkaufszentrum"] = {1046.4693603516,-1562.7998046875,1186.6069335938,-1413.59375},
			["Einkaufsstraße"] = {950.62213134766,-1312.3284912109,1044.5671386719,-1228.9783935547},
			["Friedhof LS"] = {806.71099853516,-1130.9647216797,954.40197753906,-1053.7711181641},
			["Piratenschiff"] = {1838.7930908203,1465.7979736328,2033.7846679688,1704.2756347656},
			["Lagerhalle LV"] = {1576.0897216797,2281.3698730469,1759.8479003906,2430.1616210938},
			["LV Stadthalle"] = {2296.5190429688,2241.8083496094,2418.5051269531,2403.9895019531},
		},
	},
};

--// Spieler in ein Team tun
function Tactics.putPlayerInTeam(player)
	local rnd;
	local loadNewMap = false;
	if(Tactics.angelsofdeath < Tactics.yakuza)then rnd = 1 end
	if(Tactics.yakuza < Tactics.angelsofdeath)then rnd = 2 end
	if(Tactics.yakuza == Tactics.angelsofdeath)then rnd = math.random(1,2)end
	if(Tactics.yakuza == 0 or Tactics.angelsofdeath == 0)then
		loadNewMap = true;
	end
	setElementData(player,"TacticsTeam",rnd);
	if(rnd == 1)then
		Tactics.angelsofdeath = Tactics.angelsofdeath + 1;
		table.insert(Tactics.angelsofdeathPlayers,getPlayerName(player));
	elseif(rnd == 2)then
		Tactics.yakuza = Tactics.yakuza + 1;
		table.insert(Tactics.yakuzaPlayers,getPlayerName(player));
	end
	Tactics.specID[player] = 1;
	bindKey(player,"arrow_l","down",Tactics.switchTarget);
	bindKey(player,"arrow_r","down",Tactics.switchTarget);
	if(loadNewMap == true)then
		Tactics.loadNewMap();
	end
	if(Tactics.roundAktiv == true)then
		Tactics.switchTarget(player);
	else
		if(getElementData(player,"SpectatormodeAktiv") ~= true)then
			Tactics.spawnPlayer(player);
		end
	end
end

addEvent("Tactics.putPlayerInTeam",true)
addEventHandler("Tactics.putPlayerInTeam",root,function()
	if(getElementData(client,"Lobby") ~= "TacticsArena")then
		setElementData(client,"TacticsFirstRound",true);
		setElementData(client,"Lobby","TacticsArena");
		Tactics.putPlayerInTeam(client);
	end
end)

--// Spieler sortieren
function Tactics.sortPlayer()
	Tactics.angelsofdeath = 0;
	Tactics.yakuza = 0;
	Tactics.angelsofdeathPlayers = {};
	Tactics.yakuzaPlayers = {};
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
			local rnd;
			if(Tactics.angelsofdeath < Tactics.yakuza)then rnd = 1 end
			if(Tactics.yakuza < Tactics.angelsofdeath)then rnd = 2 end
			if(Tactics.yakuza == Tactics.angelsofdeath)then rnd = math.random(1,2)end

			setElementData(v,"TacticsTeam",rnd);
			if(rnd == 1)then
				Tactics.angelsofdeath = Tactics.angelsofdeath + 1;
				table.insert(Tactics.angelsofdeathPlayers,getPlayerName(v));
			elseif(rnd == 2)then
				Tactics.yakuza = Tactics.yakuza + 1;
				table.insert(Tactics.yakuzaPlayers,getPlayerName(v));
			end
		end
	end
end

--// Map laden
function Tactics.loadNewMap()
	Tactics.zeitCounter = 300;
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"TacticsFirstRound") ~= true and getElementData(v,"Lobby") == "TacticsArena")then
			local dmg,kills = getElementData(v,"TemporaererDamage"),getElementData(v,"TemporaererKill");
			local dmgMoney,killsMoney = math.floor(dmg*1),math.floor(kills*75);
			if(hasBronzePremium(v))then dmgMoney = dmg*2 killsMoney = kills*100 end
			if(hasSilberPremium(v))then dmgMoney = dmg*3 killsMoney = kills*125 end
			if(hasGoldPremium(v))then dmgMoney = dmg*4 killsMoney = kills*150 end
			local gesamtMoney = dmgMoney+killsMoney;
			outputChatBox(loc(v,"TacticArenaMessage2"),v,255,255,255);
			outputChatBox(loc(v,"TacticArenaMessage3"):format(dmg,kills,gesamtMoney),v,0,125,0);
			setElementData(v,"Geld",getElementData(v,"Geld")+gesamtMoney);
		end
		setElementData(v,"SpectatormodeAktiv",false);
		setElementData(v,"Tactics.zeitCounter",Tactics.zeitCounter);
		setElementData(v,"TemporaererDamage",0);
		setElementData(v,"TemporaererKill",0);
		setElementData(v,"TacticsFirstRound",false);
	end

	if(isTimer(Tactics.zeitAusgelaufen))then killTimer(Tactics.zeitAusgelaufen)end
	if(isElement(Tactics.radarzone))then destroyElement(Tactics.radarzone)end
	if(isElement(Tactics.radarColshape))then destroyElement(Tactics.radarColshape)end
	if(isTimer(Tactics.startMapTimer))then killTimer(Tactics.startMapTimer)end
	if(isTimer(Tactics.countdownTimer))then killTimer(Tactics.countdownTimer)end
	if(isTimer(Tactics.loadNextMap))then killTimer(Tactics.loadNextMap)end
	for _,v in pairs(getElementsByType("player"))do
		triggerClientEvent(v,"Tactics.destroyRedBildschirm",v);
		triggerClientEvent(v,"Tactics.countdownDestroy",v,"nosound");
	end
	Tactics.sortPlayer();
	local rnd = math.random(1,#Tactics["Maps"]["Namen"]);
	if(Tactics.nextMap ~= nil)then
		Tactics.aktuelleMap = Tactics.nextMap;
	else
		Tactics.aktuelleMap = Tactics["Maps"]["Namen"][rnd];
	end
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena" and getElementData(v,"SpectatormodeAktiv") ~= true)then
			Tactics.spawnPlayer(v);
		end
	end
	Tactics.nextMap = nil;
	
	if(Tactics["Maps"]["Mapgrenze"][Tactics.aktuelleMap])then
		local tbl = Tactics["Maps"]["Mapgrenze"][Tactics.aktuelleMap];
		local rx1,ry1 = tonumber(tbl[1]),tonumber(tbl[2]);
		local rx2,ry2 = tonumber(tbl[3]),tonumber(tbl[4]);
		local rxs,rys = math.abs(rx1-rx2),math.abs(ry1-ry2);
		Tactics.radarzone = createRadarArea(rx1,ry1,rxs,rys,255,0,0,130,root);
		Tactics.radarColshape = createColCuboid(rx1,ry1,-50,rxs,rys,7500);
		setElementDimension(Tactics.radarzone,65535);
		setElementDimension(Tactics.radarColshape,65535);
	
		addEventHandler("onColShapeHit",Tactics.radarColshape,function(player)
			if(getElementDimension(player) == getElementDimension(source))then
				if(isTimer(Tactics.kill[player]))then
					killTimer(Tactics.kill[player]);
				end
				triggerClientEvent(player,"Tactics.destroyRedBildschirm",player);
			end
		end)
		
		addEventHandler("onColShapeLeave",Tactics.radarColshape,function(player)
			if(getElementDimension(player) == getElementDimension(source))then
				Tactics.kill[player] = setTimer(function(player)
					killPed(player);
					triggerClientEvent(player,"Tactics.destroyRedBildschirm",player);
				end,10000,1,player)
				triggerClientEvent(player,"Tactics.createRedBildschirm",player)
			end
		end)
	end
	
	Tactics.startMapTimer = setTimer(function()	
		local counter = 3;
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
				triggerClientEvent(v,"Tactics.createCountdown",v,counter);
			end
		end
		Tactics.countdownTimer = setTimer(function()
			counter = counter - 1;
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
					triggerClientEvent(v,"Tactics.countdownRefresh",v,counter);
				end
			end
			if(counter == 0)then
				Tactics.roundAktiv = true;
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
						setElementFrozen(v,false);
						triggerClientEvent(v,"Tactics.countdownDestroy",v);
						toggleAllControls(v,true);
					end
				end
				setRadarAreaFlashing(Tactics.radarzone,true);
				Tactics.zeitAusgelaufen = setTimer(function()
					Tactics.zeitCounter = Tactics.zeitCounter - 1;
					for _,v in pairs(getElementsByType("player"))do
						setElementData(v,"Tactics.zeitCounter",Tactics.zeitCounter);
					end
					if(Tactics.zeitCounter == 0)then
						for _,v in pairs(getElementsByType("player"))do
							if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
								infobox(v,loc(v,"TacticArenaMessage13"),0,125,0);
								triggerClientEvent(v,"setGamespeed",v,0.4);
							end
						end
						Tactics.loadNextMap = setTimer(function()
							Tactics.loadNewMap();
						end,5000,1)
					end
				end,1000,300)
			end
		end,1000,3)
	end,4000,1)
end

--// Nächste Map setzen
addEvent("Tactics.setNextMap",true)
addEventHandler("Tactics.setNextMap",root,function(map)
	local time = getRealTime();
	local result = tonumber(getPlayerData("userdata","Username",getPlayerName(client),"NextMapTimer"));
	if(hasSilberPremium(client) or hasGoldPremium(client))then
		if(result == 0 or time.timestamp > result)then
			if(Tactics.nextMap == nil)then
				local NextMapTimerTime;
				if(hasSilberPremium(client))then nextMapTimerTime = time.timestamp + 3600 end
				if(hasGoldPremium(client))then nextMapTimerTime = time.timestamp + 1800 end
				dbExec(handler,"UPDATE userdata SET NextMapTimer = '0' WHERE Username = '"..getPlayerName(client).."'");
				Tactics.nextMap = map;
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
						outputChatBox(loc(v,"TacticArenaMessage7"):format(getPlayerName(client),map),v,255,255,255,true);
					end
				end
				dbExec(handler,"UPDATE userdata SET NextMapTimer = '"..nextMapTimerTime.."' WHERE Username = '"..getPlayerName(client).."'");
			else infobox(client,loc(client,"TacticArenaMessage6"),125,0,0)end
		else infobox(client,loc(client,"TacticArenaMessage5"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(client),"NextMapTimer"))),125,0,0)end
	else infobox(client,loc(client,"TacticArenaMessage4"),125,0,0)end
end)

function Tactics.openMaps(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "TacticsArena" and hasSilberPremium(player) or hasGoldPremium(player))then
		triggerClientEvent(player,"Tactics.nextMap",player);
	end
end

--// Spieler auf Map spawnen lassen
function Tactics.spawnPlayer(player)
	local team = getElementData(player,"TacticsTeam");
	local tbl = Tactics["Maps"]["Spawn"][Tactics.aktuelleMap][team];
	local x,y,z,rot,int,dim,skin = tbl[1],tbl[2],tbl[3],tbl[4],tbl[5],65535,Tactics["Skin"][team];
	if(getElementData(player,"TacticsTeam") == 1)then
		spawnPlayer(player,x,y,z,rot,getElementData(player,"AngelsOfDeathSkin"),int,65535);
	else
		spawnPlayer(player,x,y,z,rot,getElementData(player,"YakuzaSkin"),int,65535);
	end
	takeAllWeapons(player);
	giveWeapon(player,24,9999);
	giveWeapon(player,29,9999);
	giveWeapon(player,31,9999);
	giveWeapon(player,33,9999);
	setElementHealth(player,100);
	setPedArmor(player,100);
	setElementFrozen(player,true);
	toggleAllControls(player,false);
	toggleControl(player,"chatbox",true);
	triggerClientEvent(player,"setGamespeed",player,1);
	setPedHeadless(player,false);
	setElementData(player,"SpectatormodeAktiv",false);
	setCameraTarget(player);
	setElementAlpha(player,255);
end

--// Spectatormode
function setSpectator(player,id)
	setElementData(player,"SpectatormodeAktiv",true);
	local team = getElementData(player,"TacticsTeam");
	local target;
	if(team == 1)then
		if(Tactics.angelsofdeathPlayers[id])then
			target = getPlayerFromName(Tactics.angelsofdeathPlayers[id]);
		end
	elseif(team == 2)then
		if(Tactics.yakuzaPlayers[id])then
			target = getPlayerFromName(Tactics.yakuzaPlayers[id]);
		end
	end
	if(target)then
		if(getPlayerName(target) == getPlayerName(player) or isPedDead(target))then
			Tactics.switchTarget(player);
		else
			setCameraTarget(player,target);
			setElementDimension(player,getElementDimension(target));
			setElementInterior(player,getElementInterior(target));
			setElementData(player,"TacticsSpectator",getPlayerName(target));
		end
	end
end

function Tactics.switchTarget(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Lobby") == "TacticsArena")then
		Tactics.specID[player] = Tactics.specID[player] + 1;
		local team = getElementData(player,"TacticsTeam");
		if(team == 1)then
			if(Tactics.specID[player] > #Tactics.angelsofdeathPlayers)then
				Tactics.specID[player] = 1;
			end
		elseif(team == 2)then
			if(Tactics.specID[player] > #Tactics.yakuzaPlayers)then
				Tactics.specID[player] = 1;
			end
		end
		setSpectator(player,Tactics.specID[player]);
	end
end

--// Befehl zum Verlassen der Lobby
addCommandHandler("leave",function(player)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Lobby") == "TacticsArena")then
			local team = getElementData(player,"TacticsTeam");
			if(team == 1)then
				Tactics.angelsofdeath = Tactics.angelsofdeath - 1;
				if(Tactics.angelsofdeath < 0)then Tactics.angelsofdeath = 0 end
				local tbl = {};
				for _,v in pairs(Tactics.angelsofdeathPlayers)do
					if(v ~= getPlayerName(player))then
						table.insert(tbl,v);
					end
				end
				Tactics.angelsofdeathPlayers = tbl;
			elseif(team == 2)then
				Tactics.yakuza = Tactics.yakuza - 1;
				if(Tactics.yakuza < 0 )then Tactics.yakuza = 0 end
				local tbl = {};
				for _,v in pairs(Tactics.yakuzaPlayers)do
					if(v ~= getPlayerName(player))then
						table.insert(tbl,v);
					end
				end
				Tactics.yakuzaPlayers = tbl;
			end
			unbindKey(player,"arrow_l","down",Tactics.switchTarget);
			unbindKey(player,"arrow_r","down",Tactics.switchTarget);
			RegisterLogin.spawnEingangshalle(player);
			if(Tactics.getAlivedPlayers(1) == 0 or Tactics.getAlivedPlayers(2) == 0)then
				if(isTimer(Tactics.zeitAusgelaufen))then killTimer(Tactics.zeitAusgelaufen)end
				if(isTimer(Tactics.startMapTimer))then killTimer(Tactics.startMapTimer)end
				if(isTimer(Tactics.countdownTimer))then killTimer(Tactics.countdownTimer)end
				if(isTimer(Tactics.loadNextMap))then killTimer(Tactics.loadNextMap)end
				for _,v in pairs(getElementsByType("player"))do
					triggerClientEvent(v,"Tactics.destroyRedBildschirm",v);
					triggerClientEvent(v,"Tactics.countdownDestroy",v,"nosound");
					if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
						if(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) >= 1)then
							infobox(v,loc(v,"TacticArenaMessage14"),0,125,0);
						elseif(Tactics.getAlivedPlayers(2) == 0 and Tactics.getAlivedPlayers(1) >= 1)then
							infobox(v,loc(v,"TacticArenaMessage15"),0,125,0);
						elseif(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) == 0)then
							infobox(v,loc(v,"TacticArenaMessage16"),0,125,0);
						end
						triggerClientEvent(v,"setGamespeed",v,0.4);
					end
				end
				Tactics.loadNextMap = setTimer(function()
					Tactics.loadNewMap();
				end,5000,1)
			end
			triggerClientEvent(player,"Tactics.countdownDestroy",player,"nosound");
			RegisterLogin.savePlayerDatas(player);
			setElementData(player,"TemporaererDamage",0);
			setElementData(player,"TemporaererKill",0);
		end
	end
end)

--// Was passieren soll, wenn der Spieler den Server verlässt
addEventHandler("onPlayerQuit",root,function()
	if(getElementData(source,"Lobby") == "TacticsArena")then
		local team = getElementData(source,"TacticsTeam");
		if(team == 1)then
			Tactics.angelsofdeath = Tactics.angelsofdeath - 1;
			if(Tactics.angelsofdeath < 0)then Tactics.angelsofdeath = 0 end
			local tbl = {};
			for _,v in pairs(Tactics.yakuzaPlayers)do
				if(v ~= getPlayerName(source))then
					table.insert(tbl,v);
				end
			end
			Tactics.angelsofdeathPlayers = tbl;
		elseif(team == 2)then
			Tactics.yakuza = Tactics.yakuza - 1;
			if(Tactics.yakuza < 0)then Tactics.yakuza = 0 end
			local tbl = {};
			for _,v in pairs(Tactics.yakuzaPlayers)do
				if(v ~= getPlayerName(source))then
					table.insert(tbl,v);
				end
			end
			Tactics.yakuzaPlayers = tbl;
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
					if(getElementData(v,"TacticsSpectator") and getElementData(v,"TacticsSpectator") == getPlayerName(source))then
						Tactics.switchTarget(v);
					end
				end
			end
		end
		if(Tactics.getAlivedPlayers(1) == 0 or Tactics.getAlivedPlayers(2) == 0)then
			if(isTimer(Tactics.zeitAusgelaufen))then killTimer(Tactics.zeitAusgelaufen)end
			if(isTimer(Tactics.startMapTimer))then killTimer(Tactics.startMapTimer)end
			if(isTimer(Tactics.countdownTimer))then killTimer(Tactics.countdownTimer)end
			if(isTimer(Tactics.loadNextMap))then killTimer(Tactics.loadNextMap)end
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
					if(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) >= 1)then
						infobox(v,loc(v,"TacticArenaMessage14"),0,125,0);
					elseif(Tactics.getAlivedPlayers(2) == 0 and Tactics.getAlivedPlayers(1) >= 1)then
						infobox(v,loc(v,"TacticArenaMessage15"),0,125,0);
					elseif(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) == 0)then
						infobox(v,loc(v,"TacticArenaMessage16"),0,125,0);
					end
					triggerClientEvent(v,"setGamespeed",v,0.4);
					triggerClientEvent(v,"Tactics.destroyRedBildschirm",v);
					triggerClientEvent(v,"Tactics.countdownDestroy",v,"nosound");
				end
			end
			Tactics.loadNextMap = setTimer(function()
				Tactics.loadNewMap();
			end,5000,1)
		end
	end
end)

--// Noch lebende Spieler abfragen
function Tactics.getAlivedPlayers(team)
	local counter = 0;
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
			if(getElementData(v,"TacticsTeam") == team and not(isPedDead(v)) and not(getElementData(v,"SpectatormodeAktiv") == true))then
				counter = counter + 1;
			end
		end
	end
	return counter;
end

--// Wenn ein Team stirbt
addEventHandler("onPlayerWasted",root,function(ammo,attacker,weapon,bodypart)
	if(getElementData(source,"Lobby") == "TacticsArena")then
		setElementData(source,"TodeTacticArena",getElementData(source,"TodeTacticArena")+1);
		setElementData(source,"TodeGesamt",getElementData(source,"TodeGesamt")+1);
		checkTodeAchievement(source);
		if(Tactics.getAlivedPlayers(1) == 0 or Tactics.getAlivedPlayers(2) == 0)then
			if(isTimer(Tactics.zeitAusgelaufen))then killTimer(Tactics.zeitAusgelaufen)end
			if(isTimer(Tactics.startMapTimer))then killTimer(Tactics.startMapTimer)end
			if(isTimer(Tactics.countdownTimer))then killTimer(Tactics.countdownTimer)end
			if(isTimer(Tactics.loadNextMap))then killTimer(Tactics.loadNextMap)end
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "TacticsArena")then
					if(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) >= 1)then
						infobox(v,loc(v,"TacticArenaMessage14"),0,125,0);
					elseif(Tactics.getAlivedPlayers(2) == 0 and Tactics.getAlivedPlayers(1) >= 1)then
						infobox(v,loc(v,"TacticArenaMessage15"),0,125,0);
					elseif(Tactics.getAlivedPlayers(1) == 0 and Tactics.getAlivedPlayers(2) == 0)then
						infobox(v,loc(v,"TacticArenaMessage16"),0,125,0);
					end
					triggerClientEvent(v,"setGamespeed",v,0.4);
					triggerClientEvent(v,"Tactics.destroyRedBildschirm",v);
					triggerClientEvent(v,"Tactics.countdownDestroy",v,"nosound");
				end
			end
			Tactics.loadNextMap = setTimer(function()
				Tactics.loadNewMap();
			end,5000,1)
		else
			Tactics.switchTarget(source);
		end
	end
end)