% generate a new LbcbStep based on the current step
function adjustTarget(me,step)
scfg = StepConfigDao(me.cdp.cfg);
ddCorrect = str2func(scfg.ddCorrectionFunction);
ddCorrect(me,step);
end
