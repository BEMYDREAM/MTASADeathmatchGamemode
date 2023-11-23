Hilfemenue = { state = false,
	["Kategorien"] = {
		["DE"] = {"Adminbefehle","Minispiele","Befehle und Tastenkombinationen","VIP"},
		["EN"] = {"Admin commands","Minigames","Commands and keyboard combinations","VIP"},
	},
	["Texte"] = {
		["DE"] = {
			["Adminbefehle"] = "Ab Adminlevel 1 (Probe-Supporter):\n- /amute [Spieler], [Zeit in Min.], [Grund] - Einen Spieler muten\n- /akick [Spieler] - Einen Spieler kicken, [Grund]\n- /AChat [Text] - Interner Adminchat (Alternativ auch über 'U' nutzbar)\n- /OChat [Text] - Öffentlicher Adminchat (Alternativ auch über 'O' nutzbar)\n\nAb Adminlevel 2 (Supporter):\n- /endmute [Spieler] - Einen Spieler entmuten\n- /aban [Spieler], [Zeit in Std.], [Grund] - Einen Spieler bannen\n\nAb Adminlevel 3 (Moderator):\n- /aunban [Spieler] - Einen Spieler entbannen",
			["Minispiele"] = "Every 30 minutes, a mini-game is randomly selected in which a small arithmetic problem has to be solved.\nThe first person to write the correct answer in the chat wins a sum of money. The following mini-games are currently available:\n- Calculate the cross sum",
			["Befehle und Tastenkombinationen"] = "- F1 - Hilfemenü öffnen/schließen\n- /status [Text] - Seinen Status ändern\n- /language - Sprache ändern\n- b - Cursor anzeigen/ausblenden\n- F2 - Lobby-Einstellungen\n- F3 - Unnamed-Coins kaufen\n- F4 - VIP-Status-Shop öffnen/schließen\n- /reddot - Rotpunktvisier aktivieren/deaktivieren\n- /leave - Derzeitige Lobby verlassen\n- /resetscore - Kills und Tode in der Tactics-Lobby zurücksetzen\n- F5 - Achievements anzeigen/ausblenden\n- 'M' - Mapauswahl in der Tactics-Lobby öffnen/schließen (Ab Premium Silber möglich)",
			["VIP"] = "Es gibt drei verschiedene VIP-Status; Bronze, Silber und Gold. Einen VIP-Status kann man sich mit Unnamed-Coins über F4 kaufen, wo man ebenfalls sieht, welche Vorteile der jeweilige VIP-Status bringt. Unnamed-Coins kann man über F3 erwerben.",
		},
		["EN"] = {
			["Admin commands"] = "From admin level 1 (trial supporter):\n- /amute [player], [time in minutes], [reason] - mute a player\n- /akick [player] - kick a player, [reason]\n - /AChat [Text] - Internal admin chat (can also be used via 'U')\n- /OChat [Text] - Public admin chat (can also be used via 'O')\n\nFrom admin level 2 (supporter):\n - /endmute [player] - Discourage a player\n- /aban [player], [time in hours], [reason] - Ban a player\n\nFrom admin level 3 (moderator):\n- /aunban [player ] - Unban a player",
			["Minigames"] = "Every 30 minutes, a mini-game is randomly selected in which a small arithmetic problem has to be solved.\nThe first person to write the correct answer in the chat wins a sum of money. The following mini-games are currently available:\n- Calculate the cross sum",
			["Commands and keyboard combinations"] = "- F1 - Open/close help menu\n- /status [Text] - Change your status\n- /language - Change language\n- b - Show/hide cursor\n- F2 - Lobby settings\n- F3 - Buy unnamed coins\n- F4 - Open/close VIP status shop\n- /reddot - Activate/deactivate red dot sight\n- /leave - Leave current lobby\n- /resetscore - Reset kills and deaths in the Tactics lobby\n- F5 - Show achievements/ hide\n- 'M' - Open/close map selection in the tactics lobby (possible from Premium Silver)",
			["VIP"] = "There are three different VIP statuses; Bronze, silver and gold. You can buy VIP status with unnamed coins via F4, where you can also see what advantages each VIP status brings. Unnamed coins can be purchased via F3.",
		},
	},
};

--// Fenster öffnen
bindKey("f1","down",function()
	if(Hilfemenue.state == true)then
		Hilfemenue.state = false;
		setWindowDatas("reset");
	else
		if(isWindowOpen())then
			GUIEditor.window[1] = guiCreateWindow(681, 271, 652, 470, loc("HilfemenueMessage1"), false)
			Hilfemenue.state = true;

			GUIEditor.gridlist[1] = guiCreateGridList(10, 28, 246, 432, false, GUIEditor.window[1])
			kategorie = guiGridListAddColumn(GUIEditor.gridlist[1], loc("HilfemenueMessage2"), 0.9)
			GUIEditor.label[1] = guiCreateLabel(266, 28, 376, 432, loc("HilfemenueMessage3"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
			setWindowDatas("set");
			
			local Language = getElementData(localPlayer,"Sprache");
			for _,v in pairs(Hilfemenue["Kategorien"][Language])do
				local row = guiGridListAddRow(GUIEditor.gridlist[1]);
				guiGridListSetItemText(GUIEditor.gridlist[1],row,kategorie,v,false,false);
			end
			
			addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
				local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1);
				if(clicked ~= "")then
					guiSetText(GUIEditor.label[1],Hilfemenue["Texte"][Language][clicked]);
				end
			end,false)
		end
	end
end)