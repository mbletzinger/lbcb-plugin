function startSimulation(me)
    me.currentSimExecute.setState('RUN SIMULATION');
if me.alreadyStarted
    return;
end

if isempty(me.hfact.mdlLbcb.simcorTcp)
    me.log.error(dbstack,'OM is not connected');
    return; %#ok<*UNRCH>
end
    me.hfact.tgtEx.start();
    me.alreadyStarted = true;
end