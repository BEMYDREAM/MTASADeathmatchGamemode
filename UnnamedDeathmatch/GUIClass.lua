local FONT = guiCreateFont("Files/Fonts/Dash-Dermo.ttf",15);

--// Fenster
function guiCreateNewWindow(x,y,w,h,text,relative)
	local window = guiCreateStaticImage(x,y,w,h,"Files/Images/Window1.png",relative);
	local balken = guiCreateStaticImage(0,0,w,20,"Files/Images/Window2.png",relative,window);
	local label = guiCreateLabel(0,0,w,20,text,relative,window);
	guiSetFont(label,FONT);
	guiLabelSetHorizontalAlign(label,"center",true);
	guiLabelSetVerticalAlign(label,"center");
	
	return window;
end
guiCreateWindow = guiCreateNewWindow;

--// Button
function guiCreateNewButton(x,y,w,h,text,relative,parent)
	local button = guiCreateStaticImage(x,y,w,h,"Files/Images/Button.png",relative,parent);
	local label = guiCreateLabel(x,y,w,h-3,text,relative,parent);
	guiCreateStaticImage(x,y,w,1,"Files/Images/Pixel/Weiss.png",relative,parent);
	guiCreateStaticImage(x+w-1,y,1,h,"Files/Images/Pixel/Weiss.png",relative,parent);
	guiCreateStaticImage(x,y+h-1,w,1,"Files/Images/Pixel/Weiss.png",relative,parent);
	guiCreateStaticImage(x,y,1,h,"Files/Images/Pixel/Weiss.png",relative,parent);
	guiSetFont(label,"default-bold-small");
	guiLabelSetHorizontalAlign(label,"center",true);
	guiLabelSetVerticalAlign(label,"center");
	
	return label;
end
guiCreateButton = guiCreateNewButton;