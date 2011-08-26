function start(me,steps)
me.nxtStep.steps = steps;
me.nxtStep.stepsCompleted = false;
me.gettingInitialPosition = false;
me.currentAction.setState('NEXT STEP');
me.statusBusy();
me.started = true;
me.nxtStep.start();
end
