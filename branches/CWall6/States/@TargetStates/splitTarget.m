function steps = splitTarget(me)
steps = Substeps();
stp = me.dat.curStepTgt2Step();
steps.steps = { stp };
sn = me.dat.curStepTgt.stepNum.step;
if me.cdp.doStepSplitting == false
    return;
end
if me.cdp.numLbcbs() > 1
    stpSize = ones(12,1);  % hack around divide by zero problem
    stpSize(1:6) = me.cdp.getSubstepInc(1).disp;
    stpSize(7:12) = me.cdp.getSubstepInc(0).disp;
else
    stpSize = ones(6,1);  % hack around divide by zero problem
    stpSize(1:6) = me.cdp.getSubstepInc(1).disp;
end
[ initialDisp initialDispDofs initialForce initialForceDofs ] = ...
    me.dat.prevStepTgt.cmdData(); %#ok<NASGU,ASGLU>
[ finalDisp finalDispDofs finalForce finalForceDofs ] = ...
    me.dat.curStepTgt.cmdData();
% numSteps = abs(finalDisp - (initialDisp & finalDispDofs)) ./ stpSize;
for s=1:length(stpSize)
    if stpSize(s) == 0
        stpSize(s) = 1000; % use artificially large number to overcome divide by zero issue
    end
end
numSteps = abs(finalDisp - initialDisp) ./ stpSize;
maxNumSteps = max(ceil(numSteps));
if maxNumSteps < 2
    me.log.debug(dbstack,'Number of substeps is < 2');
    return;
end
me.log.debug(dbstack,sprintf('Step sizes: %s',me.dof2s(stpSize)));
me.log.debug(dbstack,sprintf('Number of substeps: %s',me.dof2s(numSteps)));
inc = (finalDisp - initialDisp) / maxNumSteps;
finc = (finalForce - initialForce) / maxNumSteps;
ss = cell(maxNumSteps,1);
disp = initialDisp;
force = initialForce;
for i = 1 : maxNumSteps
    prevDisp = disp;
    prevForce = force;
    disp = prevDisp + inc;
    force = prevForce + finc;
    tgts{1} = Target;
    tgts{1}.disp = disp(1:6); %#ok<*AGROW>
    tgts{1}.dispDofs = finalDispDofs(1:6);
    tgts{1}.force = force(1:6);
    tgts{1}.forceDofs = finalForceDofs(1:6);
    tgts{1}.clearNonControlDofs()
    if me.cdp.numLbcbs > 1
        tgts{2} = Target;
        tgts{2}.disp = disp(7:12);
        tgts{2}.dispDofs = finalDispDofs(7:12);
        tgts{2}.force = force(7:12);
        tgts{2}.forceDofs = finalForceDofs(7:12);
        tgts{2}.clearNonControlDofs()
    end
    ss{i} = me.sdf.target2StepData(tgts,sn,i-1);
end
steps.steps = ss;
me.log.info(dbstack,sprintf('Created %d substeps',length(ss)));
end
