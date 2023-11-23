setWeaponProperty(33,"poor","weapon_range",250);
setWeaponProperty(33,"std","weapon_range",250);
setWeaponProperty(33,"pro","weapon_range",200);
setWeaponProperty(31,"pro","weapon_range",100);
setWeaponProperty(31,"pro","accuracy",0.9);
setWeaponProperty(24,"pro","accuracy",1.6);

weaponDamages = {
	[0] = {[3] = 5,[4] = 5,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 5},
	[4] = {[3] = 10,[4] = 20,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 20},
	[8] = {[3] = 20,[4] = 20,[5] = 20,[6] = 20,[7] = 20,[8] = 20,[9] = 25},
	[22] = {[3] = 10,[4] = 10,[5] = 8,[6] = 8,[7] = 8,[8] = 8,[9] = 15},
	[23] = {[3] = 0,[4] = 0,[5] = 0,[6] = 0,[7] = 0,[8] = 0,[9] = 0},
	[24] = {[3] = 49,[4] = 40,[5] = 29,[6] = 29,[7] = 35,[8] = 35,[9] = 75},
	[25] = {[3] = 25,[4] = 25,[5] = 20,[6] = 20,[7] = 20,[8] = 20,[9] = 35},
	[26] = {[3] = 30,[4] = 30,[5] = 20,[6] = 20,[7] = 20,[8] = 20,[9] = 40}, 
	[27] = {[3] = 30,[4] = 30,[5] = 20,[6] = 20,[7] = 20,[8] = 20,[9] = 40}, 
	[28] = {[3] = 8,[4] = 8,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 10}, 
	[29] = {[3] = 9,[4] = 9,[5] = 8,[6] = 8,[7] = 8,[8] = 8,[9] = 12}, 
	[32] = {[3] = 8,[4] = 8,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 10}, 
	[30] = {[3] = 10,[4] = 10,[5] = 8,[6] = 8,[7] = 8,[8] = 8,[9] = 14}, 
	[31] = {[3] = 9,[4] = 9,[5] = 7,[6] = 7,[7] = 7,[8] = 7,[9] = 12}, 
	[33] = {[3] = 15,[4] = 15,[5] = 12,[6] = 12,[7] = 12,[8] = 12,[9] = 20}, 
	[34] = {[3] = 15,[4] = 15,[5] = 12,[6] = 12,[7] = 12,[8] = 12,[9] = 75}, 
	[35] = {[3] = 80,[4] = 80,[5] = 50,[6] = 50,[7] = 50,[8] = 50,[9] = 130}, 
	[36] = {[3] = 80,[4] = 80,[5] = 50,[6] = 50,[7] = 50,[8] = 50,[9] = 130}, 
	[37] = {[3] = 8,[4] = 8,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 12}, 
	[38] = {[3] = 8,[4] = 8,[5] = 6,[6] = 6,[7] = 6,[8] = 6,[9] = 12}, 
	[16] = {[3] = 80,[4] = 80,[5] = 50,[6] = 50,[7] = 50,[8] = 50,[9] = 130}, 
	[17] = {[3] = 5,[4] = 5,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 5}, 
	[18] = {[3] = 5,[4] = 5,[5] = 5,[6] = 5,[7] = 5,[8] = 5,[9] = 5}, 
	[39] = {[3] = 100,[4] = 100,[5] = 100,[6] = 100,[7] = 100,[8] = 100,[9] = 100},
};

--// Damage Calculate
addEvent("damageCalcServer",true)
addEventHandler("damageCalcServer",root,function(attacker,weapon,bodypart,loss,player)
	triggerClientEvent(player,"showBloodFlash",player);
	local basicDMG = weaponDamages[weapon][bodypart];
	local x1,y1,z1 = getElementPosition(attacker);
	local x2,y2,z2 = getElementPosition(player);
	local dist = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2);
	local multiply = 1;
	if(weapon == 24 and dist <= 1)then multiply = 0.5 end
	damagePlayer(player,basicDMG*multiply,attacker,weapon,bodypart);
	local giveDamage = basicDMG*multiply;
	setElementData(attacker,"TemporaererDamage",getElementData(attacker,"TemporaererDamage")+giveDamage);
	setElementData(attacker,"DamageGesamt",getElementData(attacker,"DamageGesamt")+giveDamage);
end)

--// Damage Player
function damagePlayer(player,amount,attacker,weapon,bodypart)
	local armor = getPedArmor(player);
	local health = getElementHealth(player);
	
	if(armor > 0)then
		if(armor >= amount)then
			setPedArmor(player,armor - amount);
		else
			setPedArmor(player,0);
			local amount = math.abs(armor - amount);

			if(getElementHealth(player) - amount <= 0)then
				local giveDamage = amount;
				if(giveDamage > getElementHealth(player))then giveDamage = getElementHealth(player)end
				if(bodypart == 9)then setPedHeadless(player,true)end
				killPed(player,attacker,weapon,bodypart);
				
				setElementData(attacker,"TemporaererDamage",getElementData(attacker,"TemporaererDamage")+giveDamage);
				if(getElementData(attacker,"Lobby") == "DeagleArena")then setElementData(attacker,"DamageDeagleArena",getElementData(attacker,"DamageDeagleArena")+giveDamage)end
				if(getElementData(attacker,"Lobby") == "DeathmatchArena")then setElementData(attacker,"DamageDeathmatch",getElementData(attacker,"DamageDeathmatch")+giveDamage)end
				if(getElementData(attacker,"Lobby") == "TacticsArena")then setElementData(attacker,"DamageTacticArena",getElementData(attacker,"DamageTacticArena")+giveDamage)end
				
				checkStuffAfterDeath(attacker,player);
			else
				setElementHealth(player,health - amount);
			end
		end
	else
		if(health - amount <= 0)then
			local giveDamage = amount;
			if(giveDamage > getElementHealth(player))then giveDamage = getElementHealth(player)end
			if(bodypart == 9)then setPedHeadless(player,true)end
			killPed(player, attacker, weapon, bodypart);
			setElementData(attacker,"TemporaererDamage",getElementData(attacker,"TemporaererDamage")+giveDamage);
			if(getElementData(attacker,"Lobby") == "DeagleArena")then setElementData(attacker,"DamageDeagleArena",getElementData(attacker,"DamageDeagleArena")+giveDamage)end
			if(getElementData(attacker,"Lobby") == "DeathmatchArena")then setElementData(attacker,"DamageDeathmatch",getElementData(attacker,"DamageDeathmatch")+giveDamage)end
			if(getElementData(attacker,"Lobby") == "TacticsArena")then setElementData(attacker,"DamageTacticArena",getElementData(attacker,"DamageTacticArena")+giveDamage)end
			
			checkStuffAfterDeath(attacker,player);
		end
		setElementHealth(player,health - amount);
	end
end

--// Automatisches reloaden
setGlitchEnabled("quickreload", true);

--// Alles, was nach dem Tod passieren soll
function checkStuffAfterDeath(damager,player)
	if(getElementData(damager,"Lobby") == "DeagleArena")then setElementData(damager,"KillsDeagleArena",getElementData(damager,"KillsDeagleArena")+1) end
	if(getElementData(damager,"Lobby") == "DeathmatchArena")then setElementData(damager,"KillsDeathmatchArena",getElementData(damager,"KillsDeathmatchArena")+1) end
	if(getElementData(damager,"Lobby") == "TacticsArena")then
		setElementData(damager,"KillsTacticArena",getElementData(damager,"KillsTacticArena")+1);
		local money = 75;
		if(hasBronzePremium(damager))then money = money + (money/100*10) end
		if(hasSilberPremium(damager))then money = money + (money/100*15) end
	    if(hasGoldPremium(damager))then money = money + (money/100*25) end
		setElementData(damager,"Geld",getElementData(damager,"Geld")+math.floor(money));
	end
	setElementData(damager,"TemporaererKill",getElementData(damager,"TemporaererKill")+1);
	setElementData(damager,"KillsGesamt",getElementData(damager,"KillsGesamt")+1);
	local KillsGesamt = getElementData(damager,"KillsGesamt");
	if(KillsGesamt == 100)then setPlayerAchievement(damager,8)end
	if(KillsGesamt == 250)then setPlayerAchievement(damager,9)end
	if(KillsGesamt == 500)then setPlayerAchievement(damager,10)end
	if(KillsGesamt == 750)then setPlayerAchievement(damager,11)end
	if(KillsGesamt == 1000)then setPlayerAchievement(damager,12)end
	if(KillsGesamt == 2500)then setPlayerAchievement(damager,13)end
	if(KillsGesamt == 5000)then setPlayerAchievement(damager,14)end
	if(KillsGesamt == 7500)then setPlayerAchievement(damager,15)end
	if(KillsGesamt == 10000)then setPlayerAchievement(damager,16)end
end

--// Tode Achievements checken
function checkTodeAchievement(player)
	local TodeGesamt = getElementData(player,"TodeGesamt");
	if(TodeGesamt == 100)then setPlayerAchievement(player,17)end
	if(TodeGesamt == 250)then setPlayerAchievement(player,18)end
	if(TodeGesamt == 500)then setPlayerAchievement(player,19)end
	if(TodeGesamt == 1000)then setPlayerAchievement(player,20)end
	if(TodeGesamt == 2500)then setPlayerAchievement(player,21)end
	if(TodeGesamt == 5000)then setPlayerAchievement(player,22)end
	if(TodeGesamt == 7500)then setPlayerAchievement(player,23)end
	if(TodeGesamt == 10000)then setPlayerAchievement(player,24)end
end