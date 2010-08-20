function coupledWallEdPrelimAdjust(me,curStep, nextStep)

targetL = nextStep.lbcbCps{1}.command.disp;
targetR = nextStep.lbcbCps{2}.command.disp;

% for i = 1:6
%     me.putDat(['LeftTargets' num2str(i)],nextStep.lbcbCps{1}.command.disp(i));
%     me.putDat(['RightTargets' num2str(i)],nextStep.lbcbCps{2}.command.disp(i));
% end

prevOMcommandL = curStep.lbcbCps{1}.command.disp;
prevOMcommandR = curStep.lbcbCps{2}.command.disp;

positionL = curStep.lbcbCps{1}.response.ed.disp;
positionR = curStep.lbcbCps{2}.response.ed.disp;

newOMcommandL = prevOMcommandL + (targetL - positionL);
newOMcommandR = prevOMcommandR + (targetR - positionR);

nextStep.lbcbCps{1}.command.disp([1 5]) = newOMcommandL([1 5]);
nextStep.lbcbCps{2}.command.disp([3 5]) = newOMcommandR([3 5]);

nextStep.lbcbCps{1}.command.setForceDof(3,me.getDat('Fz1Target'));
nextStep.lbcbCps{2}.command.setForceDof(1,me.getDat('Fz2Target'));

end