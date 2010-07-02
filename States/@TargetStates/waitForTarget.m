function waitForTarget(me)
if me.targetSource.isState('INPUT FILE')
    target = me.inF.next();
    if me.inF.endOfFile
        me.currentAction.setState('DONE');
        return;
    end
%    me.dat.curTarget.transformCommand();
    me.prcsTgt.start(target);
    me.currentAction.setState('PROCESS TARGET');
    return;
else
    if me.tgtRsp.isDone()
        if me.tgtRsp.hasErrors()
            me.ocSimCor.connectionError();
            me.statusErrored();
            me.currentAction.setState('DONE');
            return;
        end
        if me.tgtRsp.abort
            me.currentAction.setState('ABORT SIMULATION');
            return;
        end
    me.tgtRsp.target.transformCommand();
    me.prcsTgt.start(me.tgtRsp.target);
    me.currentAction.setState('PROCESS TARGET');
    end
end
end
