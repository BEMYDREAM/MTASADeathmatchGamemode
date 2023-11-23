RegisterLogin = {text = nil};
setElementData(localPlayer,"Sprache","EN");
fadeCamera(true);
setElementDimension(localPlayer,0);
setElementInterior(localPlayer,0);
clearChatBox();
setElementData(localPlayer,"loggedin",0);

--// Register/Login erstellen
function RegisterLogin.dxDraw()
	dxDrawRectangle(0*(x/1920), 0*(y/1080), 1920*(x/1920), 89*(y/1080), tocolor(1, 0, 0, 255), false)
    dxDrawRectangle(0*(x/1920), 991*(y/1080), 1920*(x/1920), 89*(y/1080), tocolor(1, 0, 0, 255), false)
	if(Infobox.active == false)then
    dxDrawText(Serverinfos.name.." "..Serverinfos.version, 10*(x/1920), 10*(y/1080), 1910*(x/1920), 79*(y/1080), tocolor(255, 255, 255, 255), 1.50*(y/1080), "default", "center", "center", false, false, false, false, false)
	end
    dxDrawRectangle(705*(x/1920), 409*(y/1080), 511*(x/1920), 263*(y/1080), tocolor(0, 0, 0, 200), false)
    dxDrawRectangle(705*(x/1920), 409*(y/1080), 511*(x/1920), 40*(y/1080), tocolor(58, 98, 242, 200), false)
    dxDrawText(RegisterLogin.secondText, 715*(x/1920), 459*(y/1080), 1206*(x/1920), 503*(y/1080), tocolor(255, 255, 255, 255), 1.00, "arial", "center", "center", false, true, false, false, false)
	dxDrawText(loc("RegisterLoginMessage10"), 705*(x/1920), 409*(y/1080), 1216*(x/1920), 449*(y/1080), tocolor(255, 255, 255, 255), 1.20*(y/1080), "default-bold", "center", "center", false, true, false, false, false)
    dxDrawText(loc("RegisterLoginMessage11"), 715*(x/1920), 513*(y/1080), 781*(x/1920), 541*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), "arial", "left", "center", false, true, false, false, false)
    dxDrawText(loc("RegisterLoginMessage12"), 715*(x/1920), 551*(y/1080), 781*(x/1920), 579*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), "arial", "left", "center", false, true, false, false, false)
end

addEvent("RegisterLogin.createWindow",true)
addEventHandler("RegisterLogin.createWindow",root,function(type)
	showChat(false);
	setCameraMatrix(338.16870117188,-1995.6628417969,22.10756111145,401.01724243164,-2071.3950195313,4.3680448532104);
	RegisterLogin.text = type;
	setElementData(localPlayer,"elementClicked",true);
	if(type == "Registrieren")then
		RegisterLogin.secondText = loc("RegisterLoginMessage9");
		if(getElementData(localPlayer,"Sprache") == "EN")then
			RegisterLogin.text = "Register"
		end
	elseif(type == "Einloggen")then
		RegisterLogin.secondText = loc("RegisterLoginMessage8");
		if(getElementData(localPlayer,"Sprache") == "EN")then
			RegisterLogin.text = "Login";
		end
	end
	setWindowDatas("set");
	addEventHandler("onClientRender",root,RegisterLogin.dxDraw);
	Elements.edit[1] = Edit:create(791, 513, 415, 28,1920,1080,getPlayerName(localPlayer));
	Elements.edit[1].editActiv = false;
	Elements.edit[2] = Edit:create(791, 551, 415, 28,1920,1080,"",true);
	Elements.button[1] = Button:create(715, 634, 491, 28,1920,1080,RegisterLogin.text,"RegisterLogin.triggerToServer");
	setPlayerHudComponentVisible("radar",false);
	setPlayerHudComponentVisible("area_name",false);
end)

addEvent("RegisterLogin.triggerToServer",true)
addEventHandler("RegisterLogin.triggerToServer",root,function()
	local passwort = Elements.edit[2]:getText();
	if(#passwort >= 6)then
		triggerServerEvent("RegisterLogin.server",localPlayer,RegisterLogin.text,passwort);
	else infobox(loc("RegisterLoginMessage13"),125,0,0)end
end)

--// Register/Login zerstören
addEvent("RegisterLogin.destroy",true)
addEventHandler("RegisterLogin.destroy",root,function()
	if(Elements.edit[1])then
		Elements.edit[1]:destroy();
		Elements.edit[2]:destroy();
		Elements.button[1]:destroy();
		removeEventHandler("onClientRender",root,RegisterLogin.dxDraw);
	end
	setWindowDatas("reset");
	showChat(true);
	setPlayerHudComponentVisible("radar",true);
end)

triggerServerEvent("RegisterLogin.checkAccount",localPlayer);