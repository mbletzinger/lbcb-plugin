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
end
