function steps = splitTarget(me)
steps = Substeps();
steps.steps = { me.dat.curTarget };
sn = me.dat.curTarget.stepNum.step;
if me.cdp.doStepSplitting == false
    me.setCorrectionFlag(me.dat.curTarget);
    return;
end
stpSize = ones(12,1);  % hack around divide by zero problem
stpSize(1:6) = me.cdp.getSubstepInc(1).disp;
stpSize(7:12) = me.cdp.getSubstepInc(0).disp;
[ initialDisp initialDispDofs initialForce initialForceDofs ] = ...
    me.dat.prevTarget.cmdData(); %#ok<NASGU,ASGLU>
[ finalDisp finalDispDofs finalForce finalForceDofs ] = ...
    me.dat.curTarget.cmdData();
% numSteps = abs(finalDisp - (initialDisp & finalDispDofs)) ./ stpSize;
numSteps = abs(finalDisp - initialDisp) ./ stpSize;
maxNumSteps = max(ceil(numSteps));
if maxNumSteps < 2
    me.setCorrectionFlag(me.dat.curTarget);
    return;
end
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
    ss{i} = me.sdf.target2StepData(tgts,sn,i);
    me.setCorrectionFlag(ss{i});
    
end
steps.steps = ss;
me.log.info(dbstack,sprintf('Created %d substeps',length(ss)));
end
