function coupledWallDd1PrelimAdjustJan13(me)

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
DumbMethod = 1117;
if step == DumbMethod
    n = me.getCfg('n');
    me.putDat('nCfgOld',me.getCfg('n'));
    me.putDat('correctionTarget1',0);
    me.putDat('correctionTarget2',0);
    dat.nextStepData.lbcbCps{1}.command.disp(1) = dat.curStepData.lbcbCps{1}.response.lbcb.disp(1);
%     dat.nextStepData.lbcbCps{1}.command.disp(5) = dat.curStepData.lbcbCps{1}.response.lbcb.disp(5);
    dat.nextStepData.lbcbCps{2}.command.disp(1) = dat.curStepData.lbcbCps{2}.response.lbcb.disp(1);
%     dat.nextStepData.lbcbCps{2}.command.disp(5) = dat.curStepData.lbcbCps{2}.response.lbcb.disp(5);
    return;
end

%% Loading historical and current input file and correction targets
newInputFileTarget1 = dat.curSubstepTgt.lbcbCps{1}.command.disp(1);
newInputFileTarget2 = dat.curSubstepTgt.lbcbCps{2}.command.disp(1);
oldInputFileTarget1 = dat.prevSubstepTgt.lbcbCps{1}.command.disp(1);
oldInputFileTarget2 = dat.prevSubstepTgt.lbcbCps{2}.command.disp(1);
correctionTarget1 = dat.correctionTarget.lbcbCps{1}.command.disp(1);
correctionTarget2 = dat.correctionTarget.lbcbCps{2}.command.disp(1);
oldCorrectionTarget1 = me.getDat('correctionTarget1');
oldCorrectionTarget2 = me.getDat('correctionTarget2');

if step > DumbMethod + 1
    old1InputFileTarget1 = dat.prev1SubstepTgt.lbcbCps{1}.command.disp(1);
    old1InputFileTarget2 = dat.prev1SubstepTgt.lbcbCps{2}.command.disp(1);
else
    old1InputFileTarget1 = oldInputFileTarget1;
    old1InputFileTarget2 = oldInputFileTarget2;    
end

%% Operating on targets to define increments
targetIncrement1 = newInputFileTarget1 - oldInputFileTarget1;
targetIncrement2 = newInputFileTarget2 - oldInputFileTarget2;
oldIncrement1 = oldInputFileTarget1 - old1InputFileTarget1;
oldIncrement2 = oldInputFileTarget2 - old1InputFileTarget2;
correctionIncrement1 = correctionTarget1 - oldInputFileTarget1;
correctionIncrement2 = correctionTarget2 - oldInputFileTarget2;
oldCorrectionIncrement1 = oldCorrectionTarget1 - old1InputFileTarget1;
oldCorrectionIncrement2 = oldCorrectionTarget2 - old1InputFileTarget2;

%% Storing variables as needed
me.putDat('correctionTarget1',correctionTarget1);
me.putDat('correctionTarget2',correctionTarget2);
me.putDat('correctionIncrement1',correctionIncrement1); %
me.putDat('correctionIncrement2',correctionIncrement2); %
me.putDat('targetIncrement1',targetIncrement1); %
me.putDat('targetIncrement2',targetIncrement2); %
me.putDat('newInputFileTarget1',newInputFileTarget1); %
me.putDat('newInputFileTarget2',newInputFileTarget2); %

%% Getting change in displacements for "current step"
ddx1 = correctionIncrement1 - oldCorrectionIncrement1;
ddx2 = correctionIncrement2 - oldCorrectionIncrement2;


nCfgOld = me.getDat('nCfgOld');
nCfgNew = me.getCfg('n');
n = me.getArch('n');

if step > DumbMethod+1
    if oldIncrement1 ~= 0 && oldIncrement2 ~= 0
        if ddx1~=0 && ddx2 ~= 0
            n1 = -ddx1/oldIncrement1;
            n2 = ddx2/oldIncrement2;
            nStep = (n1 + n2)/2;
            n = (n + nStep)/2;
        end
    end
end
if nCfgOld ~= nCfgNew
    n = nCfgNew;
end

dx1 = -n*targetIncrement1;
dx2 = n*targetIncrement2;

% dx2ryBase = me.getCfg('dx2ryBase');
% dx2ryRedRate = me.getCfg('dx2ryRedRate');
% maxDisp = me.getArch('maxDisp');
% dx2ry = dx2ryRedRate*maxDisp + dx2ryBase;

dat.correctionTarget.lbcbCps{1}.command.disp(1) = newInputFileTarget1 + correctionIncrement1 + dx1;
% dat.correctionTarget.lbcbCps{1}.command.disp(5) = (newInputFileTarget1 + correctionIncrement1 + dx1)*dx2ry;
dat.correctionTarget.lbcbCps{2}.command.disp(1) = newInputFileTarget2 + correctionIncrement2 + dx2;
% dat.correctionTarget.lbcbCps{2}.command.disp(5) = (newInputFileTarget2 + correctionIncrement2+ dx2)*dx2ry;

dat.nextStepData.lbcbCps{1}.command.disp(1) = dat.correctionTarget.lbcbCps{1}.command.disp(1);
% dat.nextStepData.lbcbCps{1}.command.disp(5) = dat.correctionTarget.lbcbCps{1}.command.disp(5);
dat.nextStepData.lbcbCps{2}.command.disp(1) = dat.correctionTarget.lbcbCps{2}.command.disp(1);
% dat.nextStepData.lbcbCps{2}.command.disp(5) = dat.correctionTarget.lbcbCps{2}.command.disp(5);

% dat.nextStepData = dat.correctionTarget;

me.putArch('n',n);
me.putDat('nCfgOld',me.getCfg('n'));

end