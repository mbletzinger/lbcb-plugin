function [D1,D2,D3] = CntrlToMtnCtr(d1,d2,d3)

% Test values:

%d1 = [-.6667 0 1.5882496];
%d2 = [-3.6 192 1.5882496];
%d3 = [70 120 0];

d1 = [175.7487 52.8846 2.26961];
d2 = [52.2326 199.8804 2.26961];
d3 = [153.6746 191.0755 .69882];

% Transform model coordinates to test coordinates.
%
% Programmed by David J. Bennier
% Revised 02 12 09
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
%   Control point coordinates from Abacus for Nodes 1, 2, and 3.
%
% Output:
%   Motion center coordinates for Nodes 1, 2, and 3.
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

% Define position vectors in terms of model coordinates:

r12 = d2(1:2) - d1(1:2);
r13 = d3(1:2) - d1(1:2);

% Define rigid body motion, assuming vertical as the reference test
% coordinate:

R_rgd = pi/2 - d1(3);

T = [cos(R_rgd) sin(R_rgd); -sin(R_rgd) cos(R_rgd)];

R12 = T'*r12';
R13 = T'*r13';

% Initialize Nodes 1, 2, and 3 in test coordinates:

D1 = zeros(1,3);
D2 = zeros(1,3);
D3 = zeros(1,3);

% Transform Nodes 2 and 3 into test coordinates, accounting for relative
% translation and rotation:

D2(1:2) = d2(1:2)-d1(1:2)+R12'-r12;
D2(3) = d2(3)+R_rgd;

D3(1:2) = d3(1:2)-d1(1:2)+R13'-r13;
D3(3) = d3(3)+R_rgd;

% Convert to 6 DOF for LBCB.  Assume zeros for other DOF.

D2 = [D2(1) D2(2) 0 0 0 D2(3)];
D3 = [D3(1) D3(2) 0 0 0 D3(3)];