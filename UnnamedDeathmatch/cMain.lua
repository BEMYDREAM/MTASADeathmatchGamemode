x,y = guiGetScreenSize();
local FONT = guiCreateFont("Files/Fonts/Honor.ttf",8.5);
GUIEditor = { gridlist = {}, window = {}, button = {}, label = {}, radiobutton = {}, edit = {}, memo = {}, staticimage = {} };
Serverinfos = {name = "Unnamed Deathmatch", version = "v.0.9.9"};

--// isCursorOnElement
function isCursorOnElement( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end

--// setWindowDatas
function setWindowDatas(type)
	if(type == "set")then
		showCursor(true);
		setElementData(localPlayer,"elementClicked",true);
		if(isElement(GUIEditor.window[1]))then
			centerWindow(GUIEditor.window[1]);
		end
		if(#GUIEditor.label >= 1)then
			for i = 1,#GUIEditor.label do
				if(isElement(GUIEditor.label[i]))then
					guiSetFont(GUIEditor.label[i],FONT);
				end
			end
		end
		if(#GUIEditor.button >= 1)then
			for i = 1,#GUIEditor.button do
				if(isElement(GUIEditor.button[i]))then
					guiSetFont(GUIEditor.button[i],FONT);
				end
			end
		end
	elseif(type == "reset")then
		showCursor(false);
		setElementData(localPlayer,"elementClicked",false);
		if(isElement(GUIEditor.window[1]))then destroyElement(GUIEditor.window[1])end
	end
end
addEvent("setWindowDatas",true)
addEventHandler("setWindowDatas",root,setWindowDatas)

--// isWindowOpen
function isWindowOpen()
	if(isElement(GUIEditor.window[1]) or getElementPosition(localPlayer,"elementClicked") == true or getElementData(localPlayer,"SkinZiehung") == true)then
		return false
	else
		return true
	end
end

--// smoothMoveCamera
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientPreRender",root,camRender)
	end
end
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
        setElementCollisionsEnabled (sm.object1,false) 
	setElementCollisionsEnabled (sm.object2,false) 
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	addEventHandler("onClientPreRender",root,camRender)
	return true
end
		
bindKey("b","down",function()
	if(isWindowOpen())then
		showCursor(not(isCursorShowing()));
	end
end)

--// centerWindow
function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

guiSetInputMode("no_binds_when_editing");

--// Kein Damage in Lobbys
addEventHandler("onClientPlayerDamage",root,function()
	if(getElementData(source,"Lobby") == "Eingangshalle")then
		cancelEvent();
	end
end)

addEventHandler("onClientPlayerDamage",root,function(attacker)
	if(not(attacker))then
		cancelEvent();
	end
end)

--// Convert time
function convertMS(ms)
	local seconds = math.ceil(ms/1000);
	local minutes = math.floor(seconds/60);
	local seconds = seconds % 60;
	if(minutes < 10)then minutes = "0"..minutes end
	if(seconds < 10)then seconds = "0"..seconds end
	return minutes..":"..seconds;
end