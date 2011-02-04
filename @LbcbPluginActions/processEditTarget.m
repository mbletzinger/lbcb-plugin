function processEditTarget(me)
if isempty(me.hfact.dat.curStepData)
    me.log.error(dbstack,'Cannot edit a non-existent target');
    return; %#ok<UNRCH>
end
if me.hfact.cdp.numLbcbs() == 2
    targets = {me.hfact.dat.nextStepData.lbcbCps{1}.command,...
        me.hfact.dat.nextStepData.lbcbCps{2}.command};
else
    targets = { me.hfact.dat.nextStepData.lbcbCps{1}.command};
end
EditTarget('targets',targets);
me.hfact.acceptStp.edited();
end