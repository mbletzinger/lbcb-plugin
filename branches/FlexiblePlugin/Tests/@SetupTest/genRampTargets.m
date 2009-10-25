function genRampTargets(me,halfSteps)
me.cDofs = ones(1,24);
for i = 1:6
    m = me.getMultiplier(i);
    min = me.minV *m;
    max = me.maxV *m;
    inc = (max - min) / halfSteps * 2;
    middle = (max - min) / 2;
    fm = me.getMultiplier(i + 6);
    fmin = me.minV *fm;
    fmax = me.maxV *fm;
    finc = (fmax - fmin) / halfSteps * 2;
    fmiddle = (fmax - fmin) / 2;
    me.log.debug(dbstack,sprintf('d=%d middle=%f inc=%f',i,middle,inc));
    for s = 0:halfSteps
        me.tgts(s+1,i) = middle + s * inc;
        peak = me.tgts(s+1,i);
        me.tgts(s+1,i+6) = fmiddle + s * finc;
        fpeak = me.tgts(s+1,i+6);
        me.tgts(s+1,i+12) = middle + s * inc;
        me.tgts(s+1,i+18) = fmiddle + s * finc;
    end
    for s = halfSteps + 1 : halfSteps * 2
        me.tgts(s,i) = peak - (s - halfSteps) * inc;
        me.tgts(s,i+6) = fpeak - (s - halfSteps) * finc;
        me.tgts(s,i+12) = peak - (s - halfSteps) * inc;
        me.tgts(s,i+18) = fpeak - (s - halfSteps) * finc;
    end
end
end
