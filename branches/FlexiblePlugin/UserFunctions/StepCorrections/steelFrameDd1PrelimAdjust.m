function steelFrameDd1PrelimAdjust(me)

dat = me.dat;
step = dat.curSubstepTgt.stepNum.step;





% dat is the SimSharedData class where the data is as follows at this point
% in time:
% dat.nextStepData is the next substep derived from the input file or UISimCor
% dat.curStepData is the command that was just sent
% dat.prevStepData is the command that was sent two commands ago
% dat.curStepTgt is the current input step from the input file or UISimCor
% dat.prevStepTgt is the previous input step from the input file or UiSimCor
% dat.curSubstepTgt is the current sub step with no adjustments
% dat.prevSubstepTgt is the previous sub step with no adjustments
% dat.correctionTarget is the current target that ED was adjusted to

%% Getting next step displacement increment

if step == 1
    n = me.getCfg('n');
    me.putArch('n',n);
    me.putDat('nCfgOld',me.getCfg('n'));
    return;
end

newInputFileTarget1 = dat.curSubstepTgt.lbcbCps{1}.command.disp(1);
newInputFileTarget2 = dat.curSubstepTgt.lbcbCps{2}.command.disp(3);
oldInputFileTarget1 = dat.prevSubstepTgt.lbcbCps{1}.command.disp(1);
oldInputFileTarget2 = dat.prevSubstepTgt.lbcbCps{2}.command.disp(3);
correctionTarget1 = dat.correctionTarget.lbcbCps{1}.command.disp(1);
correctionTarget2 = dat.correctionTarget.lbcbCps{2}.command.disp(3);

targetIncrement1 = newInputFileTarget1 - oldInputFileTarget1;
targetIncrement2 = newInputFileTarget2 - oldInputFileTarget2;

if step > 2
    old1InputFileTarget1 = dat.prev1SubstepTgt.lbcbCps{1}.command.disp(1);
    old1InputFileTarget2 = dat.prev1SubstepTgt.lbcbCps{2}.command.disp(3);
else
    old1InputFileTarget1 = oldInputFileTarget1;
    old1InputFileTarget2 = oldInputFileTarget2;    
end

oldIncrement1 = oldInputFileTarget1-old1InputFileTarget1;
oldIncrement2 = oldInputFileTarget2-old1InputFileTarget2;

correctionIncrement1 = correctionTarget1 - oldInputFileTarget1;
correctionIncrement2 = correctionTarget2 - oldInputFileTarget2;

me.putDat('targetIncrement1',targetIncrement1);
me.putDat('targetIncrement2',targetIncrement2);

me.putDat('newInputFileTarget1',newInputFileTarget1);
me.putDat('newInputFileTarget2',newInputFileTarget1);

%% Getting change in displacements for "current step"

ddx1 = correctionIncrement1;
ddx2 = correctionIncrement2;

nCfgOld = me.getDat('nCfgOld');
nCfgNew = me.getCfg('n');
n = me.getArch('n');

if oldIncrement1 ~= 0 && oldIncrement2 ~= 0
    if correctionIncrement1~=0 && correctionIncrement2 ~= 0
        n1 = ddx1/oldIncrement1;
        n2 = ddx2/oldIncrement2;
        nStep = (n1 + n2)/2;
        n = (n + nStep)/2;
    end
end

if nCfgOld ~= nCfgNew
    n = nCfgNew;
end

dx1 = (1+n)*targetIncrement1;
dx2 = (1-n)*targetIncrement2;

dx2ry = me.getCfg('dx2ry');

% nextStep.lbcbCps{1}.command.disp(1) = origTarget1;
% nextStep.lbcbCps{1}.command.disp(5) = origTarget1*dx2ry;
% nextStep.lbcbCps{2}.command.disp(3) = -origTarget2;
% nextStep.lbcbCps{2}.command.disp(5) = -origTarget2*dx2ry;

dat.nextStepData.lbcbCps{1}.command.disp(1) = newInputFileTarget1 + correctionIncrement1;
dat.nextStepData.lbcbCps{1}.command.disp(5) = (newInputFileTarget1 + correctionIncrement1)*dx2ry;
dat.nextStepData.lbcbCps{2}.command.disp(3) = newInputFileTarget2 + correctionIncrement2;
dat.nextStepData.lbcbCps{2}.command.disp(5) = -(newInputFileTarget2 + correctionIncrement2)*dx2ry;

dat.correctionTarget = dat.nextStepData;

me.putArch('n',n);
me.putDat('nCfgOld',me.getCfg('n'));

% me.putDat('origTarget1',origTarget1);
% me.putDat('origTarget2',origTarget2);
% me.putDat('finalTarget1',origTarget1);
% me.putDat('finalTarget2',origTarget2);



% me.putDat('dd1Flag',0);

% end