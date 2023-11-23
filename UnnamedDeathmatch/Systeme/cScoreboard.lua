Scoreboard = {scoreboard = false, scroll = 0};
ScoreboardFont = dxCreateFont("Files/Fonts/Dash-Dermo.ttf",20);
ScoreboardFont2 = dxCreateFont("Files/Fonts/Honor.ttf",10);

--// Scoreboard öffnen und schließen
bindKey("tab","down",function()
	if(getElementData(localPlayer,"loggedin") == 1)then
		if(isWindowOpen())then
			Scoreboard.scoreboard = true;
			setWindowDatas();
			Scoreboard.update();
			addEventHandler("onClientRender",root,Scoreboard.dxDraw);
			Scoreboard.updateTimer = setTimer(Scoreboard.update,10000,0);
			bindKey("mouse_wheel_down","down",Scoreboard.scrollDown);
			bindKey("mouse_wheel_up","down",Scoreboard.scrollUp);
			toggleControl("next_weapon",false);
			toggleControl("previous_weapon",false);
			toggleControl("fire",false);
			showCursor(false);
		end
	end
end)

bindKey("tab","up",function()
	if(Scoreboard.scoreboard == true)then
		Scoreboard.scoreboard = false;
		setWindowDatas();
		removeEventHandler("onClientRender",root,Scoreboard.dxDraw);
		bindKey("mouse_wheel_down","down",Scoreboard.scrollDown);
		bindKey("mouse_wheel_up","down",Scoreboard.scrollUp);
		killTimer(Scoreboard.updateTimer);
		toggleControl("next_weapon",true);
		toggleControl("previous_weapon",true);
		toggleControl("fire",true);
	end
end)

--// Scrollen
function Scoreboard.scrollDown()
	if(Scoreboard.scoreboard == true)then
		local players = 0;
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1 and getElementData(v,"Lobby") == getElementData(localPlayer,"Lobby"))then
				players = players + 1;
			end
		end
		if(Scoreboard.scroll <= players-14)then
			Scoreboard.scroll = Scoreboard.scroll + 2;
		end
	end
end

function Scoreboard.scrollUp()
	if(Scoreboard.scoreboard == true)then
		if(Scoreboard.scroll <= 2)then
			Scoreboard.scroll = 0;
		else
			Scoreboard.scroll = Scoreboard.scroll - 2;
		end
	end
end

--// Daten updaten
function Scoreboard.update()
	pl = {};
	local i = 1;
	
	if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
		for id = 1,2 do
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"Lobby") == "TacticsArena" and getElementData(v,"TacticsTeam") == tonumber(id))then
					if(getElementData(v,"PremiumLevel") >= 1)then
						local level = getElementData(v,"PremiumLevel");
						local farbcode = VIP["Farbcodes"][level];
						nametag = "#ffffff["..farbcode.."VIP#ffffff]";
					else
						nametag = "";
					end
					local teamtag = "";
					if(getElementData(v,"Adminlevel") >= 1)then
						teamtag = "[BDM]";
					end
				
					local spielstunden = getElementData(v,"Spielstunden");
					local hour = math.floor(spielstunden/60);
					local minute = spielstunden-hour*60;
								
					pl[i] = {};
					if(getElementData(v,"TacticsTeam") == 1)then
						pl[i].name = nametag.."#643232"..teamtag..getPlayerName(v);
					elseif(getElementData(v,"TacticsTeam") == 2)then
						pl[i].name = nametag.."#960000"..teamtag..getPlayerName(v);
					end
					pl[i].ping = getPlayerPing(v);
					pl[i].playtime = Scoreboard.formString(hour)..":"..Scoreboard.formString(minute);
					pl[i].status = getElementData(v,"Status");
					if(id == 1)then pl[i].rgb = {100,50,50} else pl[i].rgb = {150,0,0} end
					pl[i].kills = getElementData(v,"KillsTacticArena");
					pl[i].tode = getElementData(v,"TodeTacticArena");
					i = i + 1;
				end
			end
		end
	else
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1)then
				if(getElementData(v,"Lobby") == "Eingangshalle" and getElementData(localPlayer,"Lobby") == "Eingangshalle" or getElementData(v,"Lobby") == getElementData(localPlayer,"Lobby") and getElementDimension(v) == getElementDimension(localPlayer) and getElementInterior(v) == getElementInterior(localPlayer))then
					if(getElementData(v,"PremiumLevel") >= 1)then
						local level = getElementData(v,"PremiumLevel");
						local farbcode = VIP["Farbcodes"][level];
						nametag = "#ffffff["..farbcode.."VIP#ffffff]";
					else
						nametag = "";
					end
					local teamtag = "";
					if(getElementData(v,"Adminlevel") >= 1)then
						teamtag = "[BDM]";
					end
					
					local spielstunden = getElementData(v,"Spielstunden");
					local hour = math.floor(spielstunden/60);
					local minute = spielstunden-hour*60;

					pl[i] = {};
					pl[i].name = nametag..teamtag..getPlayerName(v);
					pl[i].ping = getPlayerPing(v);
					pl[i].playtime = Scoreboard.formString(hour)..":"..Scoreboard.formString(minute);
					pl[i].status = getElementData(v,"Status");
					pl[i].rgb = {255,255,255};
					if(getElementData(localPlayer,"Lobby") == "DeagleArena")then
						pl[i].kills = getElementData(v,"KillsDeagleArena");
						pl[i].tode = getElementData(v,"TodeDeagleArena");
					elseif(getElementData(localPlayer,"Lobby") == "DeathmatchArena")then
						pl[i].kills = getElementData(v,"KillsDeathmatch");
						pl[i].tode = getElementData(v,"TodeDeathmatch");
					elseif(getElementData(localPlayer,"Lobby") == "TacticsArena")then
						pl[i].kills = getElementData(v,"KillsTacticArena");
						pl[i].tode = getElementData(v,"TodeTacticArena");
					elseif(getElementData(localPlayer,"Lobby") == "Eingangshalle")then
						pl[i].kills = getElementData(v,"KillsGesamt");
						pl[i].tode = getElementData(v,"TodeGesamt");
					end		
					i = i + 1;
				end
			end
		end
	end
end

--// Scoreboard
function Scoreboard.dxDraw()
    dxDrawRectangle(613*(x/1920), 342*(y/1080), 694*(x/1920), 397*(y/1080), tocolor(0, 0, 0, 150), false)
    dxDrawRectangle(613*(x/1920), 332*(y/1080), 694*(x/1920), 10*(y/1080), tocolor(58, 98, 242, 255), false)
    dxDrawText("Unnamed Deathmatch", 613*(x/1920), 297*(y/1080), 1307*(x/1920), 342, tocolor(255, 255, 255, 255), 1*(y/1080), ScoreboardFont, "center", "center", false, false, false, false, false)
    dxDrawText(loc("ScoreboardMessage1"), 613*(x/1920), 342*(y/1080), 766*(x/1920), 368, tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawText(loc("ScoreboardMessage2"), 766*(x/1920), 342*(y/1080), 872*(x/1920), 368, tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawLine(766*(x/1920), 342*(y/1080), 766*(x/1920), 739*(y/1080), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(872*(x/1920), 342*(y/1080), 872*(x/1920), 739*(y/1080), tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(952*(x/1920), 342*(y/1080), 952*(x/1920), 739*(y/1080), tocolor(255, 255, 255, 255), 1, false)
    dxDrawText(loc("ScoreboardMessage3"), 872*(x/1920), 342*(y/1080), 952*(x/1920), 368*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawText(loc("ScoreboardMessage4"), 952*(x/1920), 342*(y/1080), 1032*(x/1920), 368*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawLine(1032*(x/1920), 342*(y/1080), 1032*(x/1920), 739*(y/1080), tocolor(255, 255, 255, 255), 1, false)
    dxDrawText(loc("ScoreboardMessage5"), 1032*(x/1920), 342*(y/1080), 1249*(x/1920), 368*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawLine(1249*(x/1920), 342*(y/1080), 1249*(x/1920), 739*(y/1080), tocolor(255, 255, 255, 255), 1, false)
    dxDrawText(loc("ScoreboardMessage6"), 1249*(x/1920), 342*(y/1080), 1307*(x/1920), 368*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
    dxDrawLine(613*(x/1920), 368*(y/1080), 1307*(x/1920), 368*(y/1080), tocolor(255, 255, 255, 255), 1, false)

	local id = 0;
	for i = 1 + Scoreboard.scroll,13 + Scoreboard.scroll do
		if(pl[i])then
			dxDrawText(pl[i].name, 613*(x/1920), 368*(y/1080)+(26*id), 766*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, true, false)
			dxDrawText(pl[i].playtime, 766*(x/1920), 368*(y/1080)+(26*id), 872*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].kills, 872*(x/1920), 368*(y/1080)+(26*id), 952*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].tode, 952*(x/1920), 368*(y/1080)+(26*id), 1032*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].status, 1032*(x/1920), 368*(y/1080)+(26*id), 1249*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawText(pl[i].ping, 1249*(x/1920), 368*(y/1080)+(26*id), 1307*(x/1920), 394*(y/1080)+(26*id), tocolor(pl[i].rgb[1],pl[i].rgb[2],pl[i].rgb[3], 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, false, false)
			id = id + 1;
		end
	end
end

--// formString
function Scoreboard.formString(text)
	if(string.len(text) == 1)then
		text = "0"..text;
	end
	return text;
end