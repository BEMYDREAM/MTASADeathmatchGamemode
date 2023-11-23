RegisterLogin = {payday = {}};

--// Datenbankverbindung herstellen
handler = dbConnect("mysql","dbname=deathmatch;host=127.0.0.1","root","");

if(handler)then
	outputDebugString("Database connection was successful");
else
	outputDebugString("No database connection!");
end

--// Checken, ob Spieler bereits einen Account hat oder nicht
addEvent("RegisterLogin.checkAccount",true)
addEventHandler("RegisterLogin.checkAccount",root,function()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Serial = '"..getPlayerSerial(client).."'"),-1);
	if(#result >= 1)then
		setPlayerName(client,getPlayerData("userdata","Serial",getPlayerSerial(client),"Username"));
		RegisterLogin.eingangshalle(client);
	else
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Username = '"..getPlayerName(client).."'"),-1);
		if(#result >= 1)then
			triggerClientEvent(client,"RegisterLogin.createWindow",client,"Einloggen");
		else
			triggerClientEvent(client,"RegisterLogin.createWindow",client,"Registrieren");
		end
	end
end)

--// Daten aus Datenbank bekomen
function getPlayerData(from,where,name,data)
	if(from and where and name and data)then
		local sql = dbQuery(handler,"SELECT * FROM "..from.." WHERE "..where.." = '"..name.."'");
		if(sql)then
			local rows = dbPoll(sql,-1);
			for _,v in pairs(rows)do
				return v[data];
			end
		end
	end
end

--// Registrieren / Einloggen
addEvent("RegisterLogin.server",true)
addEventHandler("RegisterLogin.server",root,function(type,passwort)
	if(type == "Registrieren" or type == "Register")then
		local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Username = '"..getPlayerName(client).."'"),-1);
		if(#result == 0)then
			local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata WHERE Serial = '"..getPlayerSerial(client).."'"),-1);
			if(#result == 0)then
				local hashedPassword = passwordHash(passwort,"bcrypt",{});
				if(hashedPassword)then
					dbExec(handler,"INSERT INTO userdata (Username,Passwort,Serial) VALUES ('"..getPlayerName(client).."','"..hashedPassword.."','"..getPlayerSerial(client).."')");
					dbExec(handler,"INSERT INTO achievements (Username) VALUES ('"..getPlayerName(client).."')");
					dbExec(handler,"UPDATE userdata SET Skins = '0|' WHERE Username = '"..getPlayerName(client).."'");
					RegisterLogin.eingangshalle(client);
					infobox(client,loc(client,"RegisterLoginMessage3"),0,125,0);
				end
			else infobox(client,loc(client,"RegisterLoginMessage2"):format(getPlayerData("userdata","Serial",getPlayerSerial(client),"Username")),125,0,0)end
		else infobox(client,loc(client,"RegisterLoginMessage1"),125,0,0)end
	elseif(type == "Einloggen" or type == "Login")then
		local hashedPassword = getPlayerData("userdata","Username",getPlayerName(client),"Passwort");
		if(passwordVerify(passwort,hashedPassword))then
			RegisterLogin.eingangshalle(client);
			dbExec(handler,"UPDATE userdata SET Serial = '"..getPlayerSerial(client).."' WHERE Username = '"..getPlayerName(client).."'");
			infobox(client,loc(client,"RegisterLoginMessage5"),0,125,0);
		else infobox(client,loc(client,"RegisterLoginMessage4"),125,0,0)end
	end
end)

--// Alles, was passieren soll, nachdem der Spieler sich eingeloggt oder registriert hat
local Datas = {"Geld","UnnamedCoins","Spielstunden","KillsGesamt","TodeGesamt","KillsTacticArena","TodeTacticArena","KillsDeagleArena","TodeDeagleArena","KillsDeathmatch","TodeDeathmatch","DamageGesamt","DamageTacticArena","DamageDeagleArena","DamageDeathmatch","Adminlevel","VIPBronzeZeit","VIPSilberZeit","VIPGoldZeit","SkinID","DeagleKills","Mp5Kills","M4Kills","RifleKills","Status","KillsLastHour","YakuzaSkin","AngelsOfDeathSkin","Pokale","MVPsGesamt","MVPsTactics","Achievements","Lootbox","LootboxenOpen"};

function RegisterLogin.eingangshalle(player)
	for _,v in pairs(Datas)do
		setElementData(player,v,getPlayerData("userdata","Username",getPlayerName(client),v));
	end
	setElementData(player,"TemporaererDamage",0);
	setElementData(player,"TemporaererKill",0);
	setElementData(player,"PremiumLevel",0);
	outputChatBox(loc(player,"RegisterLoginMessage6"),player,255,255,255,true);
	if(isPremium(player))then
		if(hasBronzePremium(player))then
			setElementData(player,"PremiumLevel",1);
			outputChatBox(loc(player,"RegisterLoginMessage14"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(player),"VIPBronzeZeit"))),player,0,125,0);
		end
		if(hasSilberPremium(player))then
			setElementData(player,"PremiumLevel",2);
			outputChatBox(loc(player,"RegisterLoginMessage15"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(player),"VIPSilberZeit"))),player,0,125,0);
		end
		if(hasGoldPremium(player))then
			setElementData(player,"PremiumLevel",3)
			outputChatBox(loc(player,"RegisterLoginMessage16"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(player),"VIPGoldZeit"))),player,0,125,0);
		end
	else
		outputChatBox(loc(client,"RegisterLoginMessage7"),player,125,0,0);
	end
	RegisterLogin.spawnEingangshalle(player);
	triggerClientEvent(player,"RegisterLogin.destroy",player);
	setElementData(player,"loggedin",1);
	bindKey(player,"f2","down",DeagleArena.openEinstellungen);
	bindKey(player,"f2","down",DeathmatchArena.openEinstellungen);
	bindKey(player,"f5","down",Achievements.openWindow);
	outputChatBox(loc(player,"RegisterLoginMessage17"),player,255,0,0);
	Adminsystem.bindKey(player);
	bindKey(player,"m","down",Tactics.openMaps);
	
	for i = 69,79 do setPedStat(player,i,1000) end
	
	RegisterLogin.payday[player] = setTimer(function(player)
		VIP.checkStatus(player);
		setElementData(player,"Spielstunden",getElementData(player,"Spielstunden")+1);
		if(math.floor(getElementData(player,"Spielstunden")/60) == (getElementData(player,"Spielstunden")/60))then
			if(isPremium(player))then
				local KillsLastHour = getElementData(player,"KillsLastHour");
				local Bonus;
				if(hasBronzePremium(player))then Bonus = KillsLastHour*125 end
				if(hasSilberPremium(player))then Bonus = KillsLastHour*175 end
				if(hasGoldPremium(player))then Bonus = KillsLastHour*250 end
				
				outputChatBox(loc(player,"RegisterLoginMessage18"),player,255,255,255);
				outputChatBox(loc(player,"RegisterLoginMessage19"):format(Bonus),player,0,125,0);
				setElementData(player,"Geld",getElementData(player,"Geld")+Bonus);
			end
			setElementData(player,"KillsLastHour",0);
		end
		if(getElementData(player,"Spielstunden") == 600)then setPlayerAchievement(player,29)end
		if(getElementData(player,"Spielstunden") == 1500)then setPlayerAchievement(player,30)end
		if(getElementData(player,"Spielstunden") == 3000)then setPlayerAchievement(player,31)end
		if(getElementData(player,"Spielstunden") == 4500)then setPlayerAchievement(player,32)end
		if(getElementData(player,"Spielstunden") == 6000)then setPlayerAchievement(player,33)end
		if(getElementData(player,"Spielstunden") == 15000)then setPlayerAchievement(player,34)end
		if(getElementData(player,"Spielstunden") == 30000)then setPlayerAchievement(player,35)end
		if(getElementData(player,"Spielstunden") == 45000)then setPlayerAchievement(player,36)end
		if(getElementData(player,"Spielstunden") == 60000)then setPlayerAchievement(player,37)end
	end,60000,0,player)
	
	outputDebugString("[REGISTER LOGIN] "..getPlayerName(player).." wurde in seinen Account eingeloggt");
end

--// Daten speichern
function RegisterLogin.savePlayerDatas(player)
	if(getElementData(player,"loggedin") == 1)then
		for _,v in pairs(Datas)do
			dbExec(handler,"UPDATE userdata SET "..v.." = '"..getElementData(player,v).."' WHERE Username = '"..getPlayerName(player).."'");
		end
		outputDebugString("[REGISTER LOGIN] Die Daten von "..getPlayerName(player).." wurden gespeichert.");
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(RegisterLogin.payday[source]))then killTimer(RegisterLogin.payday[source])end
	RegisterLogin.savePlayerDatas(source)
end)

--// Spieler in der Eingangshalle spawnen lassen
function RegisterLogin.spawnEingangshalle(player)
	VIP.checkStatus(player);
	if(isPremium(player))then
		spawnPlayer(player,1719.5563964844,-1643.4763183594,20.225696563721,180,getElementData(player,"SkinID"),18,0);
	else
		spawnPlayer(player,273.20712280273,-16.454977035522,2.1112470626831,175,getElementData(player,"SkinID"),0,0);
	end
	setElementData(player,"Lobby","Eingangshalle");
	setCameraTarget(player);
	toggleAllControls(player,true);
	triggerClientEvent(player,"setGamespeed",player,1);
	setPedHeadless(player,false);
end