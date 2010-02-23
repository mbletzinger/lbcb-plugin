function transformCommand(me)
if me.cdp.numModelCps() == 0
    return;
end
tcfg = TargetConfigDao(me.cdp.cfg);
xform = str2func(tcfg.simCor2LbcbFunction);
mdlTgts = cell(me.cdp.numModelCps(),1);
for m = 1 : me.cdp.numModelCps()
    mdlTgts{m} = me.modelCps{m}.command;
end
lbcbTgts = xform(me,mdlTgts);
for l = 1 : me.cdp.numLbcbs()
    me.lbcbCps{l}.command = lbcbTgts{l};
end
me.containsModelCps = 1;
end