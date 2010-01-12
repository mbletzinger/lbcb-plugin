function processConnectOm(me,on)
action = 'CLOSE OM CONNECTION';
if on
    action = 'OPEN OM CONNECTION';
    me.hfact.ocOm.start(0);
else
    me.hfact.ocOm.start(1);
end
me.connectOmAction.setState(action);
isOn = get(me.comTimer,'Running');
if strcmp(isOn,'off')
    start(me.comTimer);
end
end