function updateCommandTable(me)
% me.log.info(dbstack,'Update command table called');
if(isempty(me.handles) == false)
    hndl = me.handles.CommandTable;
else
    me.log.error(dbstack,'command table handle not set');
end
me.cmdTable = me.hfact.dat.cmdTable();
if(isempty(me.handles) == false)
    [ didx, fidx, labels ] = me.hfact.dat.cmdTableHeaders(); %#ok<ASGLU>
    if(isempty(me.handles) == false)
        set(hndl,'ColumnName',labels);
        set(hndl,'RowName', {'Step Target','Substep Target','Correction Target',...
            'Next Substep','Current Substep','Previous Substep'});
    end
    set(hndl,'Data',me.cmdTable);
    me.updateGui();
end
end
