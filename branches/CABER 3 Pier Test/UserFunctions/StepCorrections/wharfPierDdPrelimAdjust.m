function wharfPierDdPrelimAdjust(me)

dat = me.dat;
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

fudge = me.getCfg('RyOffset');
nextStep = dat.nextStepData;
ry = nextStep.lbcbCps{1}.command.disp(5);
fx = nextStep.lbcbCps{1}.command.force(1);
direction = -1;
if fx < 0
    direction = 1;
end
nextStep.lbcbCps{1}.command.disp(5) = ry + fudge * direction;
end