function processTarget(me)
done = me.prcsTgt.isDone;
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
