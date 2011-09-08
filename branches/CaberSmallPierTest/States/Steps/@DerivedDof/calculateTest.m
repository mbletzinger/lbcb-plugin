% generate a new LbcbStep based on the current step
function calculateTest(me,cstep)
sn = cstep.stepNum;
me.log.info(dbstack,sprintf('Calculating DD%d for step %s',me.level,sn.toStringD(' ')));
label = sprintf('DD%dcurStep',me.level);
me.putArch(label,sn.step);
label = sprintf('DD%dcorStep',me.level);
me.putArch(label,sn.correctionStep);
end
