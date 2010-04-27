function startSimulation(me)
    me.currentSimExecute.setState('RUN SIMULATION');
if me.alreadyStarted
    return;
end
    me.hfact.tgtEx.start();
    me.alreadyStarted = true;
end