function genRampTargets(me,idx,halfSteps)
me.cDofs = ones(1,24);
d = 3*(idx - 1) + 1;
m = me.getMultiplier(d);
min = me.minV *m;
max = me.maxV *m;
inc = (max - min) / halfSteps * 2;
middle = (max - min) / 2;
for i = d:d+2
    me.log.debug(dbstack,sprintf('d=%d middle=%f inc=%f',d,middle,inc));
    for s = 0:halfSteps
        me.tgts(s+1,i) = middle + s * inc;
        peak = me.tgts(s+1,i);
        me.tgts(s+1,i+12) = middle + s * inc;
    end
    for s = halfSteps + 1 : halfSteps * 2
        me.tgts(s,i) = peak - (s - halfSteps) * inc;
        me.tgts(s,i+12) = peak - (s - halfSteps) * inc;
    end
end
end
