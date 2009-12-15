function updateCommandTable(me)
hndl = me.handles.CommandTable;
[ didx, fidx, labels ] = me.hfact.dat.cmdTableHeaders(); %#ok<ASGLU>
table = me.hfact.dat.cmdTable();
set(hndl,'Data',table);
set(hndl,'ColumnName',labels);
me.updateGui();
end
