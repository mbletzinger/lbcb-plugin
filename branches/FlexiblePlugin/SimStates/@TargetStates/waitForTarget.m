function waitForTarget(me)
if me.targetSource.isState('INPUT FILE')
    if me.inF.endOfFile
        me.currentAction.setState('DONE');
    else
        me.currentAction.setState('GET TARGET');
    end
    return;
end
end
