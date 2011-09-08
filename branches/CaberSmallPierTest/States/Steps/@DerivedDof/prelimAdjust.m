function prelimAdjust(me,step,func)
if strcmp(func,'Test')
    me.prelimAdjustTest(step);
    return;
end
pAdjust = str2func(func);
pAdjust(me,step);
end
