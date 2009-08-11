function colorConnectionButton(me,connection)
hndls = {me.handles.Connect2Om; me.handles.StartTriggering; me.handles.StartSimCor};
me.oc.connectionType.setState(connection);
status = me.oc.connectionStatus(me.oc.connectionType.idx);
errors = me.errorsExist(connection);
val = get(hndls{me.oc.connectionType.idx},'Value');
if status && val
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','g');
    if me.currentAction.isState('READY')  && errors == false
        me.log.info(dbstack,sprintf('%s is connected', connection));
    end
else
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','w');
    if val
    me.log.info(dbstack,sprintf('%s is disconnected', connection));
    end
end

if errors && val
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','r');
    me.log.info(dbstack,sprintf('%s connection failed', connection));
end
end