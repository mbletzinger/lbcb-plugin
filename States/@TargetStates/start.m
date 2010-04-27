function start(me)
if me.targetSource.isState('NONE')
    me.gui.colorRunButton('OFF');
    me.log.info(dbstack,'Target source has not been set');
    me.statusErrored();
    return;
end
me.currentAction.setState('INITIAL POSITION');
me.inF.sIdx = 1;
me.startStep = 1;
me.stpEx.getInitialPosition();
me.statusBusy();
end
