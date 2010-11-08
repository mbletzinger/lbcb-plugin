function transformResponse(me)
if me.cdp.numModelCps() == 0
    return;
end
tcfg = TargetConfigDao(me.cdp.cfg);
xform = str2func(tcfg.lbcb2SimCorFunction);
lbcbTgts = cell(me.cdp.numLbcbs(),1);

lbcbTgts{1} = me.lbcbCps{1}.command.clone();
lbcbTgts{1}.reading2Target(me.lbcbCps{1}.response);
if me.cdp.numLbcbs() > 1
    lbcbTgts{2} = me.lbcbCps{2}.command.clone();
    lbcbTgts{2}.reading2Target(me.lbcbCps{2}.response);
end

mdlTgts = xform(me,lbcbTgts);
for m = 1 : me.cdp.numModelCps() 
    me.modelCps{m}.response = mdlTgts{m};
end
me.containsModelCps = 1;
end