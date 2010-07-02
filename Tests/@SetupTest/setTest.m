function setTest(me,test)
me.cfg = me.hfact.cfg;
switch test
    case { 'UPPER' 'LOWER' 'INCREMENT'}
        me.genStepConfigSettings(0,0);
        me.genFakeParameters(1,0);
    case  { 'STEP' 'RAMP'}
        me.genStepConfigSettings(1,0);
        me.genFakeParameters(1,1);
    case  { 'SUBSTEPS'}
        me.genStepConfigSettings(1,1);
        me.genFakeParameters(1,1);
    otherwise
        me.log.error(dbstack, sprintf('%s not recognized',test));
end
me.genTargets(test);
me.clearAll();
for idx = 1:4
    d = 3*(idx - 1) + 1;
    for i = d: d+ 2
        me.setLimits(i,test);
    end
end
end
