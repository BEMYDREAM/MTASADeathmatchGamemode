Topliste = {};

--// Topliste Daten bekommen
addEvent("Topliste.getDatas",true)
addEventHandler("Topliste.getDatas",root,function(typ)
	local tbl = {};
	local result = dbPoll(dbQuery(handler,"SELECT * FROM userdata ORDER BY "..typ.." DESC;"),-1);
	if(#result >= 1)then
		for i,v in pairs(result)do
			table.insert(tbl,{v["Username"],v[typ]});
			if(i >= 10)then break end
		end
	end
	triggerClientEvent(client,"Topliste.setDatas",client,tbl);
end)