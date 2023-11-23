Waffenshop = {
	["Waffen"] = { -- Waffen-ID, Munition, Preis, Anzahl verfügbar
		[1] = {18,2,4500,50}, -- Molotovs
		[2] = {16,2,5000,50}, -- Granaten
		[3] = {32,200,3500,50}, -- Tec-9
		[4] = {35,3,8500,50}, -- Raketenwerfer
		[5] = {39,2,10000,50}, -- Satchels
		[6] = {34,5,6000,50}, -- Sniper
		[7] = {27,14,5000,50}, -- Combat
		[8] = {38,1000,75000,50}, -- Minigun
	},
};

--// Waffe kaufen
addEvent("Waffenshop.buyWeapon",true)
addEventHandler("Waffenshop.buyWeapon",root,function(weapon)
	if(getElementData(client,"Lobby") == "TacticsArena")then
		local weapon = tonumber(weapon);
		if(Waffenshop["Waffen"][weapon][4] > 0)then
			local Costs = Waffenshop["Waffen"][weapon][3];
			if(hasBronzePremium(client))then Costs = Costs - (Costs/100*10) end
			if(hasSilberPremium(client))then Costs = Costs - (Costs/100*15) end
			if(hasGoldPremium(client))then Costs = Costs - (Costs/100*25) end
			Costs = tonumber(math.floor(Costs));
			if(tonumber(getElementData(client,"Geld")) >= Costs)then
				if(not(isPedDead(client)) and getElementData(client,"SpectatormodeAktiv") ~= true)then
					local time = getRealTime();
					local checkBuy = tonumber(getPlayerData("userdata","Username",getPlayerName(client),"Waffenshopbuy"));
					if(checkBuy == 0 or time.timestamp > checkBuy)then
						dbExec(handler,"UPDATE userdata SET Waffenshopbuy = '0' WHERE Username = '"..getPlayerName(client).."'");
						giveWeapon(client,Waffenshop["Waffen"][weapon][1],Waffenshop["Waffen"][weapon][2],true);
						infobox(client,loc(client,"WaffenshopMessage4"),0,125,0);
						Waffenshop["Waffen"][weapon][4] = Waffenshop["Waffen"][weapon][4] - 1;
						setElementData(client,"Geld",getElementData(client,"Geld")-Costs);
						dbExec(handler,"UPDATE userdata SET Waffenshopbuy = '"..time.timestamp + 900 .."' WHERE Username = '"..getPlayerName(client).."'");
					else infobox(client,loc(client,"WaffenshopMessage6"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(client),"Waffenshopbuy"))),125,0,0)end
				else infobox(client,loc(client,"WaffenshopMessage5"),125,0,0)end
			else infobox(client,loc(client,"WaffenshopMessage3"):format(Costs),125,0,0)end
		else infobox(client,loc(client,"WaffenshopMessage2"),125,0,0)end
	else infobox(client,loc(client,"WaffenshopMessage1"),125,0,0)end
end)

--// Waffen auffüllen
setTimer(function()
	local time = getRealTime();
	if(time.hour >= 0 and time.minute <= 2)then
		Waffenshop["Waffen"][1][4] = 50;
		Waffenshop["Waffen"][2][4] = 50;
		Waffenshop["Waffen"][3][4] = 50;
		Waffenshop["Waffen"][4][4] = 50;
		Waffenshop["Waffen"][5][4] = 50;
		Waffenshop["Waffen"][6][4] = 50;
		Waffenshop["Waffen"][7][4] = 50;
		Waffenshop["Waffen"][8][4] = 50;
	end
end,60000,0)