Tactics = {nextMapOpen = false,
	["Maps"] = {
		["Namen"] = {"Drogenlabor SF","Drogenschiff","Lagerhalle SF","Skaterpark","Glen Park","Ghetto LS","Einkaufszentrum"},
	},
};
TacticsFont = dxCreateFont("Files/Fonts/TrueLies.ttf",20);

--// Spieler in ein Team tun
addEvent("Tactics.putPlayerInTeam",true)
addEventHandler("Tactics.putPlayerInTeam",root,function()
	triggerServerEvent("Tactics.putPlayerInTeam",localPlayer);
end)

--// Map verlassen Information
addEvent("Tactics.createRedBildschirm",true)
addEventHandler("Tactics.createRedBildschirm",root,function()
	Tactics.seconds = 10;
	addEventHandler("onClientRender",root,Tactics.renderRedBildschirm);
	Tactics.killTimer = setTimer(function()
		playSoundFrontEnd(38);
		Tactics.seconds = Tactics.seconds - 1;
		setElementHealth(localPlayer,getElementHealth(localPlayer)-5);
		if(Tactics.seconds == 0)then
			removeEventHandler("onClientRender",root,Tactics.renderRedBildschirm);
		end
	end,1000,10)
end)

addEvent("Tactics.destroyRedBildschirm",true)
addEventHandler("Tactics.destroyRedBildschirm",root,function()
	removeEventHandler("onClientRender",root,Tactics.renderRedBildschirm);
	if(isTimer(Tactics.killTimer))then killTimer(Tactics.killTimer)end
end)

function Tactics.renderRedBildschirm()
    dxDrawRectangle(0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 0, 0, 100), false)
    dxDrawText(loc("TacticArenaMessage1"):format(Tactics.seconds), 0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), ScoreboardFont2, "center", "center", false, false, false, true, false)
end

--// Countdown
addEvent("Tactics.createCountdown",true)
addEventHandler("Tactics.createCountdown",root,function(counter)
	Tactics.countdown = counter;
	addEventHandler("onClientRender",root,Tactics.dxCountdown);
end)

addEvent("Tactics.countdownRefresh",true)
addEventHandler("Tactics.countdownRefresh",root,function(counter)
	Tactics.countdown = counter;
end)

addEvent("Tactics.countdownDestroy",true)
addEventHandler("Tactics.countdownDestroy",root,function(nosound)
	removeEventHandler("onClientRender",root,Tactics.dxCountdown);
	if(isTimer(Tactics.killTimer))then killTimer(Tactics.killTimer)end
	if(not(nosound))then playSound("Files/Sounds/letsgo.wav")end
end)

function Tactics.dxCountdown()
	if(isWindowOpen())then
		dxDrawText(Tactics.countdown, 0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), TacticsFont, "center", "center", false, false, false, false, false)
	end
end

--// Gamespeed
addEvent("setGamespeed",true)
addEventHandler("setGamespeed",root,function(gamespeed)
	setGameSpeed(tonumber(gamespeed));
end)

--// Map wählen
addEvent("Tactics.nextMap",true)
addEventHandler("Tactics.nextMap",root,function()
	if(Tactics.nextMapOpen == true)then
		Tactics.nextMapOpen = false;
		setWindowDatas("reset");
	else
		if(isWindowOpen())then
			if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
				GUIEditor.window[1] = guiCreateWindow(706, 264, 386, 389, loc("TacticArenaMessage9"), false)

				GUIEditor.gridlist[1] = guiCreateGridList(10, 26, 366, 317, false, GUIEditor.window[1])
				map = guiGridListAddColumn(GUIEditor.gridlist[1], loc("TacticArenaMessage10"), 0.9)
				GUIEditor.button[1] = guiCreateButton(10, 353, 178, 26, loc("TacticArenaMessage11"), false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(198, 353, 178, 26, loc("TacticArenaMessage12"), false, GUIEditor.window[1])
				setWindowDatas("set");
				Tactics.nextMapOpen = true;
				
				for _,v in pairs(Tactics["Maps"]["Namen"])do
					local row = guiGridListAddRow(GUIEditor.gridlist[1]);
					guiGridListSetItemText(GUIEditor.gridlist[1],row,map,v,false,false);
				end
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1);
					if(clicked ~= "")then
						triggerServerEvent("Tactics.setNextMap",localPlayer,clicked);
					else infobox(loc("TacticArenaMessage8"),125,0,0)end
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					setWindowDatas("reset");
				end,false)
			end
		end		
    end
end)