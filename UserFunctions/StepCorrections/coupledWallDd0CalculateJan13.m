% generate a new LbcbStep based on the current step
function coupledWallDd0CalculateJan13(me,cstep)
%% Initialization of Global Variables
if cstep.stepNum.step == 0
    me.putDat('Fz1Target', cstep.lbcbCps{1}.command.force(3));
    me.putDat('Fz2Target', cstep.lbcbCps{2}.command.force(3));
    me.putDat('My1Target', cstep.lbcbCps{1}.command.force(5));
    me.putDat('My2Target', cstep.lbcbCps{2}.command.force(5));
    me.putArch('n',me.getCfg('n'));  %%%% old?
    me.putArch('maxDisp',me.getCfg('maxDisp'));  %%%% old?
    me.putArch('My total',0);  
end

%% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = cstep.lbcbCps{2}.response.force(1);
lbcb1Fz = cstep.lbcbCps{1}.response.force(3);
lbcb2Fz = cstep.lbcbCps{2}.response.force(3);
lbcb1My = cstep.lbcbCps{1}.response.force(5);
lbcb2My = cstep.lbcbCps{2}.response.force(5);

kFactor = me.getCfg('kFactor');
FzTarget = me.getCfg('FzTarget');
dxLbcb1 = me.getCfg('dxLbcb1');
dxLbcb2 = me.getCfg('dxLbcb2');

%% Calculating current condition of system
FxTotal = lbcb1Fx + lbcb2Fx;
MyTarget = FxTotal*kFactor;
MyTotal = lbcb1My + lbcb2My -dxLbcb1*lbcb1Fz - dxLbcb2*lbcb2Fz;   % Moment from individual pier bending
MyError = MyTarget - MyTotal;

me.putArch('MyTarget',MyTarget);
me.putArch('My total',MyTotal);
me.putDat('MyError',MyError);
me.putArch('Fx total',FxTotal);
me.putArch('My Left',lbcb1My);
me.putArch('My Right',lbcb2My);
me.putArch('My Couple',-dxLbcb1*lbcb1Fz - dxLbcb2*lbcb2Fz);

%% Calculating potential force targets
lambda = me.getCfg('lambda');
dFx = MyError/lambda;

FxExp = FxTotal;
MyTotExp = MyTotal;
MyTarExp = MyTarget;
while abs(dFx) > 0.001
FxExp = FxExp + dFx;
MyTotExp = MyTarExp;
MyTarExp = FxExp*kFactor;
MyErrExp = MyTarExp - MyTotExp;
dFx = MyErrExp/lambda;
end

% Calculating target moment contributions
gammaT = me.getCfg('gammaT');
gammaC = me.getCfg('gammaC');

if FxTotal > 0
    My1Target = gammaT*MyTarExp;
    My2Target = gammaC*MyTarExp;
else
    My1Target = gammaC*MyTarExp;
    My2Target = gammaT*MyTarExp;
end

MyCouple = (MyTarExp - My1Target - My2Target);

Fz1Target = FzTarget/2 - MyCouple/(2*dxLbcb1);
Fz2Target = FzTarget/2 - MyCouple/(2*dxLbcb2);

me.putDat('Fz1Target',Fz1Target);
me.putDat('Fz2Target',Fz2Target);
me.putDat('My1Target',My1Target);
me.putDat('My2Target',My2Target);

me.log.debug(dbstack, sprintf('Fx Corrections %s\n',me.dat2String()));
me.log.debug(dbstack, sprintf('Total Force %s\n',me.arch2String()));
end
