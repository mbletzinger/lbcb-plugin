function updateStepTolerances(me)
me.tolerances.setStep(me.hfact.dat.curStepData);
me.tolerances.setTarget(me.hfact.dat.correctionTarget);
me.tolerances.fill();
end