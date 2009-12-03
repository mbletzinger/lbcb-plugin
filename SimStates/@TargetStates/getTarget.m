function getTarget(me)
if me.targetSource.isState('INPUT FILE')
    me.dat.curTarget = me.inF.next();
    if me.inF.endOfFile
        me.currentAction.setState('DONE');
        return;
    end
    me.dat.curTarget.transformCommand();
    me.dat.clearSteps();
    steps = me.splitTarget();
    me.currentAction.setState('EXECUTE SUBSTEPS');
    me.stpEx.start(steps);
end
end
