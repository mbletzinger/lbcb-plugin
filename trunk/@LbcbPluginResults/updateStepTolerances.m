function updateStepTolerances(me)
stp = me.hfact.dat.curStepData;
if isempty(stp)
    return;
end
me.log.debug(dbstack,sprintf('Updating tolerances for step %s',stp.stepNum.toStringD(' ')));
for lbcb = 1:me.hfact.cdp.numLbcbs()
me.tolerances{lbcb}.setResponse(stp.lbcbCps{lbcb}.response);
me.tolerances{lbcb}.setTarget(me.hfact.dat.correctionTarget.lbcbCps{lbcb}.command);
me.tolerances{lbcb}.fill();
end
end