function jmsg = generateProposeMsg(me)
lgth = length(me.lbcb.command);
mdl = cell(lgth,1);
cps = cell(lgth,1);
contents = cell(lgth,1);
for t = 1:lgth
    mdl(t) = command(t).node;
    cps(t) = command(t).cps;
    contents(t) = command(t).createMsg();
end
jmsg = LbcbStep.getMdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
end
