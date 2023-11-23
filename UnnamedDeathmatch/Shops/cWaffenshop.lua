Waffenshop = {open = false};

--// Fenster öffnen
bindKey("f7","down",function()
	if(Waffenshop.open == true)then
		Waffenshop.open = false;
		setWindowDatas("reset");
	else
		if(isWindowOpen())then
			if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
				GUIEditor.window[1] = guiCreateWindow(761, 264, 574, 410, loc("WaffenshopMessage7"), false)

				GUIEditor.staticimage[1] = guiCreateStaticImage(10, 28, 103, 101, "Files/Images/HUD/Waffen/18.png", false, GUIEditor.window[1])
				GUIEditor.label[1] = guiCreateLabel(10, 139, 103, 35, loc("WaffenshopMessage8"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
				GUIEditor.staticimage[2] = guiCreateStaticImage(123, 28, 103, 101, "Files/Images/HUD/Waffen/16.png", false, GUIEditor.window[1])
				GUIEditor.label[2] = guiCreateLabel(123, 139, 103, 35, loc("WaffenshopMessage9"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
				GUIEditor.button[1] = guiCreateButton(10, 184, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(123, 184, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.label[3] = guiCreateLabel(236, 139, 103, 35, loc("WaffenshopMessage10"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
				GUIEditor.button[3] = guiCreateButton(236, 184, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.staticimage[3] = guiCreateStaticImage(236, 28, 103, 101, "Files/Images/HUD/Waffen/32.png", false, GUIEditor.window[1])
				GUIEditor.staticimage[4] = guiCreateStaticImage(349, 28, 103, 101, "Files/Images/HUD/Waffen/35.png", false, GUIEditor.window[1])
				GUIEditor.label[4] = guiCreateLabel(349, 139, 103, 35, loc("WaffenshopMessage11"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
				GUIEditor.button[4] = guiCreateButton(349, 184, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.label[5] = guiCreateLabel(462, 139, 103, 35, loc("WaffenshopMessage12"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
				GUIEditor.staticimage[5] = guiCreateStaticImage(462, 28, 103, 101, "Files/Images/HUD/Waffen/39.png", false, GUIEditor.window[1])
				GUIEditor.button[5] = guiCreateButton(461, 184, 103, 22, "Kaufen", false, GUIEditor.window[1])
				GUIEditor.label[6] = guiCreateLabel(10, 333, 103, 35, loc("WaffenshopMessage13"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
				GUIEditor.button[6] = guiCreateButton(10, 378, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.staticimage[6] = guiCreateStaticImage(10, 222, 103, 101, "Files/Images/HUD/Waffen/34.png", false, GUIEditor.window[1])
				GUIEditor.button[7] = guiCreateButton(123, 378, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.label[7] = guiCreateLabel(123, 333, 103, 35, loc("WaffenshopMessage14"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[7], "center")
				GUIEditor.staticimage[7] = guiCreateStaticImage(123, 222, 103, 101, "Files/Images/HUD/Waffen/27.png", false, GUIEditor.window[1])
				GUIEditor.staticimage[8] = guiCreateStaticImage(236, 222, 103, 101, "Files/Images/HUD/Waffen/38.png", false, GUIEditor.window[1])
				GUIEditor.label[8] = guiCreateLabel(236, 333, 103, 35, loc("WaffenshopMessage15"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[8], "center")
				GUIEditor.button[8] = guiCreateButton(236, 378, 103, 22, loc("WaffenshopMessage16"), false, GUIEditor.window[1])
				GUIEditor.button[9] = guiCreateButton(461, 378, 103, 22, loc("WaffenshopMessage17"), false, GUIEditor.window[1])
				GUIEditor.label[9] = guiCreateLabel(349, 222, 215, 146, loc("WaffenshopMessage18"), false, GUIEditor.window[1])
				guiSetFont(GUIEditor.label[9], "default-bold-small")
				guiLabelSetHorizontalAlign(GUIEditor.label[9], "left", true)
				setWindowDatas("set");
				Waffenshop.open = true;
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,1);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,2);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,3);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,4);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[5],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,5);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[6],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,6);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[7],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,7);
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[8],function()
					triggerServerEvent("Waffenshop.buyWeapon",localPlayer,8);
				end,false)

				addEventHandler("onClientGUIClick",GUIEditor.button[9],function()
					setWindowDatas("reset");
				end,false)
			end
		end
	end
end)