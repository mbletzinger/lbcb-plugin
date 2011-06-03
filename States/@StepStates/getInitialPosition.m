function getInitialPosition(me)
me.gettingInitialPosition = true;
if me.cdp.numLbcbs() == 2
    tgts = { Target Target };
else
    tgts = { Target };
end
me.dat.curStepData = me.sdf.target2StepData(tgts,0,0);
me.dat.curStepData.isInitialPosition = true;
me.gcpOm.start();
me.currentAction.setState('OM GET CONTROL POINTS');
me.statusBusy();
end
