function transformResponse(me)
tcfg = TargetConfigDao(me.cdp.cfg);
xform = str2func(tcfg.lbcb2SimCorFunction);
xform(me);
end