% calculations associated with actual v desired shear force differential
function coupledWallDd1Calculate(me,cstep)
% Defining local varbiables from me structure
FxL = cstep.lbcbCps{1}.response.force(1);
FxR = cstep.lbcbCps{2}.response.force(1);

yieldDelta = me.getCfg('yieldDelta');
dxlbcb1 = me.getCfg('dxlbcb1');
dxlbcb2 = me.getCfg('dxlbcb2');
F1Factor = me.getCfg('F1Factor');
F2Factor = me.getCfg('F2Factor');
sideMountFactor = me.getCfg('sideMountFactor');

dx = (dxlbcb1 + dxlbcb2)/2;

maxDisp = me.getArch('maxDisp');
if abs(dx) > maxDisp
    maxDisp = abs(dx);
    me.putArch('maxDisp',maxDisp);
end

% Calculating shear differential
dF = FxR - FxL;
baseShear = (FxR + FxL)*(1+sideMountFactor);

% Calculating expected shear differential
if maxDisp < yieldDelta
    F1 = 0;
    F2 = 0;
else
    F1 = F1Factor;
    F2 = F2Factor;
end

dispRatio = abs(dx)/maxDisp;
dFmax = F1*baseShear;
dFmin = F2*baseShear;
dFexp = dispRatio*(dFmax - dFmin) + dFmin;

dFerr = dFexp - dF;

% Getting inter-pier stiffness and updating if necessary
KdF = me.getCfg('KdF');
dFFlag = me.getDat('dFFlag');

if dFFlag == 1
    olddF = me.getArch('dF');
    ddx = me.getArch('ddx');
    KdF = (KdF + (dF - olddF)/ddx)/2;
end

% getting displacement increment for dF adjustment
dxGain = me.getCfg('dxGain');
ddx = (dFerr/KdF)*dxGain;

me.putArch('dx',dx);
me.putArch('dF',dF);
me.putArch('dFexp',dFexp);
me.putArch('dFerr',dFerr);
me.putArch('ddx',ddx);
me.putDat('olddF',dF)

end