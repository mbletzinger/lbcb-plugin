function initialPosition(me)
if me.stpEx.isDone() == false
    return;
end
me.currentAction.setState('WAIT FOR TARGET');
if me.targetSource.isState('UI SIMCOR')
    me.tgtRsp.start();
end
    
end
