function genLimitTargets(me, idx, isUpper,numSteps)
d = 3*(idx - 1) + 1;
m = me.getMultiplier(d);
min = me.minV *m;
max = me.maxV *m;
itv = (max - min) / numSteps;
if isUpper
    start = min +  2 * itv;
    inc = itv;
else
    start = max - 2 * itv;
    inc = -itv;
end
me.log.debug(dbstack,sprintf('d=%d start=%f inc=%f',d,start,inc));
for i = d: d + 2
    me.cDofs(1,i) = 1;
    me.cDofs(1,i+12) = 1;
    for s = 1:numSteps
        me.tgts(s,i) = start + s * inc;
        me.tgts(s,i+12) = start + s * inc;
    end
end
end
