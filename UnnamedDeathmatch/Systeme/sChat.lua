--// Ist der Spieler gemutet?
function isMuted(player)
	local result = dbPoll(dbQuery(handler,"SELECT * FROM mutedplayers WHERE Username = '"..getPlayerName(player).."'"),-1);
	if(#result >= 1)then
		local MuteTime = tonumber(getPlayerData("mutedplayers","Username",getPlayerName(player),"MuteTime"));
		if(MuteTime == 0)then
			infobox(player,loc(player,"ChatMessage1"):format(getPlayerData("mutedplayers","Username",getPlayerName(player),"Grund")),125,0,0);
			return false
		elseif(MuteTime > 0)then
			local time = getRealTime();
			if(time.timestamp >= MuteTime)then
				dbExec(handler,"DELETE FROM mutedplayers WHERE Username = '"..getPlayerName(player).."'");
				return true
			else infobox(player,loc(player,"ChatMessage2"):format(TimestampToDate(getPlayerData("mutedplayers","Username",getPlayerName(player),"MuteTime")),getPlayerData("mutedplayers","Username",getPlayerName(player),"Grund")),125,0,0)end
		end
	else
		return true
	end
end

--// Einen Spieler muten und entmuten
addCommandHandler("aendmute",function(player,cmd,target)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Adminlevel") >= 2)then
			if(target)then
				local result = dbPoll(dbQuery(handler,"SELECT * FROM mutedplayers WHERE Username = '"..target.."'"),-1);
				if(#result >= 1)then
					local targetPlayer = getPlayerFromName(target);
					if(isElement(targetPlayer) and getElementData(targetPlayer,"loggedin") == 1)then
						infobox(targetPlayer,loc(targetPlayer,"ChatMessage4"):format(getPlayerName(player)),0,125,0);
					else
						offlinemessage(target,loc(_,"ChatMessage4",getPlayerData("userdata","Username",target,"Sprache")):format(getPlayerName(player)));
					end
					infobox(player,loc(targetPlayer,"ChatMessage5"):format(target),0,125,0);
					dbExec(handler,"DELETE FROM mutedplayers WHERE Username = '"..target.."'");
					
					for _,v in pairs(getElementsByType("player"))do
						if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "Eingangshalle" and getElementData(player,"Lobby") == "Eingangshalle" or getElementData(v,"Lobby") == getElementData(player,"Lobby") and getElementDimension(v) == getElementDimension(player) and getElementInterior(v) == getElementInterior(player))then
							outputChatBox(loc(v,"AdminsystemMessage11"):format(target,getPlayerName(player)),v,0,125,0);
						end
					end
				else infobox(player,loc(player,"ChatMessage7"),125,0,0)end
			else infobox(player,loc(player,"ChatMessage3"),125,0,0)end
		end
	end
end)

addCommandHandler("amute",function(player,cmd,target,time,reason)
	if(getElementData(player,"loggedin") == 1)then
		if(getElementData(player,"Adminlevel") >= 1)then
			if(target and time and reason)then
				local result = dbPoll(dbQuery(handler,"SELECT * FROM mutedplayers WHERE Username = '"..target.."'"),-1);
				if(#result == 0)then
					local newTime = time * 60;
					local targetPlayer = getPlayerFromName(target);
					if(tonumber(time) == 0)then endTime = 0 else endTime = getRealTime().timestamp + newTime end
					dbExec(handler,"INSERT INTO mutedplayers (Username,MuteTime,Grund) VALUES ('"..target.."','"..endTime.."','"..reason.."')");
					if(isElement(targetPlayer))then
						infobox(targetPlayer,loc(targetPlayer,"ChatMessage9"):format(getPlayerName(player),time,reason),125,0,0);
					else
						offlinemessage(target,loc(_,"ChatMessage9",getPlayerData("userdata","Username",target,"Sprache")):format(getPlayerName(player),timte,reason));
					end
					infobox(player,loc(player,"ChatMessage10"):format(target),0,125,0);
					
					for _,v in pairs(getElementsByType("player"))do
						if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == "Eingangshalle" and getElementData(player,"Lobby") == "Eingangshalle" or getElementData(v,"Lobby") == getElementData(player,"Lobby") and getElementDimension(v) == getElementDimension(player) and getElementInterior(v) == getElementInterior(player))then
							outputChatBox(loc(v,"AdminsystemMessage10"):format(target,getPlayerName(player),time,reason),v,125,0,0);
						end
					end
				else infobox(player,loc(player,"ChatMessage8"),125,0,0)end
			else infobox(player,loc(player,"ChatMessage6"),125,0,0)end
		end
	end
end)

--// Chatten
addEventHandler("onPlayerChat",root,function(message,messageType)
	if(isMuted(source))then
		if(messageType == 0)then
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"loggedin") == 1)then
					if(getElementData(v,"Lobby") == getElementData(source,"Lobby"))then
						if(isPremium(source))then
							local level = getElementData(source,"PremiumLevel");
							local farbcode = VIP["Farbcodes"][level];
							nametag = "#ffffff["..farbcode.."VIP#ffffff]";
						else
							nametag = "";
						end
						local teamtag = "";
						if(getElementData(source,"Adminlevel") >= 1)then
							teamtag = "[UDM]";
						end
						local color = "ffffff";
						if(getElementData(source,"Lobby") == "TacticsArena")then
							if(getElementData(source,"TacticsTeam") == 1)then
								color = "#643232";
							elseif(getElementData(source,"TacticsTeam") == 2)then
								color = "#960000";
							end
						end
						outputChatBox(nametag..color..teamtag..getPlayerName(source).."#ffffff: "..message,v,255,255,255,true);
						if(isTimer(Minigames.endTimer))then
							if(Minigames.activeMinigame == "Quersumme")then
								if(tonumber(message) and tonumber(message) == Minigames.quersummeLoesung)then
									Minigames.quersummeFinished(source);
								end
							end
						end
					end
				end
			end
		end
	end
	cancelEvent();
end)