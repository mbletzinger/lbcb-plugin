% generate a new LbcbStep based on the current step
function adjustTargetTest(me,step)
me.log.info(dbstack,sprintf('Adjusting DD%d for step %s',me.level, step.stepNum.toStringD(' ')));
interval = .00001 * me.level;
label = sprintf('DD%dcurStep',me.level);
dir = rem(me.getArch(label),2);
if dir > 0
    interval = -interval;
end

for lbcb = 1: me.cdp.numLbcbs()
    dx = step.lbcbCps{lbcb}.command.disp(1);
    step.lbcbCps{lbcb}.command.disp(1) = dx + interval;
end
end
