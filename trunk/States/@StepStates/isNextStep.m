function isNextStep(me)
if me.nxtStep.stepsCompleted  %  No more targets
    me.log.info(dbstack,sprintf('Target %d is done',...
        me.dat.curStepTgt.stepNum.step));
    me.statusReady();
    me.currentAction.setState('DONE');
else % Execute next step
    me.acceptStp.start();
    me.gui.updateCommandTable();
    me.gui.updateStepsDisplay(me.dat.nextStepData.stepNum);
    me.currentAction.setState('ACCEPT STEP');
    me.gui.updateStepTolerances(me.st);
end
end
