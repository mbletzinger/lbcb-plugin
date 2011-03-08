% generate a new LbcbStep based on the current step
function coupledWallDdCalculate(me,cstep)
% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = cstep.lbcbCps{2}.response.force(1);
lbcb1Fz = cstep.lbcbCps{1}.response.force(3);
lbcb2Fz = cstep.lbcbCps{2}.response.force(3);
lbcb1My = cstep.lbcbCps{1}.response.force(5);
lbcb2My = cstep.lbcbCps{2}.response.force(5);

kfactor = me.getCfg('kfactor');
Fztarget = me.getCfg('Fztarget');
dxlbcb1 = me.getCfg('dxlbcb1');
dxlbcb2 = me.getCfg('dxlbcb2');

% Calculating target moment move to calculate function
Fxtot = lbcb1Fx + lbcb2Fx;
Mytar = Fxtot*kfactor;

% Calculating Fz error
Fzerr = Fztarget - lbcb1Fz - lbcb2Fz;

% Correcting Fz error
Fz1tar = lbcb1Fz + Fzerr/2;
Fz2tar = lbcb2Fz + Fzerr/2;

% Calculating My error
MyMy = lbcb1My + lbcb2My;   % Moment from individual pier bending
MyFz = -dxlbcb1*Fz1tar - dxlbcb2*Fz2tar;    % Moment from axial loading
Myerr = Mytar - MyMy - MyFz;

% Correcting My error
Fz1tar = Fz1tar + Myerr/(2*dxlbcb1);
Fz2tar = Fz2tar + Myerr/(2*dxlbcb2);

me.putDat('Fz1tar',Fz1tar);
me.putDat('Fz2tar',Fz2tar);
me.putArch('Fx total',Fxtot);
me.putArch('My target',Mytar);
me.log.debug(dbstack, sprintf('Fx Corrections %s\n',me.dat2String()));
me.log.debug(dbstack, sprintf('Total Force %s\n',me.arch2String()));
end
