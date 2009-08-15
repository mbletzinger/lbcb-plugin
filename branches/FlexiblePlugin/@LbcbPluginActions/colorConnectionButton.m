function colorConnectionButton(me,connection)
hndls = {me.handles.Connect2Om; me.handles.StartTriggering; me.handles.StartSimCor};
val = get(hndls{1},'Value');
status = me.ocOm.connectionStatus.getState();
me.log.debug(dbstack,sprintf('val %d status %s ocOm actions %s',val,status, me.ocOm.omActions.getState()));
if val == 0
    set(hndls{1},'BackgroundColor','w');
    return;
end

if me.ocOm.omActions.isState('DONE') == 0
    return;
end

status = me.ocOm.connectionStatus.getState();
switch status
    case 'CONNECTED'
        set(hndls{1},'BackgroundColor','g');
        if me.currentAction.isState('READY')
            me.log.info(dbstack,sprintf('%s is connected', connection));
        end
    case 'DISCONNECTED'
        set(hndls{1},'BackgroundColor','w');
        me.log.info(dbstack,sprintf('%s is disconnected', connection));
    case 'ERRORED'
        set(hndls{1},'BackgroundColor','r');
        me.log.info(dbstack,sprintf('%s connection failed', connection));
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',status));
end
end