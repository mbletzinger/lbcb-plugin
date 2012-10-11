function resetOmStates(me)
switch me.currentAction.getState()
    case 'OM PROPOSE EXECUTE'
        me.peOm.statusReady();
        me.acceptStp.start();
        me.gui.updateCommandTable();
        me.gui.updateStepsDisplay(me.dat.nextStepData.stepNum);
        me.currentAction.setState('ACCEPT STEP');
    case 'OM GET CONTROL POINTS'
        me.gcpOm.statusReady();
        me.gcpOm.start();
    otherwise
end
end
