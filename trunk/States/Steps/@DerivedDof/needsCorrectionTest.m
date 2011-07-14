% generate a new LbcbStep based on the current step
function yes = needsCorrectionTest(me)
label = sprintf('DD%dcorStep',me.level);
step = me.getArch(label);
yes = step <= 3;
end
