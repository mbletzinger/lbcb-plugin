function steelFrameDd1PrelimAdjustOld(me,curStep, nextStep)

ddx = me.getArch('ddx');

lbcb1DxCommand = nextStep.lbcbCps{1}.command.disp(1) - ddx;
lbcb2DxCommand = nextStep.lbcbCps{2}.command.disp(3) - ddx;

% nextStep.lbcbCps{1}.command.setDispDof(1,lbcb1DxCommand);
% nextStep.lbcbCps{2}.command.setDispDof(3,lbcb2DxCommand);

end