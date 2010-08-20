function steelFrameDd1PrelimAdjust(me)

dat = me.dat;
step = dat.curSubstepTgt.stepNum.step;

%% Getting next step displacement increment

newInputFileTarget1 = dat.curSubstepTgt.lbcbCps{1}.command.disp(1);
newInputFileTarget2 = dat.curSubstepTgt.lbcbCps{2}.command.disp(3);
oldInputFileTarget1 = dat.prevSubstepTgt.lbcbCps{1}.command.disp(1);
oldInputFileTarget2 = dat.prevSubstepTgt.lbcbCps{2}.command.disp(3);
correctionTarget1 = dat.correctionTarget.lbcbCps{1}.command.disp(1);
correctionTarget2 = dat.correctionTarget.lbcbCps{2}.command.disp(3);

targetIncrement1 = newInputFileTarget1;
targetIncrement2 = newInputFileTarget2;

if step > 1
    oldIncrement1 = me.getDat('targetIncrement1');
    oldIncrement2 = me.getDat('targetIncrement2');
    
    targetIncrement1 = newInputFileTarget1 - oldInputFileTarget1;
    targetIncrement2 = newInputFileTarget2 - oldInputFileTarget2;
    correctionIncrement1 = correctionTarget1 - newInputFileTarget1;
    correctionIncrement2 = correctionTarget2 - newInputFileTarget2;
end

me.putDat('targetIncrement1',targetIncrement1);
me.putDat('targetIncrement2',targetIncrement2);

me.putDat('newInputFileTarget1',newInputFileTarget1);
me.putDat('newInputFileTarget2',newInputFileTarget1);

%% Getting change in displacements for "current step"

finalTarget1 = 0;
finalTarget2 = 0;

if step > 1
    origTarget1 = me.getDat('origTarget1');
    origTarget2 = me.getDat('origTarget2');
    finalTarget1 = me.getDat('finalTarget1');
    finalTarget2 = me.getDat('finalTarget2');
    ddx1 = finalTarget1 - origTarget1;
    ddx2 = finalTarget2 - origTarget2;
end


if step == 1
    n = me.getCfg('n');
    me.putArch('n',n);
end

if step > 1
    nCfgOld = me.getDat('nCfgOld');
    nCfgNew = me.getCfg('n');
    n = me.getArch('n');
    
    if oldIncrement1 ~= 0 && oldIncrement2 ~= 0
        if origTarget1 ~= finalTarget1 && origTarget2 ~= finalTarget2
            n1 = ddx1/oldIncrement1;
            n2 = ddx2/oldIncrement2;
            nStep = (n1 + n2)/2;
            n = (n + nStep)/2;
        end
    end

    if nCfgOld ~= nCfgNew
        n = nCfgNew;
    end
end

dx1 = (1+n)*targetIncrement1;
dx2 = (1-n)*targetIncrement2;

origTarget1 = finalTarget1 + dx1;
origTarget2 = finalTarget2 + dx2;

dx2ry = me.getCfg('dx2ry');

nextStep.lbcbCps{1}.command.disp(1) = origTarget1;
nextStep.lbcbCps{1}.command.disp(5) = origTarget1*dx2ry;
nextStep.lbcbCps{2}.command.disp(3) = -origTarget2;
nextStep.lbcbCps{2}.command.disp(5) = -origTarget2*dx2ry;

me.putDat('origTarget1',origTarget1);
me.putDat('origTarget2',origTarget2);
me.putDat('finalTarget1',origTarget1);
me.putDat('finalTarget2',origTarget2);

me.putDat('nCfgOld',me.getCfg('n'));

% me.putDat('dd1Flag',0);

% end