Peds = {
	-- Model, x, y, z, rot, int, dim, event
	{100,259.84088134766,-22.374439239502,1.7529447078705,270,0,0,"DeagleArena.createWindow","Deagle Lobbys"},
	{100,1713.8049316406,-1663.4626464844,20.227939605713,270,18,0,"DeagleArena.createWindow","Deagle Lobbys"},
	{123,259.84088134766,-20.177139282227,1.7529400587082,270,0,0,"DeathmatchArena.createWindow","Deathmatch Lobbys"},
	{123,1713.8046875,-1655.5325927734,20.222465515137,270,18,0,"DeathmatchArena.createWindow","Deathmatch Lobbys"},
	{113,255.21067810059,-27.30587387085,1.5864491462708,270,0,0,"Tactics.putPlayerInTeam","Tactics Lobby"},
	{113,1729.2084960938,-1647.6589355469,20.232688903809,90,18,0,"Tactics.putPlayerInTeam","Tactics Lobby"},
	{108,259.88134765625,-12.438877105713,2.189953327179,270,0,0,"Lootbox.openWindow","Lootboxen"},
	{108,1728.9276123047,-1661.6488037109,20.238193511963,44,18,0,"Lootbox.openWindow","Lootboxen"},
};

--// Peds erstellen
if(#Peds >= 1)then
	for _,v in pairs(Peds)do
		local ped = createPed(v[1],v[2],v[3],v[4],v[5]);
		setElementInterior(ped,v[6]);
		setElementDimension(ped,v[7]);
		setElementFrozen(ped,true);
		setElementData(ped,"PedEvent",v[8]);
		setElementData(ped,"PedName",v[9]);
		
		addEventHandler("onClientPedDamage",ped,function()
			cancelEvent();
		end)
	end
end

--// Nametag rendern
addEventHandler("onClientRender",root,function()
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementDimension(localPlayer) == getElementDimension(v) and getElementInterior(localPlayer) == getElementInterior(v))then
			local px,py,pz = getPedBonePosition(v,8);
			local lx,ly,lz = getPedBonePosition(localPlayer,8);
				
			if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) <= 15 and isLineOfSightClear(px,py,pz,lx,ly,lz,true,false,false,true,false))then
				if(getElementData(v,"PedName"))then
					if(not(isPedDead(v)))then
						local worldx,worldy = getScreenFromWorldPosition(px,py,pz+0.5,1000,true);
						
						if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) > 1)then
							scale = 0.6 - (getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz)/70);
						else
							scale = 0.6;
						end
						
						if(worldx and worldy)then
							if(getElementData(localPlayer,"elementClicked") ~= true)then
								dxDrawText(getElementData(v,"PedName"),worldx,worldy,worldx,worldy,tocolor(0,255,0),scale,"bankgothic","center","center");
								dxDrawText(loc("PedMessage1"),worldx-2,worldy+25,worldx,worldy,tocolor(0,255,0),scale - 0.2,"bankgothic","center","center");
							end
						end
					end
				end
			end
		end
	end
end)

--// Peds anklicken
addEventHandler("onClientClick",root,function(button,state,absx,absy,wx,wy,wz,element)
	if(element and getElementType(element) == "ped" and state == "down")then
		local x,y,z = getElementPosition(localPlayer);
		if(getDistanceBetweenPoints3D(x,y,z,wx,wy,wz) <= 3)then
			if(getElementData(element,"PedEvent"))then
				triggerEvent(getElementData(element,"PedEvent"),localPlayer);
			end
		end
	end
end)