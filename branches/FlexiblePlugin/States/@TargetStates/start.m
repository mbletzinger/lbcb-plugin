function start(me,stepNumber)
if me.targetSource.isState('NONE')
    me.gui.colorRunButton('OFF');
    me.log.info(dbstack,'Target source has not been set');
    me.statusErrored();
    return;
end
me.currentAction.setState('INITIAL POSITION');
me.inF.sIdx = stepNumber;
me.startStep = stepNumber;
me.stpEx.getInitialPosition();
me.statusBusy();
end
