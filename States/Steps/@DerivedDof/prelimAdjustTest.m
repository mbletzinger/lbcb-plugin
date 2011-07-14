function prelimAdjustTest(me,step)
me.log.debug(dbstack,sprintf('Prelim Adjusting DD%d',me.level));
interval = .001 * level;
label = sprintf('DD%dcurStep',me.level);
dir = rem(me.getArch(label),2);
if dir > 0
    interval = -interval;
end

for lbcb = 1: cdp.numLbcbs()
    dx = step.lbcbCps{lbcb}.command.disp(1);
    step.lbcbCps{lbcb}.command.disp(1) = dx + interval;
end
end
