function executeSubsteps(me)
if me.stpEx.isDone() == false
    return;
end
if me.stpEx.hasErrors()
    me.statusErrored();
    me.currentAction.setState('DONE');
    return;
end
me.dat.collectTargetResponse();
me.currentAction.setState('SEND TARGET RESPONSE');
if me.targetSource.isState('UI SIMCOR')
    me.tgtRsp.respond();
    me.arch.marchive(me.dat.curStepTgt);
end
end
