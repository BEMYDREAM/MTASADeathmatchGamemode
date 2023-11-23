Infobox = {active = false};

function infobox(text,r,g,b)
	if(r == 120 and g == 0 and b == 0)then playSoundFrontEnd(13) else playSoundFrontEnd(11)end
	infoboxText = text;
	infoboxR,infoboxG,infoboxB = r,g,b;
	Infobox.active = true;
	if(isTimer(infoboxTimer))then
		killTimer(infoboxTimer);
	else
		addEventHandler("onClientRender",root,dxDrawInfobox);
	end
	infoboxTimer = setTimer(function()
		Infobox.active = false;
		removeEventHandler("onClientRender",root,dxDrawInfobox);
	end,5000,1)
end
addEvent("infobox",true)
addEventHandler("infobox",root,infobox)

function dxDrawInfobox()
    dxDrawRectangle(613*(x/1440), -7*(y/900), 210*(x/1440), 83*(y/900), tocolor(0, 0, 0, 150), false)
    dxDrawRectangle(617*(x/1440), -5*(y/900), 202*(x/1440), 77*(y/900), tocolor(0, 0, 0, 150), false)
    dxDrawRectangle(613*(x/1440), 76*(y/900), 210*(x/1440), 6*(y/900), tocolor(58, 98, 242, 150), false)
    dxDrawText(infoboxText, 617*(x/1440), 0*(y/900), 819*(x/1440), 72*(y/900), tocolor(infoboxR,infoboxG,infoboxB, 150), 1.10*(y/900), "default", "center", "center", false, true, false, false, false)
end