function resetOmStates(me)
switch me.currentAction.getState()
    case 'OM PROPOSE EXECUTE'
        me.peOm.statusReady();
        me.peOm.start();
    case 'OM GET CONTROL POINTS'
        me.gcpOm.statusReady();
        me.gcpOm.start();
    otherwise
end
end
