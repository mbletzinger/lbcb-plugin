% generate a new LbcbStep based on the current step
function steelFrameDd1Calculate(me,cstep)
step = cstep.stepNum.step;
if step == 0
    me.putDat('dd1Flag',0);
end

% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = -cstep.lbcbCps{2}.response.force(3);
lbcb1Dx = cstep.lbcbCps{1}.response.disp(1);
lbcb2Dx = -cstep.lbcbCps{2}.response.disp(3);

% Calculating shear load differential
dF = lbcb2Fx - lbcb1Fx;
dFTar = me.getCfg('dFTar');

% Calculating dF error
dFError = dFTar - dF;

%% Updating k_dF based on step data or change in user settings
kCfgNew = me.getCfg('k_dF');
k_dF = kCfgNew;
if step > 1
    kCfgOld = me.getDat('kCfgOld');
    k_dF = me.getArch('k_dF');
    
    if me.getDat('dd1Flag') == 1
        dFOld = me.getDat('dFOld');
        ddxOld = me.getArch('ddx');
        kStep = (dF - dFOld)/ddxOld;
        if kStep > 0
            k_dF = (k_dF + kStep)/2;
        end
    end
    
    if kCfgNew ~= kCfgOld
        k_dF = kCfgNew;
    end
end

%% Calculating required correction step, ddx
ddx = dFError/k_dF;

me.putArch('ddx',ddx);
me.putArch('k_dF',k_dF);
me.putArch('dFError',dFError);
me.putDat('dFOld',dF);
me.putDat('dd1Flag',0);
me.putDat('kCfgOld',kCfgNew);
end
