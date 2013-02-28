% generate a new LbcbStep based on the current step
function steelFrameDd0Calculate(me,cstep)
% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = cstep.lbcbCps{2}.response.force(1);
lbcb1Fz = cstep.lbcbCps{1}.response.force(3);
lbcb2Fz = cstep.lbcbCps{2}.response.force(3);
lbcb1My = cstep.lbcbCps{1}.response.force(5);
lbcb2My = cstep.lbcbCps{2}.response.force(5);

kFactor = me.getCfg('kFactor');
FzBaseTarget = me.getCfg('FzTarget');
dxLbcb1 = me.getCfg('dxLbcb1');
dxLbcb2 = me.getCfg('dxLbcb2');

% Calculating target axial load
FxTotal = lbcb1Fx + lbcb2Fx;
FzTarget = FzBaseTarget + FxTotal*2;

% Calculating Fz error
FzError = FzTarget - lbcb1Fz - lbcb2Fz;

% Correcting Fz error
Fz1Target = FzTarget*0.8;
Fz2Target = FzTarget*0.2;

% Calculating My
MyMy = lbcb1My + lbcb2My;   % Moment from individual pier bending
MyFz = -dxLbcb1*lbcb1Fz - dxLbcb2*lbcb2Fz;    % Moment from axial loading
MyTotal = MyMy + MyFz;

me.putDat('Fz1Target',Fz1Target);
me.putDat('Fz2Target',Fz2Target);
me.putArch('Fx total',FxTotal);
% me.putArch('MyTarget',MyTarget);
me.putArch('My total',MyTotal);
me.putDat('FzError',FzError);
me.log.debug(dbstack, sprintf('Fx Corrections %s\n',me.dat2String()));
me.log.debug(dbstack, sprintf('Total Force %s\n',me.arch2String()));
end
