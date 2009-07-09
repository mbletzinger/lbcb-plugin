function openCloseConnection(me, connection)
me.oc.start(connection,me.cfg);
if me.oc.closeIt
    action = 'CLOSE CONNECTION';
else
    action = 'OPEN CONNECTION';
end
me.currentAction.setState(action);
start(me.simTimer);
end
