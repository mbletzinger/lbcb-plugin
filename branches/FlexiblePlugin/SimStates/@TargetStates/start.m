function start(me,stepNumber)
me.currentAction.setState('INITIAL POSITION');
me.inF.sIdx = stepNumber;
me.startStep = stepNumber;
me.stpEx.getInitialPosition();
end
