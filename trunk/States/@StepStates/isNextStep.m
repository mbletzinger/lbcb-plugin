function isNextStep(me)
if me.nxtStep.stepsCompleted  %  No more targets
    me.log.info(dbstack,sprintf('Step %d is completed',...
        me.dat.curStepTgt.stepNum.step));
    me.statusReady();
    me.currentAction.setState('DONE');
else % Execute next step
    if isempty(me.gui) == false
     me.gui.updateCommandTable();
        me.gui.updateStepsDisplay(me.dat.nextStepData.stepNum);
        me.currentAction.setState('ACCEPT STEP');
    end
    me.acceptStp.start();
end
end
