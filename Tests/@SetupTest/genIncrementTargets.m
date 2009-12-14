function genIncrementTargets(me, idx,numSteps)
d = 3*(idx - 1) + 1;
m = me.getMultiplier(d);
itv = me.maxW * m / (numSteps - 2);
start = 1; % Determined by what the fake OM generates for the initial position
me.log.debug(dbstack,sprintf('d=%d start=%f itv=%f',d,start,itv));
for i = d: d + 2
    me.cDofs(1,i) = 1;
    me.cDofs(1,i+12) = 1;
    dsp = start;
    frc = start;
    for s = 1:numSteps
        me.tgts(s,i) = dsp;
        me.tgts(s,i+12) = frc;
        dsp = dsp + s*itv;
        frc = frc + s*itv;
        %                    dsp - me.tgts(s,i)
    end
end
end
