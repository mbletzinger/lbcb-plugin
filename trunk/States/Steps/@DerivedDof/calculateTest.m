% generate a new LbcbStep based on the current step
function calculateTest(me,cstep)
sn = cstep.stepNum;
me.log.debug(dbstack,sprintf('Calculating DD%d for step %s',me.level,sn.toString()));
label = sprintf('DD%dcurStep',me.level);
me.setArch(label,sn.step);
label = sprintf('DD%dcorStep',me.level);
me.setArch(label,sn.correctionStep);
end
