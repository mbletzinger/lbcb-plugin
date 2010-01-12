function executeSubsteps(me)
if me.stpEx.isDone() == false
    return;
end
me.dat.curTarget.transformResponse();
me.currentAction.setState('SEND TARGET RESPONSE');
if me.targetSource.isState('UI SIMCOR')
    me.tgtRsp.respond();
end
end
