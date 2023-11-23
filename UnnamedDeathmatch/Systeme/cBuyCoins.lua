--// Fenster öffnen
bindKey("f3","down",function()
	if(getElementData(localPlayer,"loggedin") == 1 and isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(976, 192, 468, 336, "Unnamed-Coins", false)

        GUIEditor.label[1] = guiCreateLabel(10, 27, 448, 108, loc("UnnamedCoinsMessage1"), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
        GUIEditor.memo[1] = guiCreateMemo(10, 145, 448, 147, "", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(10, 302, 219, 24, loc("UnnamedCoinsMessage2"), false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(240, 302, 218, 24, loc("UnnamedCoinsMessage3"), false, GUIEditor.window[1])   
		setWindowDatas("set");
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local memo = guiGetText(GUIEditor.memo[1]);
			triggerServerEvent("BuyCoins.server",localPlayer,memo);
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			setWindowDatas("reset");
		end,false)
    end
end)

