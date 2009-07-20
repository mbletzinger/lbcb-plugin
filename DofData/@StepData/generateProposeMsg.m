function jmsg = generateProposeMsg(me)
lgth = length(me.lbcbCps);
mdl = cell(lgth,1);
cps = cell(lgth,1);
contents = cell(lgth,1);
cps = {'LBCB1','LBCB2'};
for t = 1:lgth
    mdl{t} = StepData.getAddress();
    contents{t} = me.lbcbCps{t}.command.createMsg();
end
jmsg = StepData.getMdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
end
