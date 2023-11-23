--// Nametag
addEventHandler("onClientRender",root,function()
	for _,v in pairs(getElementsByType("player"))do
		if(getPlayerName(v) ~= getPlayerName(localPlayer))then
			if(getElementDimension(localPlayer) == getElementDimension(v) and getElementInterior(localPlayer) == getElementInterior(v) and getElementData(v,"SpectatormodeAktiv") ~= true)then
				setPlayerNametagShowing(v,false);
				local px,py,pz = getPedBonePosition(v,8);
				local lx,ly,lz = getPedBonePosition(localPlayer,8);
				if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
					lx,ly,lz = getPedBonePosition(v,8);
				end
					
				if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) <= 15 and isLineOfSightClear(px,py,pz,lx,ly,lz,true,false,false,true,false))then
					local worldx,worldy = getScreenFromWorldPosition(px,py,pz+0.5,1000,true);
							
					if(getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz) > 1)then
						scale = 0.8 - (getDistanceBetweenPoints3D(px,py,pz,lx,ly,lz)/70);
					else
						scale = 0.8;
					end
							
					if(worldx and worldy)then
						local health,armor = getElementHealth(v),getPedArmor(v);
						local red,green,blue = 255,255,255;
						if(armor == 0)then
							if(health < 50)then red = 200; green = (health/50)*((health/100)*200*2); blue = 0; else green = 200; red = 200-((health-50)/50)*200; blue = 0; end
							if(health == 0)then red,green,blue = 0,0,0; elseif(health >= 95)then red = 200-((100-50)/50)*200; green = 200; blue = 0; end
						end
						
						dxDrawText(getPlayerName(v),worldx,worldy-1,worldx-1,worldy,tocolor(0,0,0),scale,"bankgothic","center","center");
						dxDrawText(getPlayerName(v),worldx,worldy,worldx,worldy,tocolor(red,green,blue,200),scale,"bankgothic","center","center");
						dxDrawText(getElementData(v,"Status"),worldx-2,worldy+25,worldx,worldy,tocolor(0,255,0),scale - 0.2,"bankgothic","center","center");
					end
				end
			end
		end
	end
end)