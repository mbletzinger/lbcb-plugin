function steps = splitTarget(me)
steps = Substeps();
stp = me.dat.curStepTgt2Step();
steps.steps = { stp };
sn = me.dat.curStepTgt.stepNum.step;
if me.cdp.doStepSplitting == false
    me.setCorrectionFlag(stp);
    me.setTriggeringFlag(stp,true);
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
numSteps = abs(finalDisp - initialDisp) ./ stpSize;
str='';
for z = 1 : length(initialDisp)
    str = sprintf('%s %d',str,initialDisp(z));
end
fstr = '';
for z = 1 : length(finalDisp)
    fstr = sprintf('%s %d',fstr,finalDisp(z));
end
me.log.debug(dbstack,sprintf('Initial disp [%s]',str,fstr));
me.log.debug(dbstack,sprintf('Final disp [%s]',fstr));
maxNumSteps = max(ceil(numSteps));
me.log.debug(dbstack,sprintf('Maximum substeps is %d',maxNumSteps));
if maxNumSteps < 2
    me.setCorrectionFlag(stp);
    me.setTriggeringFlag(stp,true);
    return;
end
inc = (finalDisp - initialDisp) / maxNumSteps;
str='';
for z = 1 : length(inc)
    str = sprintf('%s %d',str,inc(z));
end
finc = (finalForce - initialForce) / maxNumSteps;
fstr = '';
for z = 1 : length(finc)
    fstr = sprintf('%s %d',fstr,finc(z));
end
me.log.debug(dbstack,sprintf('Increments disp [%s]',str));
me.log.debug(dbstack,sprintf('Increments force [%s]',fstr));
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
    me.setTriggeringFlag(ss{i}, (i == maxNumSteps));
    
end
steps.steps = ss;
me.log.info(dbstack,sprintf('Created %d substeps',length(ss)));
end
