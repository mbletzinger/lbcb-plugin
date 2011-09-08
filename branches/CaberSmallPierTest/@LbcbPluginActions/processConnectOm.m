function processConnectOm(me,on)
action = 'CLOSE OM CONNECTION';
if on
    action = 'OPEN OM CONNECTION';
    nope = me.hfact.ocOm.start(0);
else
    nope = me.hfact.ocOm.start(1);
end
if nope
    return;
end
me.connectOmAction.setState(action);
isOn = get(me.comTimer,'Running');
if strcmp(isOn,'off')
    start(me.comTimer);
end
end