function jmsg = generateSimCorResponseMsg(me)
lgth = me.cdp.numLbcbs();
mdl = cell(lgth,1);
contents = cell(lgth,1);
for t = 1:lgth
    mdl{t} = me.modelCps{t}.address;
    contents{t} = me.modelCps{t}.response.createMsg();
end
jmsg = me.mdlLbcb.createCompoundCommand(mdl,{},contents);
end
