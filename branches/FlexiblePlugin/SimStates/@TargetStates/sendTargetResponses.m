function sendTargetResponses(me)
if me.targetSource.isState('INPUT FILE')
    me.dat.prevTarget = me.dat.curTarget;
    me.dat.prevTarget.transformResponse();
    me.currentAction.setState('WAIT FOR TARGET');
end
end
