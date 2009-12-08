function processConnectOm(me,on)
me.currentExecute.setState('OPEN CLOSE CONNECTION');
action = 'CLOSE OM CONNECTION';
if on
    action = 'OPEN OM CONNECTION';
end
me.hfact.cnEx.start(action);
me.startSimulation()
end