function updateStepTolerances(me)
stp = me.hfact.dat.curStepData;
if isempty(stp)
    return;
end
me.log.debug(dbstack,sprintf('Updating tolerances for step %s',stp.stepNum.toStringD(' ')));
me.tolerances.setStep(stp);
me.tolerances.setTarget(me.hfact.dat.correctionTarget);
me.tolerances.fill();
end