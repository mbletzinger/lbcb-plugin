function processConnectOm(me,on)
me.currentExecute.setState('OPEN CLOSE CONNECTION');
action = 'CLOSE OM CONNECTION';
if on
    action = 'OPEN OM CONNECTION';
    me.hfact.ocOm.start(0);
else
    me.hfact.ocOm.start(1);
end
me.connectOmAction(action);
start(me.comTimer);
end