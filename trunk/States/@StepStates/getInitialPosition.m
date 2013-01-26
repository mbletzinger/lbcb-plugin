function getInitialPosition(me)
me.gettingInitialPosition = true;
if me.cdp.numLbcbs() == 2
    tgts = { Target Target };
else
    tgts = { Target };
end
stp = me.sdf.target2StepData(tgts,0,0);
stp.stepNum.isInitialPosition = true;
me.dat.executeHist.push(stp);
me.gipOm.start();
me.currentAction.setState('OM GET INITIAL POSITION');
me.statusBusy();
end
