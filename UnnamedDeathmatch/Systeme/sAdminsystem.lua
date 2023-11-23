Adminsystem = {
	["Raenge"] = {
		[1] = "Probe-Supporter",
		[2] = "Supporter",
		[3] = "Moderator",
		[4] = "Administrator",
		[5] = "Projektleiter",
		[6] = "Adelig",
	},
};

--// Bannen und entbannen
addCommandHandler("aban",function(player,cmd,target,time,reason)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Adminlevel") >= 2)then
			if(target and time and reason)then
				local result = dbPoll(dbQuery(handler,"SELECT * FROM bannedplayers WHERE Username = '"..target.."'"),-1);
				if(#result == 0)then
					local newTime = time * 3600;
					local targetPlayer = getPlayerFromName(target);
					if(tonumber(time) == 0)then endTime = 0 else endTime = getRealTime().timestamp + newTime end
					dbExec(handler,"INSERT INTO bannedplayers (Username,BannTime,Grund) VALUES ('"..target.."','"..endTime.."','"..reason.."')");
					if(isElement(targetPlayer))then
						kickPlayer(targetPlayer,player,reason);
					end
					infobox(player,loc(player,"AdminsystemMessage3"),125,0,0);
				else infobox(player,loc(player,"AdminsystemMessage2"),125,0,0)end
			else infobox(player,loc(player,"AdminsystemMessage1"),125,0,0)end
		end
	end
end)

addCommandHandler("aunban",function(player,cmd,target)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Adminlevel") >= 3)then
			if(target)then
				local result = dbPoll(dbQuery(handler,"SELECT * FROM bannedplayers WHERE Username = '"..target.."'"),-1);
				if(#result >= 1)then
					local targetPlayer = getPlayerFromName(target);
					infobox(player,loc(player,"AdminsystemMessage6"),125,0,0);
					dbExec(handler,"DELETE FROM bannedplayers WHERE Username = '"..target.."'");
				else infobox(player,loc(player,"AdminsystemMessage5"),125,0,0)end
			else infobox(player,loc(player,"AdminsystemMessage4"),125,0,0)end
		end
	end
end)

--// Einen Spieler kicken
addCommandHandler("akick",function(player,cmd,target,reason)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Adminlevel") >= 1)then
			if(target and reason)then
				local targetPlayer = getPlayerFromName(target);
				if(isElement(targetPlayer))then
					infobox(player,loc(player,"AdminsystemMessage9"):format(getPlayerName(targetPlayer)),0,125,0);
					kickPlayer(targetPlayer,player,reason);
				else infobox(player,loc(player,"AdminsystemMessage8"),125,0,0)end
			else infobox(player,loc(player,"AdminsystemMessage7"),125,0,0)end
		end
	end
end)

--// Checken, ob Spieler gebannt ist
addEventHandler("onPlayerJoin",root,function()
	local result = dbPoll(dbQuery(handler,"SELECT * FROM bannedplayers WHERE Username = '"..getPlayerName(source).."'"),-1);
	if(#result >= 1)then
		local BannTime = getPlayerData("bannedplayers","Username",getPlayerName(source),"BannTime");
		if(BannTime ~= 0)then
			if(getRealTime().timestamp >= BannTime)then
				dbExec(handler,"DELETE FROM bannedplayers WHERE Username = '"..getPlayerName(source).."'");
			else
				kickPlayer(source,loc(source,("AdminsystemMessage16"):format(TimestampToDate(getPlayerData("bannedplayers","Username",getPlayerName(source),"BannTime")),getPlayerData("bannedplayers","Username",getPlayerName(source),"Grund"))));
			end
		else
			kickPlayer(source,loc(source,("AdminsystemMessage16"):format(getPlayerData("bannedplayers","Username",getPlayerName(source),"Grund"))));
		end
	end
end)

--// Mypos
addCommandHandler("mypos",function(player)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Adminlevel") >= 1)then
		local x,y,z = getElementPosition(player);
		outputChatBox(x..","..y..","..z,player);
	end
end)

--// Adminchat intern und öffentlich
addCommandHandler("AChat",function(player,cmd,...)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Adminlevel") >= 1)then
		local msg = table.concat({...}," ");
		if(#msg >= 1)then
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1 and getElementData(v,"Adminlevel") >= 1)then
					outputChatBox("[A-Chat] "..getPlayerName(v)..": "..msg,v,200,200,0);
				end
			end
		end
	end
end)

addCommandHandler("OChat",function(player,cmd,...)
	if(getElementData(player,"loggedin") == 1 and getElementData(player,"Adminlevel") >= 1)then
		local msg = table.concat({...}," ");
		if(#msg >= 1)then
			outputChatBox("(( "..Adminsystem["Raenge"][getElementData(player,"Adminlevel")].." "..getPlayerName(player)..": "..msg.." ))",root,255,255,255);
		end
	end
end)

function Adminsystem.bindKey(player)
	if(getElementData(player,"Adminlevel") >= 1)then
		bindKey(player,"u","down","chatbox","AChat");
	end
	if(getElementData(player,"Adminlevel") >= 2)then
		bindKey(player,"o","down","chatbox","OChat");
	end
end

--// Admins einsehen
addCommandHandler("admins",function(player)
	if(getElementData(player,"loggedin") == 1)then
		local counter = 0;
		outputChatBox(loc(player,"AdminsystemMessage12"),player,0,125,0);
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1 and getElementData(v,"Adminlevel") >= 1)then
				counter = counter + 1;
				outputChatBox(getPlayerName(v).." - "..Adminsystem["Raenge"][getElementData(v,"Adminlevel")],player,255,255,255);
			end
		end
		if(counter == 0)then outputChatBox(loc(player,"AdminsystemMessage13"),player,125,0,0)end
	end
end)

--// Resetscore
addCommandHandler("resetscore",function(player)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Lobby") == "TacticsArena")then
			local Kills,Tode = getElementData(player,"KillsTacticArena"),getElementData(player,"TodeTacticArena");
			local Costs = Kills*50 + (Tode*75);
			if(hasBronzePremium(player))then Costs = Costs - (Costs/100*25) end
			if(hasSilberPremium(player))then Costs = Costs - (Costs/100*50) end
			if(hasGoldPremium(player))then Costs = Costs - (Costs/100*75) end
			Costs = math.floor(Costs);
			if(getElementData(player,"Geld") >= Costs)then
				setElementData(player,"Geld",getElementData(player,"Geld")-Costs);
				infobox(player,loc(player,"AdminsystemMessage15"),0,125,0);
				setElementData(player,"KillsTacticArena",0);
				setElementData(player,"TodeTacticArena",0);
			else infobox(player,loc(player,"AdminsystemMessage14"):format(Costs),125,0,0)end
		end
	end
end)