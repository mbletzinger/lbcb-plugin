% calculations associated with actual v desired shear force differential
function coupledWallDd1CalculateJan13(me,cstep)

% step = cstep.stepNum.step;
% if step == 0
%     me.putDat('dd1Flag',0);
% end

% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = cstep.lbcbCps{2}.response.force(1);
lbcb1Dx = cstep.lbcbCps{1}.response.disp(1);
lbcb2Dx = cstep.lbcbCps{2}.response.disp(1);
dx = (lbcb1Dx + lbcb2Dx)/2;

%% Calculating expected shear force differential
% damageDisp = me.getCfg('damageDisp');
dFmaxFactor = me.getCfg('dFmaxFactor');
maxDisp = me.getArch('maxDisp');

if abs(dx) > maxDisp
    maxDisp = abs(dx);
    me.putArch('maxDisp',maxDisp);
end

baseShear = lbcb1Fx + lbcb2Fx;
dF = lbcb2Fx - lbcb1Fx;

dFmin = 0;
dFmax = abs(baseShear*dFmaxFactor);

dispRatio = abs(dx)/maxDisp;

dFexp = dispRatio*(dFmax - dFmin) + dFmin;
dFError = dFexp - dF;

%% Updating k_dF based on step data or change in user settings
k_dF = me.getCfg('k_dF');
% k_dF = kCfgNew;
% if step > 1
%     kCfgOld = me.getDat('kCfgOld');
%     k_dF = me.getArch('k_dF');
%     
%     if me.getDat('dd1Flag') == 1
%         dFOld = me.getDat('dFOld');
%         ddxOld = me.getArch('ddx');
%         kStep = (dF - dFOld)/ddxOld;
%         if kStep > 0
%             k_dF = (k_dF + kStep)/2;
%         end
%     end
%     
%     if kCfgNew ~= kCfgOld
%         k_dF = kCfgNew;
%     end
% end

%% Calculating required correction step, ddx
ddx = dFError/k_dF;

ddx = ddx*me.getCfg('ddxGain');

me.putArch('ddx',ddx);
me.putArch('k_dF',k_dF);
me.putArch('dFError',dFError);
me.putArch('dF Expected',dFexp);
% me.putDat('dFOld',dF);
% me.putDat('dd1Flag',0);
% me.putDat('kCfgOld',kCfgNew);

end