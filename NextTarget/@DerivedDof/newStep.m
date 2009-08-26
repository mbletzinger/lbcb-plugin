% generate a new LbcbStep based on the current step
function nstep = newStep(me,cstep)
% asking for trouble
targets = {cstep.lbcbCps{1}.command, cstep.lbcbCps{2}.command };
nstep = StepData('simstep',cstep.simstep.nextStep(1),'lbcb_tgts',targets);
end
