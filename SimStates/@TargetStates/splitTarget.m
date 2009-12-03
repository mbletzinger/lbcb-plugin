function steps = splitTarget(me)
steps = Substeps();
if me.cdp.doStepSplitting == false
    me.setCorrectionFlag(me.dat.curTarget);
    steps.steps = { me.dat.curTarget };
    return;
end
stpSize = ones(24,1);  % hack around divide by zero problem
stpSize(1:6) = me.cdp.getSubstepInc(1);
stpSize(7:12) = me.cdp.getSubstepInc(0);
[ initialDisp initialDispDofs initialForce initialForceDofs ] = ...
    me.dat.prevTarget.cmdData();
[ finalDisp finalDispDofs finalForce finalForceDofs ] = ...
    me.dat.curTarget.cmdData(); %#ok<ASGLU,NASGU>
numSteps = (finalDisp - initialDisp) / stpSize;
[m, maxNumSteps] = max(numSteps); %#ok<ASGLU>
inc = (finalDisp - initialDisp) / maxNumSteps;
finc = (finalForce - initialForce) / maxNumSteps;
ss = cell(maxNumSteps,1);
disp = initialDisp;
force = intialForce;
for i = 1 : maxNumSteps
    prevDisp = disp;
    prevForce = force;
    disp = prevDisp + inc;
    force = prevForce + finc;
    tgts{1}.disp = disp(1:6); %#ok<*AGROW>
    tgts{1}.dispDofs = initialDispDofs(1:6);
    tgts{1}.force = force(1:6);
    tgts{1}.forceDofs = initialForceDofs(1:6);
    if cdp.numLbcbs > 1
        tgts{2}.disp = disp(7:12);
        tgts{2}.dispDofs = initialDispDofs(7:12);
        tgts{2}.force = force(7:12);
        tgts{2}.forceDofs = initialForceDofs(7:12);
    end
    ss{i} = me.sdf.target2StepData(tgts);
    me.setCorrectionFlag(ss{i});
    
end
steps.steps = ss;
end
