function processConnectSimCor(me,on)
action = 'CLOSE SIMCOR CONNECTION';
if on
    action = 'OPEN SIMCOR CONNECTION';
    me.hfact.ocSimCor.start(0);
else
    me.hfact.ocSimCor.start(1);
end
me.connectSimCorAction.setState(action);
isOn = get(me.csimcorTimer,'Running');
if strcmp(isOn,'off')
    start(me.csimcorTimer);
end
end