function jmsg = generateProposeMsg(me)
lgth = me.numLbcbs();
mdl = cell(lgth,1);
contents = cell(lgth,1);
for t = 1:lgth
    mdl{t} = me.getAddress();
    contents{t} = me.lbcbCps{t}.command.createMsg();
end
cps = {'LBCB1' 'LBCB2' };
jmsg = me.mdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
end
