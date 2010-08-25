function coupledWallEdPrelimAdjust(me,curStep, nextStep)

targetL = nextStep.lbcbCps{1}.command.disp;
targetR = nextStep.lbcbCps{2}.command.disp;

prevOMcommandL = curStep.lbcbCps{1}.command.disp;
prevOMcommandR = curStep.lbcbCps{2}.command.disp;

positionL = curStep.lbcbCps{1}.response.ed.disp;
positionR = curStep.lbcbCps{2}.response.ed.disp;

newOMcommandL = prevOMcommandL + (targetL - positionL);
newOMcommandR = prevOMcommandR + (targetR - positionR);

nextStep.lbcbCps{1}.command.disp([1 5]) = newOMcommandL([1 5]);
nextStep.lbcbCps{2}.command.disp([1 5]) = newOMcommandR([1 5]);

nextStep.lbcbCps{1}.command.setForceDof(3,me.getDat('Fz1Target'));
nextStep.lbcbCps{2}.command.setForceDof(3,me.getDat('Fz2Target'));

end