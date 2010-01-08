function updateCommandTable(me)

if(isempty(me.handles) == false)
    hndl = me.handles.CommandTable;
end
if isempty(me.cmdTable)
    [ didx, fidx, labels ] = me.hfact.dat.cmdTableHeaders(); %#ok<ASGLU>
    if(isempty(me.handles) == false)
        set(hndl,'ColumnName',labels);
    end
end
me.cmdTable = me.hfact.dat.cmdTable();
if(isempty(me.handles) == false)
    set(hndl,'Data',me.cmdTable);
    me.updateGui();
end
end
