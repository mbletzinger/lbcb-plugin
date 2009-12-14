function processTarget(me)
done = me.prcsTgt.isDone;
me.setStatus(me.prcsTgt.status);
if me.hasErrors()
    return;
end
if done == false
    return;
end
if me.targetSource.isState('INPUT FILE')
    me.dat.curTarget.transformCommand();
    me.dat.clearSteps();
    steps = me.splitTarget();
    me.currentAction.setState('EXECUTE SUBSTEPS');
    me.stpEx.start(steps);
end
end
