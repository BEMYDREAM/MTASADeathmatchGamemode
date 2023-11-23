Lootbox = {skinID = 0, text = "", skinType = nil, skinTypeNr = 0,
	["Skins"] = {
		[1] = {1,2,9,10,11,12,14,15,16,17,20,23,24,25,26,28,31,34,35,36,37,38,39,40,41,43,51,52,53,54,55,56,58,60,63,64,69,72,73,75,76,77,78,79,85,87,88,89,94,95,96,99,128,129,130,131,132,133,134,135,136,151,158,159,160,161,168,182,183,184,196,197,198,199,200,201,202,205,207,212,213,218,219,220,221,222,230,231,232,238,243,244,245,246,256,257,258,259,261,262}, -- Gewöhnlich
		[2] = {309,308,305,302,298,295,277,278,279,268,7,19,21,22,29,32,45,46,47,48,57,59,61,62,66,68,70,71,90,91,93,97,98,121,138,139,140,142,143,144,145,147,148,153,154,156,170,171,172,180,188,189,190,191,192,193,194,206,209,210,211,214,215,216,217,226,227,228,229,233,234,235,236,240,241,242,250,251,252,253,255}, -- Ungewöhnlich
		[3] = {312,306,303,290,280,281,282,274,275,276,13,18,30,50,67,80,81,82,83,84,100,101,103,105,112,117,118,125,126,146,150,152,163,164,176,177,179,223,224,225,247,249,254,263,265,266,267}, -- Selten
		[4] = {310,307,304,27,33,44,107,110,111,114,127,165,166,169,174,178,185,186,203,204,248,260,272,284,286,297}, -- Episch
		[5] = {269,104,106,109,115,120,123,124,173,264,284,288,287,291,301,296}, -- Legendär
		[6] = {311,49,92,102,108,113,116,122,137,141,155,162,167,175,181,187,195,237,239,270,271,285,292,293,294,299}, -- Mythisch
	},
};

--// Skin generieren
function Lootbox.generateSkin()
	local rnd = math.random(1,100);
	if(rnd >= 1 and rnd <= 50)then -- Gewöhnlich
		Lootbox.skinID = Lootbox["Skins"][1][math.random(1,#Lootbox["Skins"][1])];
		Lootbox.skinType = loc("LootboxMessage2");
		Lootbox.skinTypeNr = 1;
	elseif(rnd >= 51 and rnd <= 70)then -- Ungewöhnlich
		Lootbox.skinID = Lootbox["Skins"][2][math.random(1,#Lootbox["Skins"][2])];
		Lootbox.skinType = loc("LootboxMessage3");
		Lootbox.skinTypeNr = 2;
	elseif(rnd >= 71 and rnd <= 85)then -- Selten
		Lootbox.skinID = Lootbox["Skins"][3][math.random(1,#Lootbox["Skins"][3])];
		Lootbox.skinType = loc("LootboxMessage4");
		Lootbox.skinTypeNr = 3;
	elseif(rnd >= 86 and rnd <= 95)then -- Episch
		Lootbox.skinID = Lootbox["Skins"][4][math.random(1,#Lootbox["Skins"][4])];
		Lootbox.skinType = loc("LootboxMessage5");
		Lootbox.skinTypeNr = 4;
	elseif(rnd >= 96 and rnd <= 99)then -- Legendär
		Lootbox.skinID = Lootbox["Skins"][5][math.random(1,#Lootbox["Skins"][5])];
		Lootbox.skinType = loc("LootboxMessage6");
		Lootbox.skinTypeNr = 5;
	elseif(rnd == 100)then -- Mythisch
		Lootbox.skinID = Lootbox["Skins"][6][math.random(1,#Lootbox["Skins"][6])];
		Lootbox.skinType = loc("LootboxMessage7");
		Lootbox.skinTypeNr = 6;
	end
end

--// Lootbox öffnen/schließen
function Lootbox.open()
	if(getElementData(localPlayer,"Lootbox") >= 1)then
		setWindowDatas("reset");
		Lootbox.counter = 0;
		Lootbox.text = "";
		setElementData(localPlayer,"SkinZiehung",true);
		addEventHandler("onClientRender",root,Lootbox.renderSkinZiehung);
		Lootbox.skinIDTimer = setTimer(function()
			Lootbox.generateSkin();
			Lootbox.counter = Lootbox.counter + 1;
			if(Lootbox.counter >= 50)then
				killTimer(Lootbox.skinIDTimer);
				Lootbox.text = Lootbox.skinType;
				bindKey("space","down",Lootbox.close);
				triggerServerEvent("Lootbox.givePlayerSkin",localPlayer,Lootbox.skinID);
				setElementData(localPlayer,"SkinZiehung",false);
				if(Lootbox.skinTypeNr == 1)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,2)end
				if(Lootbox.skinTypeNr == 2)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,3)end
				if(Lootbox.skinTypeNr == 3)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,4)end
				if(Lootbox.skinTypeNr == 4)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,5)end
				if(Lootbox.skinTypeNr == 5)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,6)end
				if(Lootbox.skinTypeNr == 6)then triggerServerEvent("setPlayerAchievement",localPlayer,localPlayer,7)end
			end
		end,50,0)
	else infobox(loc("LootboxMessage1"),125,0,0)end
end
addEvent("Lootbox.open",true)
addEventHandler("Lootbox.open",root,Lootbox.open)

function Lootbox.close()
	removeEventHandler("onClientRender",root,Lootbox.renderSkinZiehung);
	unbindKey("space","down",Lootbox.renderSkinZiehung);
end

function Lootbox.renderSkinZiehung()
	dxDrawImage(874*(x/1920), 407*(y/1080), 172*(x/1920), 267*(y/1080), "Files/Images/Skins/Skinid"..Lootbox.skinID..".jpg", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawText(Lootbox.text, 751*(x/1920), 684*(y/1080), 1170*(x/1920), 734*(y/1080), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
end

--// Fenster öffnen
addEvent("Lootbox.openWindow",true)
addEventHandler("Lootbox.openWindow",root,function()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(619, 263, 637, 356, loc("LootboxMessage9"), false)

        GUIEditor.label[1] = guiCreateLabel(10, 24, 190, 32, loc("LootboxMessage10"), false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.gridlist[1] = guiCreateGridList(10, 66, 190, 280, false, GUIEditor.window[1])
        skin = guiGridListAddColumn(GUIEditor.gridlist[1], "Skin", 0.9)
        GUIEditor.label[2] = guiCreateLabel(210, 24, 417, 164, loc("LootboxMessage11"), false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "left", true)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
        GUIEditor.button[1] = guiCreateButton(210, 198, 242, 35, loc("LootboxMessage12"), false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(463, 198, 164, 35, loc("LootboxMessage13"), false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(464, 311, 163, 35, loc("LootboxMessage14"), false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(464, 243, 163, 33, loc("LootboxMessage15"):format(getElementData(localPlayer,"Lootbox")), false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
        GUIEditor.staticimage[1] = guiCreateStaticImage(210, 243, 79, 103, "Files/Images/Skins/Skinid0.jpg", false, GUIEditor.window[1])
        GUIEditor.button[4] = guiCreateButton(299, 311, 155, 35, loc("LootboxMessage16"), false, GUIEditor.window[1])
		setWindowDatas("set");
		triggerServerEvent("Lootbox.loadStuff",localPlayer);
		
		addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
			local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1);
			if(clicked ~= "")then
				guiStaticImageLoadImage(GUIEditor.staticimage[1],"Files/Images/Skins/Skinid"..clicked..".jpg");
			end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			triggerServerEvent("Lootbox.buy",localPlayer);
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			triggerServerEvent("Lootbox.open",localPlayer);
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
			setWindowDatas("reset");
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[4],function()
			local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1);
			if(clicked ~= "")then
				triggerServerEvent("Lootbox.useSkin",localPlayer,clicked);
			else infobox(loc("LootboxMessage21"),125,0,0)end
		end,false)
	end
end)

--// Skins aktualisieren
addEvent("Lootbox.refreshSkins",true)
addEventHandler("Lootbox.refreshSkins",root,function(skins)
	guiSetText(GUIEditor.label[3],loc("LootboxMessage15"):format(getElementData(localPlayer,"Lootbox")));
	if(skins)then
		guiGridListClear(GUIEditor.gridlist[1]);
		if(#skins >= 1)then
			for _,v in pairs(skins)do
				local row = guiGridListAddRow(GUIEditor.gridlist[1]);
				guiGridListSetItemText(GUIEditor.gridlist[1],row,skin,v[1],false,false);
			end
		end
	end
end)