function processConnectSimCor(me,on)
action = 'CLOSE SIMCOR CONNECTION';

if on
    action = 'OPEN SIMCOR CONNECTION';
    nope = me.hfact.ocSimCor.start(0);
else
    button = questdlg('Do you want to end the simulation?','Stopping Simulation','Proceed','Cancel','Cancel');
    if strcmp(button,'Proceed')
        nope = me.hfact.ocSimCor.start(1);
    end
end
if nope
    return;
end
me.connectSimCorAction.setState(action);
isOn = get(me.csimcorTimer,'Running');
if strcmp(isOn,'off')
    start(me.csimcorTimer);
end
end