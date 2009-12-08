function processEditTarget(me)
targets = { me.hfact.curTarget.lbcbCps{1}.command,...
    me.hfact.curTarget.lbcbCps{2}.command };
EditTarget('targets',targets);
end