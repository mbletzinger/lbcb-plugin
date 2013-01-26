% generate a new LbcbStep based on the current step
function yes = needsCorrectionTest(me)
label = sprintf('DD%dcorStep',me.level);
yes = false;
if me.existsArch(label) == false
    return;
end
step = me.getArch(label);
yes = step <= 4  *  100^me.level;
if me.level > 0
    yes = yes && step > 4*100^(me.level - 1);
end
me.log.debug(dbstack, sprintf('Target History: \n%s',me.targetHist.toString()));
me.log.debug(dbstack, sprintf('Substep History: \n%s',me.substepHist.toString()));
me.log.debug(dbstack, sprintf('Executed Step History: \n%s',me.executeHist.toString()));
me.log.debug(dbstack,sprintf('2nd Prev = %s',me.executeHist.get(2).toString()));
end
