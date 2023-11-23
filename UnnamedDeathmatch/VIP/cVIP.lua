VIP = {open = false,
	["Farbcodes"] = {
		[1] = "#c2883b",
		[2] = "#f0f0f0",
		[3] = "#e8b923",
	},
};

--// Fenster öffnen
bindKey("f4","down",function()
	if(VIP.open == true)then
		setWindowDatas("reset");
		VIP.open = false;
	else
		if(getElementData(localPlayer,"loggedin") == 1 and isWindowOpen())then
			if(getElementData(localPlayer,"Lobby") == "Eingangshalle")then
				GUIEditor.window[1] = guiCreateWindow(494, 260, 710, 418, loc("VIPMessage2"), false)

				GUIEditor.button[1] = guiCreateButton(10, 29, 187, 39, loc("VIPMessage3"), false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(10, 78, 187, 39, loc("VIPMessage4"), false, GUIEditor.window[1])
				GUIEditor.button[3] = guiCreateButton(10, 127, 187, 39, loc("VIPMessage5"), false, GUIEditor.window[1])
				GUIEditor.button[4] = guiCreateButton(207, 29, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.button[5] = guiCreateButton(207, 78, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.button[6] = guiCreateButton(207, 127, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.memo[1] = guiCreateMemo(10, 176, 690, 232, "", false, GUIEditor.window[1])
				guiMemoSetReadOnly(GUIEditor.memo[1], true)
				GUIEditor.label[1] = guiCreateLabel(404, 29, 296, 137, loc("VIPMessage7"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
				setWindowDatas("set");
				VIP.open = true;
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					triggerServerEvent("VIP.buy",localPlayer,10,"Bronze");
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					triggerServerEvent("VIP.buy",localPlayer,15,"Silber");
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
					triggerServerEvent("VIP.buy",localPlayer,25,"Gold");
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[4],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage8")) end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[5],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage9")) end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[6],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage10")) end,false)
			else infobox(loc("VIPMessage18"),125,0,0)end
		end
	end
end)