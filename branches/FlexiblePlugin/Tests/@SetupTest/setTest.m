function setTest(me,test)
switch test
    case { 'UPPER' 'LOWER' 'INCREMENT' 'RAMP'}
        me.genFakeParameters(0);
    case  'STEP'
        me.genFakeParameters(1);
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
lcfg = LogLevelsDao(me.cfg);
lcfg.cmdLevel = 'DEBUG';
ocfg = OmConfigDao(me.cfg);
ocfg.useFakeOm = 1;
sensorNames = cell(15,1);
apply2Lbcb = cell(15,1);
sensorNames(1:6,1) = {'Ext.Long.LBCB2' 'Ext.Tranv.TopLBCB2' 'Ext.Tranv.Bot.LBCB2',...
    'Ext.Long.LBCB1', 'Ext.Tranv.LeftLBCB1' 'Ext.Tranv.RightLBCB1'}';
apply2Lbcb(1:6,1) = {'LBCB2' 'LBCB2' 'LBCB2' 'LBCB1' 'LBCB1' 'LBCB1'}';
ocfg.sensorNames = sensorNames;
ocfg.apply2Lbcb = apply2Lbcb;
ocfg.numLbcbs = 2;
me.genStepConfigSettings();
end
