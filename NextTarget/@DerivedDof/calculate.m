% generate a new LbcbStep based on the current step
function calculate(me,cstep)
% Defining local varbiables from me structure
lbcb1Fx = cstep.lbcbCps{1}.response.force(1);
lbcb2Fx = cstep.lbcbCps{2}.response.force(1);
lbcb1Fz = cstep.lbcbCps{1}.response.force(3);
lbcb2Fz = cstep.lbcbCps{2}.response.force(3);
lbcb1My = cstep.lbcbCps{1}.response.force(5);
lbcb2My = cstep.lbcbCps{2}.response.force(5);

% Calculating target moment move to calculate function
Fxtot = lbcb1Fx + lbcb2Fx;
Mytar = Fxtot*kfactor;

% Calculating Fz error
Fzerr = me.Fztarget - lbcb1Fz - lbcb2Fz;

% Correcting Fz error
me.Fz1tar = lbcb1Fz + Fzerr/2;
me.Fz2tar = lbcb2Fz + Fzerr/2;

% Calculating My error
MyMy = lbcb1My + lbcb2My;   % Moment from individual pier bending
MyFz = -dxlbcb1*me.Fz1tar - dxlbcb2*me.Fz2tar;    % Moment from axial loading
Myerr = Mytar - MyMy - MyFz;

% Correcting My error
me.Fz1tar = me.Fz1tar + Myerr/(2*dxlbcb1);
me.Fz2tar = me.Fz1tar + Myerr/(2*dxlbcb2);

cstep.dData.labels = {'Fx total', 'My target'};
cstep.dData.values(1) = Fxtot;
cstep.dData.values(2) = Mytar;
end
