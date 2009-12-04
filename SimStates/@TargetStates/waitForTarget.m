function waitForTarget(me)
if me.targetSource.isState('INPUT FILE')
    target = me.inF.next();
    if me.inF.endOfFile
        me.currentAction.setState('DONE');
        return;
    end
    me.prcsTgt.start(target);
    me.currentAction.setState('PROCESS TARGET');
    return;
end
end
