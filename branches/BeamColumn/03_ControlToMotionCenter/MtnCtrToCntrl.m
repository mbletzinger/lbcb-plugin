function [d1,d2,d3] = MtnCtrToCntrl(D1,D2,D3)

% Bugs: Node 2 will return an "incorrect" value, since it's referrence
% angle is pi/2.  Need to add this in, depending on what the referrence
% angle that is chosen.

%D1 = [    0     0     0];
%D2 = [ -6.2837  191.9196         0         0         0    1.6057];
%D3 = [ 68.5617  121.2150         0         0         0    0.0175];
%d1 = [-.6667 0 1.5882496];

d1 = [175.7487 52.8846 2.26961];
D2 = [-0.0008  192.0000         0         0         0    1.5708];
D3 = [71.9995  120.0003         0         0         0    0.0000];


% Programmed by David J. Bennier
% Revised 02 13 09
%
% Purpose:
%   Transform LBCB motion centers (6 DOF) into Simcor control points (3
%   DOF).  Two LBCB motion center coordinates are transformed, through
%   rigid body translation and rotation of the beam-column, into three
%   Simcor control points.  Note that the translation and rotation depend
%   upon the coordinates of Node 1 in Simcor.
%
% Definitions:
%   Control point: node where the substructure interacts with the
%     structure in the modeling software.
%   Motion center: origin of the LBCB's motion.
%   Node 1: base of column
%   Node 2: top of column
%   Node 3: tip of beam
%
% Input:
%   Control points for Node 1, as given by Abacus
%   Motion centers for Nodes 2 and 3, as measured by the external sensors
%
% Output:
%   Control points for Nodes 2 and 3, to be returned to Abacus
%
% Library of variables:
%   d1 - Node 1 in control point coordinates (x, y, rz)
%   d2 - Node 2 in control point coordinates (x, y, rz)
%   d3 - Node 3 in control point coordinates (x, y, rz)
%   D1 - Node 1 in motion center coordinates (x, y, z, rx, ry, rz)
%   D2 - Node 2 in motion center coordinates (x, y, z, rx, ry, rz)
%   D3 - Node 3 in motion center coordinates (x, y, z, rx, ry, rz)
%   R12 - Vector pointing from Node 1 to Node 2 (motion center coord.)
%   R13 - Vector pointing from Node 1 to Node 3 (motion center coord.)
%   T - Rotation matrix; function of rotation at Node 1 in control point
%     coord., with reference to the vertical orientation of the column
%   r12 - R12 rotated by T
%   r13 - R13 rotated by T
%   R_rgd - Rigid body rotation

% Define position vectors in terms of motion center coordinates:

R12 = D2(1:2); % Since D1 is assumed to be zeros
R13 = D3(1:2); % Since D1 is assumed to be zeros

% Define rigid body motion, assuming vertical as the reference LBCB
% coordinate:

R_rgd = pi/2 - d1(3);

T = [cos(R_rgd) sin(R_rgd); -sin(R_rgd) cos(R_rgd)];

r12 = T*R12';
r13 = T*R13';

% Initialize Nodes 2 and 3 in control point coordinates:

d2 = zeros(1,3);
d3 = zeros(1,3);

% Transform Nodes 2 and 3 into control point coordinates, accounting for
% rigid body translation and rotation:

d2(1:2) = D2(1:2) + d1(1:2) + r12' - R12;
d2(3) = D2(3) - R_rgd;

d3(1:2) = D3(1:2) + d1(1:2) + r13' - R13;
d3(3) = D3(3) - R_rgd;