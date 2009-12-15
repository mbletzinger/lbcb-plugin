function processEditTarget(me)
targets = { me.hfact.dat.curTarget.lbcbCps{1}.command,...
    me.hfact.dat.curTarget.lbcbCps{2}.command };
EditTarget('targets',targets);
end