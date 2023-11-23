weaponDamage = {[8] = 35,[22] = 10,[23] = 0,[24] = 40,[25] = 20,[28] = 5,[29] = 8,[30] = 6,[31] = 8,[32] = 5,[33] = 15,[34] = 50,[51] = 40};

--// Bloodscreen
local bloodAlpha = 0;

function showBloodFlash()
	bloodAlpha = 255;
end
addEvent("showBloodFlash",true)
addEventHandler("showBloodFlash",root,showBloodFlash)

addEventHandler("onClientRender",root,function()
	if(bloodAlpha > 0)then
		dxDrawImage(0,0,x,y,"Files/Images/Bloodscreen.png",0,0,0,tocolor(255,255,255,bloodAlpha));
		bloodAlpha = math.max(0,bloodAlpha-3);
	end
end)

--// Player Damage
addEventHandler("onClientPlayerDamage",root,function(attacker,weapon,bodypart,loss)
	if(source == localPlayer)then
		showBloodFlash();
	end
	if(attacker == localPlayer)then
		if(source ~= localPlayer)then
			local sound = playSound("Files/Sounds/Hitsound.mp3");
			setSoundVolume(sound,0.3);
		end
		if(weaponDamage[weapon])then
			triggerServerEvent("damageCalcServer",localPlayer,attacker,weapon,bodypart,loss,source);
		end
	end
	if(source == localPlayer)then
		if(not(isPedDead(localPlayer)))then
			showBloodFlash();
		end
		if(weaponDamage[weapon])then cancelEvent()end
	end
end)

--// Reddot
local reddot = 0;

function reddot_func()
	if(reddot == 0)then
		reddot = 1;
		addEventHandler("onClientRender",root,reddot_render);
		infobox(loc("HitboxMessage1"),0,125,0);
	else
		reddot = 0;
		removeEventHandler("onClientRender",root,reddot_render);
		infobox(loc("HitboxMessage2"),125,0,0);
	end
end
addCommandHandler("reddot",reddot_func)

function reddot_render()
	local weaponslot = getPedWeaponSlot(localPlayer);
	if(weaponslot and weaponslot <= 7 and weaponslot >= 2)then
		if(getPedControlState(localPlayer,"aim_weapon"))then
			local x1,y1,z1 = getPedWeaponMuzzlePosition(localPlayer);
			x1 = x1 + 0.01;
			y1 = y1 + 0.01;
			z1 = z1 + 0.01;
			local x2,y2,z2 = getPedTargetEnd(localPlayer);
			local x3,y3,z3 = getPedTargetCollision(localPlayer);
			if(x3)then
				dxDrawLine3D(x1,y1,z1,x3,y3,z3,tocolor(255,0,0,150),4,false);
			else
				dxDrawLine3D(x1,y1,z1,x2,y2,z2,tocolor(255,0,0,150),4,false);
			end
		end
	end
end