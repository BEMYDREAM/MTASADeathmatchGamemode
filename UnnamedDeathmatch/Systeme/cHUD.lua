Components = {"ammo","area_name","armour","breath","clock","health","money","weapon","radio","wanted"};
for _,v in pairs(Components)do setPlayerHudComponentVisible(v,false)end

--// HUD
addEventHandler("onClientRender", root,
    function()
		if(getElementData(localPlayer,"loggedin") == 1)then
			local Money = getElementData(localPlayer,"Geld");
			local Health, Armor = getElementHealth(localPlayer),getPedArmor(localPlayer);
			local time = getRealTime();
			local minute, hour, monthday, month, year = time.minute, time.hour, time.monthday, time.month+1, time.year+1900;
			if(minute < 10)then minute = "0"..minute end
			if(hour < 10)then hour = "0"..hour end
			if(monthday < 10)then monthday = "0"..monthday end
			if(month < 10)then month = "0"..month end
			local px,py,pz = getElementPosition(localPlayer);
			local Zone = getZoneName(px,py,pz);

			dxDrawRectangle(1607*(x/1920), 10*(y/1020), 303*(x/1920), 139*(y/1020), tocolor(0, 0, 0, 150), false)
			dxDrawImage(1617*(x/1920), 20*(y/1020), 66*(x/1920), 68*(y/1020), "Files/Images/HUD/Waffen/"..tostring(getPedWeapon(localPlayer))..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText(getPedAmmoInClip(localPlayer).." - "..getPedTotalAmmo(localPlayer) - getPedAmmoInClip(localPlayer), 1617*(x/1920), 98*(y/1020), 1683*(x/1920), 114*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawImage(1693*(x/1920), 20*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/time.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1693*(x/1920), 46*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/location.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1693*(x/1920), 72*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/armour.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1693*(x/1920), 98*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/health.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText(monthday.."."..month.."."..year.." - "..hour..":"..minute.." Uhr", 1718*(x/1920), 20*(y/1020), 1900*(x/1920), 36*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "left", "center", false, false, false, false, false)
			dxDrawText(Zone, 1718*(x/1920), 46*(y/1020), 1900*(x/1920), 62*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "left", "center", false, false, false, false, false)
			dxDrawRectangle(1718*(x/1920), 72*(y/1020), 182*(x/1920), 16*(y/1020), tocolor(0, 0, 0, 255), false)
			dxDrawRectangle(1718*(x/1920), 98*(y/1020), 182*(x/1920), 16*(y/1020), tocolor(0, 0, 0, 255), false)
			dxDrawRectangle(1718*(x/1920), 72*(y/1020), 182*(x/1920)/100*Armor, 16*(y/1020), tocolor(73, 73, 73, 255), false)
			dxDrawRectangle(1718*(x/1920), 98*(y/1020), 182*(x/1920)/100*Health, 16*(y/1020), tocolor(209, 0, 0, 255), false)
			dxDrawRectangle(1718*(x/1920), 82*(y/1020), 182*(x/1920)/100*Armor, 6*(y/1020), tocolor(48, 48, 48, 255), false)
			dxDrawRectangle(1718*(x/1920), 108*(y/1020), 182*(x/1920)/100*Health, 6*(y/1020), tocolor(157, 0, 0, 255), false)
			dxDrawText(math.floor(Armor).."%", 1718*(x/1920), 72*(y/1020), 1900*(x/1920), 88*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawText(math.floor(Health).."%", 1718*(x/1920), 98*(y/1020), 1900*(x/1920), 114*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
			dxDrawImage(1617*(x/1920), 123*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/money.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText("$"..Money, 1642*(x/1920), 123*(y/1020), 1755*(x/1920), 139*(y/1020), tocolor(74, 152, 4, 255), 1.00, ScoreboardFont2, "left", "center", false, false, false, false, false)
			dxDrawRectangle(1607*(x/1920), 10*(y/1020), 303*(x/1920), 6*(y/1020), tocolor(58, 98, 242, 255), false)
			dxDrawImage(1765*(x/1920), 123*(y/1020), 15*(x/1920), 16*(y/1020), "Files/Images/HUD/coins.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawText(getElementData(localPlayer,"UnnamedCoins"), 1790*(x/1920), 123*(y/1020), 1903*(x/1920), 139*(y/1020), tocolor(74, 152, 4, 255), 1.00, ScoreboardFont2, "left", "center", false, false, false, false, false)
			
			local AoDPlayers,AoDPlayersNotDead,YakuzaPlayers,YakuzaPlayersNotDead = 0,0,0,0;
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(v,"Lobby") == "TacticsArena")then
					if(getElementData(v,"TacticsTeam") == 1)then
						AoDPlayers = AoDPlayers + 1;
						if(not(isPedDead(v)))then
							AoDPlayersNotDead = AoDPlayersNotDead + 1;
						end
					elseif(getElementData(v,"TacticsTeam") == 2)then
						YakuzaPlayers = YakuzaPlayers + 1;
						if(not(isPedDead(v)))then
							YakuzaPlayersNotDead = YakuzaPlayersNotDead + 1;
						end
					end
				end
			end
			
			if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
				dxDrawRectangle(1607*(x/1920), 163*(y/1020), 148*(x/1920), 37*(y/1020), tocolor(100, 50, 50, 150), false)
				dxDrawRectangle(1762*(x/1920), 163*(y/1020), 148*(x/1920), 37*(y/1020), tocolor(150, 0, 0, 150), false)
				dxDrawText("Angels of Death\n"..AoDPlayersNotDead.."/"..AoDPlayers, 1607*(x/1920), 163*(y/1020), 1755*(x/1920), 200*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
				dxDrawText("Yakuza\n"..YakuzaPlayersNotDead.."/"..YakuzaPlayers, 1762*(x/1920), 163*(y/1020), 1910*(x/1920), 200*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
			end
			if(getElementData(localPlayer,"Lobby") ~= "Eingangshalle" and getElementData(localPlayer,"SpectatormodeAktiv") ~= true)then
				if(getElementData(localPlayer,"Lobby") ~= "TacticsArena")then time = "-" else time = convertMS(getElementData(localPlayer,"Tactics.zeitCounter")*1000) end
				dxDrawRectangle(1607*(x/1920), 206*(y/1020), 303*(x/1920), 37*(y/1020), tocolor(0, 0, 0, 150), false)
				dxDrawImage(1613*(x/1920), 216*(y/1020), 15*(x/1920), 17*(y/1020), "Files/Images/HUD/flash.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawText(getElementData(localPlayer,"TemporaererDamage"), 1638*(x/1920), 216*(y/1020), 1707*(x/1920), 233*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
				dxDrawImage(1717*(x/1920), 216*(y/1020), 14*(x/1920), 17*(y/1020), "Files/Images/HUD/skull.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawText(getElementData(localPlayer,"TemporaererKill"), 1741*(x/1920), 216*(y/1020), 1810*(x/1920), 233*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
				dxDrawImage(1820*(x/1920), 216*(y/1020), 15*(x/1920), 17*(y/1020), "Files/Images/HUD/time.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawText(time, 1845*(x/1920), 216*(y/1020), 1900*(x/1920), 233*(y/1020), tocolor(255, 255, 255, 255), 1.00, ScoreboardFont2, "center", "center", false, false, false, false, false)
			end
		end
    end
)