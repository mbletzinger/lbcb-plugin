function getInitialPosition(me)
me.gettingInitialPosition = true;
if me.cdp.numLbcbs() == 2
    tgts = { Target Target };
else
    tgts = { Target };
end
me.dat.curStepData = me.sdf.target2StepData(tgts,0,0);
me.dat.curStepData.stepNum.isInitialPosition = true;
me.gipOm.start();
me.currentAction.setState('OM GET INITIAL POSITION');
me.statusBusy();
end
