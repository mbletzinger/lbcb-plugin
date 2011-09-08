function testDd0PrelimAdjust(me)
dat = me.dat;
step = dat.nextStepData;
% dat is the SimSharedData class where the data is as follows at this point
% in time:
% dat.nextStepData is the next substep derived from the input file or UISimCor
% dat.curStepData is the command that was just sent
% dat.prevStepData is the command that was sent two commands ago
% dat.curStepTgt is the current input step from the input file or UISimCor
% dat.prevStepTgt is the previous input step from the input file or UiSimCor
% dat.curSubstepTgt is the current sub step with no adjustments
% dat.prevSubstepTgt is the previous sub step with no adjustments
% dat.correctionTarget is the current target that ED was adjusted to

dx = step.lbcbCps{1}.command.disp(1);
step.lbcbCps{1}.command.setDispDof(1,dx + 0.000222);    
end