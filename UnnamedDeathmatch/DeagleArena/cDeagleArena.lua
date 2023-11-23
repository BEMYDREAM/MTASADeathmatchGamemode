DeagleArena = {};
local savedDeagleArenaID = nil;
local savedDeagleArenaBesitzer = nil;

--// Fenster erstellen
addEvent("DeagleArena.createWindow",true)
addEventHandler("DeagleArena.createWindow",root,function()
	if(isWindowOpen())then
		GUIEditor.window[1] = guiCreateWindow(644, 351, 633, 378, "Deagle Lobbys", false)

		GUIEditor.button[1] = guiCreateButton(350, 333, 133, 35, loc("DeagleArenaMessage21"), false, GUIEditor.window[1])
		GUIEditor.button[2] = guiCreateButton(490, 333, 133, 35, loc("DeagleArenaMessage22"), false, GUIEditor.window[1])
		GUIEditor.gridlist[1] = guiCreateGridList(10, 30, 330, 338, false, GUIEditor.window[1])
		DeagleArena.id = guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.1)
		DeagleArena.besitzer = guiGridListAddColumn(GUIEditor.gridlist[1], "Besitzer", 0.3)
		DeagleArena.name = guiGridListAddColumn(GUIEditor.gridlist[1], "Name", 0.4)
		DeagleArena.spieler = guiGridListAddColumn(GUIEditor.gridlist[1], "Spieler", 0.3)
		DeagleArena.passwort = guiGridListAddColumn(GUIEditor.gridlist[1], "Passwort", 0.3)
		GUIEditor.label[1] = guiCreateLabel(350, 30, 273, 248, loc("DeagleArenaMessage20"), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
		GUIEditor.button[3] = guiCreateButton(350, 288, 133, 35, loc("DeagleArenaMessage23"), false, GUIEditor.window[1])
		GUIEditor.button[4] = guiCreateButton(490, 288, 133, 35, loc("DeagleArenaMessage24"), false, GUIEditor.window[1])
		setWindowDatas("set");
		
		triggerServerEvent("DeagleArena.loadLobbys",localPlayer);
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local id = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1);
			local besitzer = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),2);
			local passwort = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),5);
			if(id ~= "")then
				if(passwort == "✘")then
					triggerServerEvent("DeagleArena.joinLobby",localPlayer,id,besitzer);
				else
					if(besitzer == getPlayerName(localPlayer))then
						triggerServerEvent("DeagleArena.joinLobby",localPlayer,id,besitzer);
					else
						setWindowDatas("reset");
						savedDeagleArenaID = id;
						savedDeagleArenaBesitzer = besitzer;
						DeagleArena.createPasswordWindow();
					end
				end
			end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			setWindowDatas("reset");
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
			setWindowDatas("reset");
			DeagleArena.createLobbyWindow();
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
			triggerServerEvent("DeagleArena.loadLobbys",localPlayer);
		end,false)
	end
end)

--// Liste der Lobbys aktualisieren
function DeagleArena.refreshList(lobbys)
	guiGridListClear(GUIEditor.gridlist[1]);
	if(lobbys and #lobbys >= 1)then
		for _,v in pairs(lobbys)do
			local row = guiGridListAddRow(GUIEditor.gridlist[1]);
			guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.id,v["ID"],false,false);
			guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.besitzer,v["Besitzer"],false,false);
			guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.name,v["Name"],false,false);
			guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.spieler,v["SpielerInLobby"].."/"..v["Limit"],false,false);
			if(#v["Passwort"] >= 1)then
				guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.passwort,"✔",false,false);
			else
				guiGridListSetItemText(GUIEditor.gridlist[1],row,DeagleArena.passwort,"✘",false,false);
			end
			if(v["Besitzer"] == "SERVER")then
				guiGridListSetItemColor(GUIEditor.gridlist[1],row,DeagleArena.id,0,255,0);
				guiGridListSetItemColor(GUIEditor.gridlist[1],row,DeagleArena.besitzer,0,255,0);
				guiGridListSetItemColor(GUIEditor.gridlist[1],row,DeagleArena.name,0,255,0);
				guiGridListSetItemColor(GUIEditor.gridlist[1],row,DeagleArena.spieler,0,255,0);
				guiGridListSetItemColor(GUIEditor.gridlist[1],row,DeagleArena.passwort,0,255,0);
			end
		end
	end
end
addEvent("DeagleArena.refreshList",true)
addEventHandler("DeagleArena.refreshList",root,DeagleArena.refreshList)

--// Lobby erstellen Fenster
function DeagleArena.createLobbyWindow()
    GUIEditor.window[1] = guiCreateWindow(706, 390, 509, 300, loc("DeagleArenaMessage28"), false)

    GUIEditor.label[1] = guiCreateLabel(10, 26, 143, 28, loc("DeagleArenaMessage29"), false, GUIEditor.window[1])
    guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
    guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
    GUIEditor.label[2] = guiCreateLabel(10, 64, 143, 28, loc("DeagleArenaMessage30"), false, GUIEditor.window[1])
    guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
    guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
    GUIEditor.edit[1] = guiCreateEdit(163, 26, 336, 28, "", false, GUIEditor.window[1])
    GUIEditor.edit[2] = guiCreateEdit(164, 64, 335, 28, "", false, GUIEditor.window[1])
    GUIEditor.label[3] = guiCreateLabel(11, 102, 143, 28, loc("DeagleArenaMessage31"), false, GUIEditor.window[1])
    guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
    guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
    GUIEditor.edit[3] = guiCreateEdit(164, 102, 335, 28, "", false, GUIEditor.window[1])
    GUIEditor.label[4] = guiCreateLabel(10, 140, 143, 28, loc("DeagleArenaMessage32"), false, GUIEditor.window[1])
    guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
    guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
    GUIEditor.edit[4] = guiCreateEdit(163, 140, 335, 28, "", false, GUIEditor.window[1])
    GUIEditor.label[5] = guiCreateLabel(10, 178, 143, 28, loc("DeagleArenaMessage33"), false, GUIEditor.window[1])
    guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
    guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
    GUIEditor.radiobutton[1] = guiCreateRadioButton(164, 178, 95, 28, "  MAP 1", false, GUIEditor.window[1])
    GUIEditor.radiobutton[2] = guiCreateRadioButton(269, 178, 95, 28, "  MAP 2", false, GUIEditor.window[1])
    GUIEditor.radiobutton[3] = guiCreateRadioButton(374, 178, 95, 28, "  MAP 3", false, GUIEditor.window[1])
    guiRadioButtonSetSelected(GUIEditor.radiobutton[3], true)
    GUIEditor.button[1] = guiCreateButton(9, 261, 489, 29, loc("DeagleArenaMessage34"), false, GUIEditor.window[1])
    GUIEditor.button[2] = guiCreateButton(10, 222, 489, 29, loc("DeagleArenaMessage35"), false, GUIEditor.window[1])   
	setWindowDatas("set");
	
	addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
		setWindowDatas("reset");
	end,false)
	
	addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
		local spielerlimit = guiGetText(GUIEditor.edit[1]);
		local willkommensnachricht = guiGetText(GUIEditor.edit[2]);
		local passwort = guiGetText(GUIEditor.edit[3]);
		local name = guiGetText(GUIEditor.edit[4]);
		if(#spielerlimit >= 1 and #name >= 1)then
			if(guiRadioButtonGetSelected(GUIEditor.radiobutton[1]) == true)then map = 1 end
			if(guiRadioButtonGetSelected(GUIEditor.radiobutton[2]) == true)then map = 2 end
			if(guiRadioButtonGetSelected(GUIEditor.radiobutton[3]) == true)then map = 3 end
			triggerServerEvent("DeagleArena.createLobby",localPlayer,spielerlimit,willkommensnachricht,passwort,map,name);
		else infobox(loc("DeagleArenaMessage25"),125,0,0)end
	end,false)
end

--// Passwort-Eingabe
function DeagleArena.createPasswordWindow()
    GUIEditor.window[1] = guiCreateWindow(627, 314, 311, 116, loc("DeagleArenaMessage36"), false)

    GUIEditor.edit[1] = guiCreateEdit(10, 26, 291, 20, "", false, GUIEditor.window[1])
	guiEditSetMasked(GUIEditor.edit[1],true);
    GUIEditor.button[1] = guiCreateButton(10, 56, 291, 20, loc("DeagleArenaMessage37"), false, GUIEditor.window[1])
    GUIEditor.button[2] = guiCreateButton(10, 86, 291, 20, loc("DeagleArenaMessage38"), false, GUIEditor.window[1])   
	setWindowDatas("set");
	
	addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
		local passwort = guiGetText(GUIEditor.edit[1]);
		triggerServerEvent("DeagleArena.joinLobby",localPlayer,savedDeagleArenaID,savedDeagleArenaBesitzer,passwort);
	end,false)
	
	addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
		setWindowDatas("reset");
	end,false)
end

--// Lobby Einstellungen
function DeagleArena.openEinstellungen(besitzer)
	if(isWindowOpen())then
		if(besitzer == getPlayerName(localPlayer))then
			GUIEditor.window[1] = guiCreateWindow(565, 339, 473, 245, loc("DeagleArenaMessage39"), false)

			GUIEditor.edit[1] = guiCreateEdit(153, 62, 212, 26, "", false, GUIEditor.window[1])
			GUIEditor.button[1] = guiCreateButton(375, 62, 88, 26, loc("DeagleArenaMessage40"), false, GUIEditor.window[1])
			GUIEditor.label[1] = guiCreateLabel(10, 62, 133, 26, loc("DeagleArenaMessage41"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.label[2] = guiCreateLabel(10, 26, 133, 26, loc("DeagleArenaMessage42"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
			GUIEditor.edit[2] = guiCreateEdit(153, 26, 212, 26, "", false, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(375, 26, 88, 26, loc("DeagleArenaMessage43"), false, GUIEditor.window[1])
			GUIEditor.label[3] = guiCreateLabel(10, 98, 133, 26, loc("DeagleArenaMessage44"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
			GUIEditor.edit[3] = guiCreateEdit(153, 98, 212, 26, "", false, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(375, 98, 88, 26, loc("DeagleArenaMessage45"), false, GUIEditor.window[1])
			GUIEditor.label[4] = guiCreateLabel(10, 134, 133, 26, loc("DeagleArenaMessage46"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
			GUIEditor.edit[4] = guiCreateEdit(153, 134, 212, 26, "", false, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(375, 134, 88, 26, loc("DeagleArenaMessage47"), false, GUIEditor.window[1])
			GUIEditor.label[5] = guiCreateLabel(10, 170, 133, 26, loc("DeagleArenaMessage48"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
			GUIEditor.radiobutton[1] = guiCreateRadioButton(153, 170, 64, 26, "  MAP 1", false, GUIEditor.window[1])
			GUIEditor.radiobutton[2] = guiCreateRadioButton(227, 170, 64, 26, "  MAP 2", false, GUIEditor.window[1])
			GUIEditor.radiobutton[3] = guiCreateRadioButton(301, 170, 64, 26, "  MAP 3", false, GUIEditor.window[1])
			guiRadioButtonSetSelected(GUIEditor.radiobutton[3], true)
			GUIEditor.button[5] = guiCreateButton(375, 170, 88, 26, loc("DeagleArenaMessage49"), false, GUIEditor.window[1])
			GUIEditor.button[6] = guiCreateButton(10, 209, 217, 26, loc("DeagleArenaMessage50"), false, GUIEditor.window[1])
			GUIEditor.button[7] = guiCreateButton(246, 209, 217, 26, loc("DeagleArenaMessage51"), false, GUIEditor.window[1])
			setWindowDatas("set");
			
			addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
				local spielerlimit = guiGetText(GUIEditor.edit[2]);
				if(#spielerlimit >= 1)then
					triggerServerEvent("DeagleArena.settingsLimit",localPlayer,spielerlimit);
				else infobox(loc("DeagleArenaMessage52"),125,0,0)end
			end,false)
				
			addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
				local willkommensnachricht = guiGetText(GUIEditor.edit[1]);
				triggerServerEvent("DeagleArena.settingsWillkommensnachricht",localPlayer,willkommensnachricht);
			end,false)
				
			addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
				local passwort = guiGetText(GUIEditor.edit[3]);
				triggerServerEvent("DeagleArena.settingsPasswort",localPlayer,passwort);
			end,false)
				
			addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
				local name = guiGetText(GUIEditor.edit[4]);
				if(#name >= 1)then
					triggerServerEvent("DeagleArena.settingsName",localPlayer,name);
				else infobox(loc("DeagleArenaMessage53"),125,0,0)end
			end,false)
				
			addEventHandler("onClientGUIClick",GUIEditor.button[5],function()
				if(guiRadioButtonGetSelected(GUIEditor.radiobutton[1]) == true)then map = 1 end
				if(guiRadioButtonGetSelected(GUIEditor.radiobutton[2]) == true)then map = 2 end
				if(guiRadioButtonGetSelected(GUIEditor.radiobutton[3]) == true)then map = 3 end
				triggerServerEvent("DeagleArena.settingsMap",localPlayer,map);
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[6],function()
				setWindowDatas("reset");
			end,false)
			
			addEventHandler("onClientGUIClick",GUIEditor.button[7],function()
				triggerServerEvent("DeagleArena.deleteLobby",localPlayer);
			end,false)
		end
	end
end
addEvent("DeagleArena.openEinstellungen",true)
addEventHandler("DeagleArena.openEinstellungen",root,DeagleArena.openEinstellungen)