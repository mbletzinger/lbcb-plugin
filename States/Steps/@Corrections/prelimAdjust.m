function prelimAdjust(me,curStep, nextStep)
me.dd.prelimAdjust();
for l = 1:me.cdp.numLbcbs()
    me.ed{l}.prelimAdjust(curStep, nextStep);
end
end
