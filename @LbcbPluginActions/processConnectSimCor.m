function processConnectSimCor(me,on)
me.currentExecute.setState('OPEN CLOSE CONNECTION');
action = 'CLOSE SIMCOR CONNECTION';
if on
    action = 'OPEN SIMCOR CONNECTION';
end
me.hfact.cnEx.start(action);
me.startSimulation()
end