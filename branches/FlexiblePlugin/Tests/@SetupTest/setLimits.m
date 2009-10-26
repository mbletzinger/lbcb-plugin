function setLimits(me,d,test)
lcfg = LimitsDao('command.limits',me.cfg);
m = me.getMultiplier(d);

icfg = WindowLimitsDao('increment.limits',me.cfg);
scfg = WindowLimitsDao('command.tolerances',me.cfg);
switch test
    case {'UPPER' 'LOWER'}
        lcfg.upper1(d) = me.maxV * m;
        lcfg.lower1(d) = me.minV * m;
        lcfg.used1(d) = 1;
        lcfg.upper2(d) = me.maxV * m;
        lcfg.lower2(d) = me.minV * m;
        lcfg.used2(d) = 1;
    case 'INCREMENT'
        icfg.window1(d) = me.maxW * m;
        icfg.used1(d) = 1;
        icfg.window2(d) = me.maxW * m;
        icfg.used2(d) = 1;
    case {'STEP' 'RAMP'}
        scfg.window1(d) = me.maxW * m;
        scfg.used1(d) = 1;
        scfg.window2(d) = me.maxW * m;
        scfg.used2(d) = 1;
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',test));
end
end
