Elements = {edit = {}, button = {}};
Edit = {}; Button = {};

--// Edits
function Edit:create(x,y,w,h,gx,gy,text,password)
	if(not(text))then text = "" end
	local self = setmetatable({},{__index = self});
	self.x = x; self.y = y; self.w = w; self.h = h;
	self.text = text;
	self.active = false;
	self.shiftactive = false;
	self.editActiv = true;
	self.gx = gx; self.gy = gy;
	self.render = function() self:onRender() end
	self.click = function(button,state) self:onClick(button,state) end
	self.shift = function(key,state) self:onShift(key,state) end
	self.passwordType = false;
	if(password)then self.passwordType = true end
	bindKey("lshift","both",self.shift);
	bindKey("rshift","both",self.shift);
	addEventHandler("onClientRender",root,self.render);
	addEventHandler("onClientClick",root,self.click);
	return self;
end

function Edit:destroy()
	removeEventHandler("onClientRender",root,self.render);
	removeEventHandler("onClientClick",root,self.click);
	unbindKey("lshift","both",self.shift);
	unbindKey("rshift","both",self.shift);
	self = nil;
end

function Edit:onRender()
	dxDrawRectangle(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy),tocolor(220,220,220,255),true); -- Main Rectangle
	if(self.passwordType == true)then
		local text = "";
		for i = 1,#self.text do text = text.."*" end
		dxDrawText(text,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1.00*(y/self.gy),"default-bold","left","center",_,_,true); -- Text
	else
		dxDrawText(" "..self.text,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1.00*(y/self.gy),"default-bold","left","center",_,_,true); -- Text
	end
	if(self.active == true)then
		dxDrawLine(self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w-1)*(x/self.gx),self.y*(y/self.gy),tocolor(0,0,0,255),1,true); -- Line oben
		dxDrawLine(self.x*(x/self.gx),(self.y+self.h)*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1,true); -- Line unten
		dxDrawLine(self.x*(x/self.gx),self.y*(y/self.gy),self.x*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1,true); -- -- Line links
		dxDrawLine((self.x+self.w)*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h-0)*(y/self.gy),tocolor(0,0,0,255),1,true); -- Line rechts
	end
end

function Edit:onClick(button,state)
	if(button == "left" and state == "down")then
		if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then
			self.active = true;
		else
			self.active = false;
		end
	end
end

NotAllowedKeys = {"mouse1","mouse2","mouse3","mouse4","mouse5","mouse_wheel_up","mouse_wheel_down","arrow_l","arrow_u","arrow_r","arrow_D","num_0","num_1","num_2","num_3","num_4","num_5","num_6","num_7","num_8","num_9","num_mul","num_add","num_sep","num_sub","num_div","num_dec","num_enter","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","escape","tab","lalt","ralt","enter","pgup","pgdn","end","home","insert","delete","lctrl","rctrl","[","]","pause","capslock","scroll","lshift","rshift", "-", ".", "+", "*", "/", "%"};
SpecialKeys = {["1"] = "!",["2"] = '"',["3"] = "§",["4"] = "$",["5"] = "%",["6"] = "&",["7"] = "/",["8"] = "(",["9"] = ")",["0"] = "="};

function EditInput(key,press)
	if(press)then
		if(#Elements.edit >= 1)then
			for _,v in pairs(Elements.edit)do
				if(v.active == true)then
					edit = v;
					break
				end
			end
			if(edit and edit.editActiv == true)then
				local state = true;
				for _,v in pairs(NotAllowedKeys)do
					if(key == v)then
						state = false;
						break
					end
				end
				if(state == true)then
					if(key == "space")then
						edit.text = edit.text.." ";
					elseif(key == "backspace")then
						sub = string.sub(edit.text,1,#edit.text-1);
						edit.text = sub;
					else
						if(edit.shiftactive == true)then
							if(SpecialKeys[key])then
								key = SpecialKeys[key];
							else
								key = string.upper(key);
							end
						end
						edit.text = edit.text..key;
					end
				end
			end
		end
	end
end
addEventHandler("onClientKey",root,EditInput)

function Edit:onShift(key,state)
	if(self.active == true)then
		if(state == "down")then
			self.shiftactive = true;
		else
			self.shiftactive = false;
		end
	end
end

function Edit:getText() return self.text; end

--// Buttons
function Button:create(x,y,w,h,gx,gy,title,callfunc)
	local self = setmetatable({},{__index = self});
	self.x = x; self.y = y; self.w = w; self.h = h;
	self.r = 58; self.g = 98; self.b = 242;
	self.title = title;
	self.callfunc = callfunc;
	self.gx = gx; self.gy = gy;
	self.render = function() self:onRender() end
	self.click = function(button,state) self:onClick(button,state) end
	addEventHandler("onClientRender",root,self.render);
	addEventHandler("onClientClick",root,self.click);
	return self;
end

function Button:onRender()
	dxDrawRectangle(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy),tocolor(self.r,self.g,self.b,175),true); -- Main rectangle
	dxDrawText(self.title,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(255,255,255,255),1.00*(y/self.gy),"default-bold","center","center",_,_,true); -- Title
	
	if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then self.r = 51; self.g = 86; self.b = 212 else self.r = 0; self.g = 0; self.b = 0; end
end

function Button:onClick(button,state)
	if(button == "left" and state == "down")then
		if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then
			triggerEvent(self.callfunc,localPlayer);
		end
	end
end

function Button:destroy()
	removeEventHandler("onClientRender",root,self.render);
	removeEventHandler("onClientClick",root,self.click);
	self = nil;
end