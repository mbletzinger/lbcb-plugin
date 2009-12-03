function transformCommand(me)
tcfg = TargetConfigDao(me.cdp.cfg);
xform = str2func(tcfg.simCor2LbcbFunction);
xform(me);
end