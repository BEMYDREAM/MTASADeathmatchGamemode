Minigames = { activeMinigame = nil }

--// Quersumme ausrechnen
function generateQuersumme()
	local tbl = {};
	Minigames.quersumme = "";
	Minigames.quersummeLoesung = 0;
	Minigames.quersummeBelohnung = math.random(200,400);
	Minigames.quersummeGelouest = false;
	Minigames.activeMinigame = "Quersumme";
	for i = 1,10 do
		local rnd = math.random(0,9);
		Minigames.quersumme = Minigames.quersumme..rnd;
		Minigames.quersummeLoesung = Minigames.quersummeLoesung + rnd;
	end
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage1"):format(Minigames.quersumme,Minigames.quersummeBelohnung),v,255,255,255,true);
		end
	end
	Minigames.endTimer = setTimer(function()
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1)then
				outputChatBox(loc(v,"MinigamesMessage2"),v,255,255,255,true);
			end
		end
	end,120000,1)
end

function Minigames.quersummeFinished(player)
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage3"):format(getPlayerName(v),Minigames.quersummeLoesung,Minigames.quersummeBelohnung),v,255,255,255,true);
		end
	end
	setElementData(player,"Geld",getElementData(player,"Geld")+Minigames.quersummeBelohnung);
	if(isTimer(Minigames.endTimer))then killTimer(Minigames.endTimer)end
end

--// Minigame auslösen
setTimer(function()
	local rnd = math.random(1,1);
	if(rnd == 1)then
		generateQuersumme();
	end
end,1800000,0)