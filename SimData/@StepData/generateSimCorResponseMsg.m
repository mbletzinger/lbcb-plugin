function jmsg = generateSimCorResponseMsg(me)
lgth = me.cdp.numLbcbs();
mdl = cell(lgth,1);
contents = cell(lgth,1);
for t = 1:lgth
    mdl{t} = me.cdp.getAddress();
    contents{t} = me.modelCps{t}.command.createMsg(me.modelCps{t}.response);
end
jmsg = me.mdlLbcb.createCompoundCommand(mdl,{},contents);
end
