%______________________________________________________________
%
% Function Extmesu2Cartesian takes the LBCB measurements and
% the ancillary measurements, and converts them into the model
% cartesian coordinate system
%______________________________________________________________

function [displ_model forces_model State] = ...
    Extmesu2Cartesian(ExtMeas,LBCB_disp,LBCB_force,State,Config)

% Base pins with offset for motion center considered
State.S1b_off = Config.S1b - Config.Off_MCTR;
State.S2b_off = Config.S2b - Config.Off_MCTR;

% Inital location of platform pins (end of string pot attached to the 
% specimen) with offset for motion center considered.
State.S1p_off = Config.S1p - Config.Off_MCTR;
State.S2p_off = Config.S2p - Config.Off_MCTR;	     

% String pot total lengths after movement.  Note that the external
% measurement of string pot location is zeroed out before entering this
% function.
State.S =[sqrt(sum((State.S1b_off - State.S1p_off).^2))+ExtMeas(5)
          sqrt(sum((State.S2b_off - State.S2p_off).^2))+ExtMeas(6)];

% Calculate initial X coordinates
X_initial=[(State.S1p_off(1)-State.S1b_off(1)) (State.S2p_off(1)-State.S2b_off(1))];
Y_initial=[(State.S1p_off(2)-State.S1b_off(2)) (State.S2p_off(2)-State.S2b_off(2))];

% Calculate final Y and Z coordinates
% Effectively, Z_final = (z-z_initial)+(theta_Y-theta_Y_inital)*Distance_X
% Assume Y location does not change
Z_final=[((LBCB_disp(3)-Config.LBCB_Disp(3))-(LBCB_disp(5)-Config.LBCB_Disp(5))*State.S1p_off(1))...
    ((LBCB_disp(3)-Config.LBCB_Disp(3))-(LBCB_disp(5)-Config.LBCB_Disp(5))*State.S2p_off(1))]';
Y_final=Y_initial;

% Calculate final X coordinates using Pythagorean Rule
Flat_Length=[sqrt(State.S(1)^2-Z_final(1)^2) sqrt(State.S(2)^2-Z_final(2)^2)]';
X_final=[sqrt(Flat_Length(1)^2-Y_final(1)^2) sqrt(Flat_Length(2)^2-Y_final(2)^2)]';

% Take the average of the two string pot measurements
DeltaX=(sum(X_final)-sum(X_initial))/2;

% Zero out the Load Cells

% Calculate the model space forces
Fx_force=-ExtMeas(1)-ExtMeas(3);
Fz_force=-ExtMeas(2)-ExtMeas(4);
My_force=ExtMeas(2)*Config.LC1(1)+ExtMeas(4)*Config.LC2(1);
% Moment My_force is taken about the point directly below the platform
% center at the height of the load cell pins.

% Format the output vectors
displ_model=[DeltaX (LBCB_disp(2)-Config.LBCB_Disp(2)) (LBCB_disp(3)-Config.LBCB_Disp(3)) (LBCB_disp(4)-Config.LBCB_Disp(4)) (LBCB_disp(5)-Config.LBCB_Disp(5)) (LBCB_disp(6)-Config.LBCB_Disp(6))]';
forces_model=[Fx_force (LBCB_force(2)-Config.LBCB_Frc(2)) Fz_force...
     (LBCB_force(4)-Config.LBCB_Frc(4)) My_force (LBCB_force(6)-Config.LBCB_Frc(6))]';



