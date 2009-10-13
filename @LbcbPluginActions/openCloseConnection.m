function openCloseConnection(me, connection,closeIt)
% closeIt = me.oc.closeIt
% val = value
if (closeIt)
    action = 'CLOSE CONNECTION';
else
    action = 'OPEN CONNECTION';
end
me.colorConnectionButton(connection);
end
