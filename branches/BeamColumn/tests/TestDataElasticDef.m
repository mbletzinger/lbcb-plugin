% Generator for external control test data.
%
clear all
clear clc

%   Programmer: David J. Bennier
%
%   Revisions:
%       3/5/09  Created
%
%   Input:
%       li, phi             Initial length and angle of transducer wires
%       x1, x2, x3          Geometry of LBCB
%       di                  Initial position of LBCB centroid (3 dof)
%       df                  Final position of LBCB centroid (3dof)

%   Paramters:
%       N                   Number of steps from di to df

N = 10;

% Initialization numbers:
% LBCB1:
%li = [186.3891 137.8031 88.4985]';
%phi = [0.080890 1.3557 1.371767]';
x1 = -100;
x2 = -25;
x3 = 100;
di = [0 0 0]';
df = [30.5835 12.7970 0.174533]';
Plat = [185.7796 159.6276 0
        185.7796 134.6276 0
        385.7796 134.6276 0];
Base = [0 144.5045 0
        156.3667 0 0
        368.2819 47.8761 0];

% FOR LBCB 1:  
    
% Initial postition vectors from center of LBCB to LBCB pins
    R1i = x1*[cos(di(3)) sin(di(3))]';
    T = [cos(di(3)) sin(di(3))
        -sin(di(3)) cos(di(3))];
    R2i = T*[x1 x2]';
    R3i = T*[x3, x2]';

% Initial position vectors from fixed pins to LBCB pins
    r1i = Plat(1,1:2)' - Base(1,1:2)';    %li(1)*[cos(phi(1)) sin(phi(1))]';
    r2i = Plat(2,1:2)' - Base(2,1:2)';    %li(2)*[cos(phi(2)) sin(phi(2))]';
    r3i = Plat(3,1:2)' - Base(3,1:2)';    %li(3)*[cos(phi(3)) sin(phi(3))]';

% Storage vectors:
    String_Lengths_LBCB1 = [1 sqrt(dot(r1i,r1i)) sqrt(dot(r2i,r2i)) sqrt(dot(r3i,r3i))];
    Centroid = [1 di'];
    n = 1;  
    
% Increment    
dd = (df-di)/N;    
    
for i = 1:N
    n = n+1;
% RGB rotation of R1i, 2i, and 3i to R1f, 2f, and 3f
    dT = [cos(dd(3)) sin(dd(3))
        -sin(dd(3)) cos(dd(3))];
    R1f = dT'*R1i;
    R2f = dT'*R2i;
    R3f = dT'*R3i;

% Final position vector after imposing displacement vector d
    r1f = r1i(1:2) + dd(1:2) + (R1f - R1i);
    r2f = r2i(1:2) + dd(1:2) + (R2f - R2i);
    r3f = r3i(1:2) + dd(1:2) + (R3f - R3i);

% Final transducer wire lengths and rotations
    lf = [sqrt(dot(r1f,r1f)) sqrt(dot(r2f,r2f)) sqrt(dot(r3f,r3f))];
    
% Prep for next iteration
    R1i = R1f;
    R2i = R2f;
    R3i = R3f;
    r1i = r1f;
    r2i = r2f;
    r3i = r3f;
    di = di+dd;
% Store string lengths and centroid location
    String_Lengths_LBCB1 = [String_Lengths_LBCB1
                             n lf ];
    Centroid = [Centroid
        n di'];
 
% Clear variables
    clear dT R1f R2f R3f r1f r2f r3f
end