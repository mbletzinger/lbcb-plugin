function processConnectSimCor(me,on)
me.currentExecute.setState('OPEN CLOSE CONNECTION');
action = 'CLOSE SIMCOR CONNECTION';
if on
    action = 'OPEN SIMCOR CONNECTION';
    me.hfact.ocSimCor.start(0);
else
    me.hfact.ocSimCor.start(1);
end
me.connectSimCorAction(action);
isOn = get(me.simcorTimer,'Running');
if strcmp(isOn,'off')
    start(me.csimcorTimer);
end
end