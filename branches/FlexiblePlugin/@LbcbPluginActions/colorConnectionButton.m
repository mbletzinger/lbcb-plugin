function colorConnectionButton(me,connection)
hndls = {me.handles.Connect2Om; me.handles.StartTriggering; me.handles.StartSimCor};
me.oc.connectionType.setState(connection);
status = me.oc.connectionStatus(me.oc.connectionType.idx);
errors = me.errorsExist(connection);
if status
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','g');
    if me.currentAction.isState('READY')  && errors == false
        me.log.info(dbstack,sprintf('%s is connected', connection));
    end
else
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','w');
    me.log.info(dbstack,sprintf('%s is disconnected', connection));
end

if errors
    set(hndls{me.oc.connectionType.idx},'BackgroundColor','r');
    me.log.info(dbstack,sprintf('%s connection failed', connection));
end
end