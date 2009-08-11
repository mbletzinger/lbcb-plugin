function openCloseConnection(me, connection,value)
% closeIt = me.oc.closeIt
% val = value
if (me.oc.closeIt && value)
    action = 'CLOSE CONNECTION';
else
    if value == 0
        me.colorConnectionButton(connection);
        return;
    end
    action = 'OPEN CONNECTION';
end
me.oc.start(connection,me.cfg);
me.currentAction.setState(action);
start(me.simTimer);
me.colorConnectionButton(connection);
end
