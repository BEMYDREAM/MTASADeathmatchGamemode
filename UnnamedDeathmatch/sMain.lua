setFPSLimit(65);
setGameType("Unnamed Deathmatch v.0.9.9");
setWeather(0);

function infobox(player,text,r,g,b)
	if(player and text and r and g and b)then
		triggerClientEvent(player,"infobox",player,text,r,g,b);
	end
end

function TimestampToDate(timestamp)
	local time = getRealTime(timestamp);
	local monthday, month, year = time.monthday, time.month + 1, time.year + 1900;
	local hour, minute = time.hour, time.minute;
	if(monthday < 10)then monthday = "0"..monthday end
	if(month < 10)then month = "0"..month end
	if(hour < 10)then hour = "0"..hour end
	if(minute < 10)then minute = "0"..minute end
	
	return monthday.."."..month.."."..year.." - "..hour..":"..minute.." Uhr";
end

--// Nickchange blockieren
addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent();
end)

--// Time
local realtime = getRealTime();
setTime(realtime.hour,realtime.minute);
setMinuteDuration(60000);