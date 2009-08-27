function dd = getDD(me) 
% Varibles to be loaded at beginning; will never change during test:
dxlbcb1 = 5.5;      % Distance from wall center to right pier center
dxlbcb2 = -5.5;     % Distance from wall center to left pier center

% Varibles to read in from interface; may change during test:
% % kfactor
% % Fztarget
kfactor = -25;  % temporary hard-coded values
Fztarget = 250; % temporary hard-coded values


% Defining local varbiables from me structure
lbcb1Fx = me.nextStepData.lbcbCps{1}.response.force(1);
lbcb2Fx = me.nextStepData.lbcbCps{2}.response.force(1);
lbcb1Fz = me.nextStepData.lbcbCps{1}.response.force(3);
lbcb2Fz = me.nextStepData.lbcbCps{2}.response.force(3);
lbcb1My = me.nextStepData.lbcbCps{1}.response.force(5);
lbcb2My = me.nextStepData.lbcbCps{2}.response.force(5);

% Calculating target moment
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
Fz2tar = Fz1tar + Myerr/(2*dxlbcb2);

dd = [Fz1tar; Fz2tar];

