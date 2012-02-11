% generate a new LbcbStep based on the current step
function coupledWallDd0Calculate(me,cstep)
% Defining local varbiables from me structure
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

% Calculating target moment move to calculate function
FxTotal = lbcb1Fx + lbcb2Fx;
MyTarget = Fxtot*kFactor;

% Calculating Fz error
FzError = FzTarget - lbcb1Fz - lbcb2Fz;

% Correcting Fz error
Fz1Target = lbcb1Fz + FzError/2;
Fz2Target = lbcb2Fz + FzError/2;

% Calculating My error
MyMy = lbcb1My + lbcb2My;   % Moment from individual pier bending
MyFz = -dxLbcb1*lbcb1Fz - dxLbcb2*lbcb2Fz;    % Moment from axial loading
MyActual = MyMy + MyFz;
MyError = MyTarget - MyActual;

% Correcting My error
Fz1Target = Fz1Target + MyError/(2*dxLbcb1);
Fz2Target = Fz2Target + MyError/(2*dxLbcb2);

me.putDat('Fz1Target',Fz1Target);
me.putDat('Fz2Target',Fz2Target);
me.putArch('Fx total',FxTotal);
me.putArch('MyTarget',MyTarget);
me.putArch('MyActual',MyActual);
me.putDat('MyError',MyError);
me.log.debug(dbstack, sprintf('Fx Corrections %s\n',me.dat2String()));
me.log.debug(dbstack, sprintf('Total Force %s\n',me.arch2String()));
end