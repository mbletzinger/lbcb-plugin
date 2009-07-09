function colorConnectionButton(me,connection)
hndls = {me.handles.Connect2Om; me.handles.StartTriggering; me.handles.StartSimCor};
me.oc.connectionType.setState(connection);
status = me.oc.connectionStatus(me.oc.connectionType.idx);
errors = me.errorsExist(connection);

if status
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','g');
else
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','w');
end

if errors
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','r');
end
end