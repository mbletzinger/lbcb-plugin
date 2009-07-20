function jmsg = generateProposeMsg(me)
lgth = length(me.lbcb);
mdl = cell(lgth,1);
cps = cell(lgth,1);
contents = cell(lgth,1);
cps = {'LBCB1','LBCB2'};
for t = 1:lgth
    mdl{t} = LbcbStep.getAddress();
    contents{t} = me.lbcb{t}.command.createMsg();
end
jmsg = LbcbStep.getMdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
end
