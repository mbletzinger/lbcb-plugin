function transformResponse(me)
if me.cdp.numModelCps() == 0
    return;
end
tcfg = TargetConfigDao(me.cdp.cfg);
xform = str2func(tcfg.lbcb2SimCorFunction);
lbcbTgts = cell(me.cdp.numLbcbs(),1);

for l = 1 : me.cdp.numLbcbs()
    lbcbTgts{l} = me.lbcbCps{l}.command.clone();
    lbcbTgts{l}.reading2Target(me.lbcbCps{l}.response);
end

mdlTgts = xform(me,lbcbTgts);
for m = 1 : me.cdp.numModelCps() 
    me.modelCps{m}.response = mdlTgts{m} ;
end
me.containsModelCps = 1;
end