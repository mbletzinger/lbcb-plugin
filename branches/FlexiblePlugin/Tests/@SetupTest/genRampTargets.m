function genRampTargets(me,halfSteps)
m = me.getMultiplier(d);
min = me.minV *m;
max = me.maxV *m;
inc = (max - min) / halfSteps * 2;
start = min +  2 * inc;
me.log.debug(dbstack,sprintf('d=%d start=%f inc=%f',d,start,inc));
for i = 1:6
    me.cDofs(1,i) = 1;
    me.cDofs(1,i+12) = 1;
    for s = 1:halfSteps
        me.tgts(s,i) = start + s * inc;
        me.tgts(s,i+12) = start + s * inc;
    end
    for s = halfSteps : halfSteps * 2
        me.tgts(s,i) = start - s * inc;
        me.tgts(s,i+12) = start - s * inc;
    end
end
end
