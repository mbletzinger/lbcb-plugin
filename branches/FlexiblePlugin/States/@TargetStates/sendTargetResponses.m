function sendTargetResponses(me)
if me.targetSource.isState('UI SIMCOR')
    if me.tgtRsp.isDone()
        if me.tgtRsp.hasErrors()
            me.ocSimCor.connectionError();
            me.statusErrored();
            me.currentAction.setState('DONE');
            return;
        end
        me.tgtRsp.start();
    else
        return;
    end
end
me.dat.prevTarget = me.dat.curTarget;
me.currentAction.setState('WAIT FOR TARGET');
end
