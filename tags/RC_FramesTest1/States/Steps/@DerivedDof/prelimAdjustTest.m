function prelimAdjustTest(me,step)
me.log.info(dbstack,sprintf('Prelim Adjusting DD'));
interval = .0009;
label = sprintf('DD0curStep');
dir = rem(me.getArch(label),2);
if dir > 0
    interval = -interval;
end

for lbcb = 1: me.cdp.numLbcbs()
    dx = step.lbcbCps{lbcb}.command.disp(1);
    step.lbcbCps{lbcb}.command.disp(1) = dx + interval;
end
end
