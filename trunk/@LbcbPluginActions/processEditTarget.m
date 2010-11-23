function processEditTarget(me)
if isempty(me.hfact.dat.curStepTgt)
    me.log.error(dbstack,'Cannot edit a non-existent target');
    return;
end
targets = { me.hfact.dat.curStepTgt.lbcbCps{1}.command,...
    me.hfact.dat.curStepTgt.lbcbCps{2}.command };
EditTarget('targets',targets);
me.hfact.prcsTgt.edited();
end