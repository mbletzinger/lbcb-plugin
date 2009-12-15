function updateCommandTable(me)
hndl = me.handles.CommandTable;
if isempty(me.cmdTable)
    [ didx, fidx, labels ] = me.hfact.dat.cmdTableHeaders(); %#ok<ASGLU>
    set(hndl,'ColumnName',labels);
end
me.cmdTable = me.hfact.dat.cmdTable();
set(hndl,'Data',me.cmdTable);
me.updateGui();
end
