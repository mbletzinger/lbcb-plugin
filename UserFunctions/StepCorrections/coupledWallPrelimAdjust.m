function coupledWallPrelimAdjust(me,curStep, nextStep)

% if isempty(me)
%     disp('Crap!')
% end

targetL = nextStep.lbcbCps{1}.command.disp;
targetR = nextStep.lbcbCps{2}.command.disp;

for i = 1:6
    me.putDat(['LeftTargets' num2str(i)],nextStep.lbcbCps{1}.command.disp(i));
    me.putDat(['RightTargets' num2str(i)],nextStep.lbcbCps{2}.command.disp(i));
end

prevOMcommandL = curStep.lbcbCps{1}.command.disp;
prevOMcommandR = curStep.lbcbCps{2}.command.disp;

positionL = curStep.lbcbCps{1}.response.ed.disp;
positionR = curStep.lbcbCps{2}.response.ed.disp;

nextStep.lbcbCps{1}.command.disp = prevOMcommandL + (targetL - positionL);
nextStep.lbcbCps{2}.command.disp = prevOMcommandR + (targetR - positionR);
    
end