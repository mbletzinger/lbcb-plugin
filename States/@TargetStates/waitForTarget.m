function waitForTarget(me)
if me.targetSource.isState('INPUT FILE')
    target = me.inF.next();
    if me.inF.endOfFile
        me.currentAction.setState('DONE');
        return;
    end
    %    me.dat.curStepTgt.transformCommand();
    me.dat.stepTgtShift(target);
    steps = me.splitTarget();
    me.currentAction.setState('EXECUTE SUBSTEPS');
    me.stpEx.start(steps);
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
        me.tgtRsp.target.loadCfg();
        me.tgtRsp.target.transformCommand();
        me.dat.stepTgtShift(me.tgtRsp.target);
        steps = me.splitTarget();
        me.currentAction.setState('EXECUTE SUBSTEPS');
        me.stpEx.start(steps);
        stp = me.dat.curStepTgt.stepNum.step;
#        me.stats.stepStart(stp);
    end
end
end
