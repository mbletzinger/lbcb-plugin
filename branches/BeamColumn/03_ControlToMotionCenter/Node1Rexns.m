function [F1] = Node1Rexns (D1,D2,D3,F2,F3)

% Purpose:
%   Solves for the reactions at the base of the column (Node 1), given the
%   LBCB force readings at Nodes 2 and 3 (the column top and beam tip,
%   respectively).  At conclusion of algorithm, reactions at Nodes 1, 2 and
%   3 are known, in LBCB motion center coordinates.
%
% Programmer:
%   David J. Bennier
%
% Date modified:
%   02.13.09
%
% Input:
%   D1, D2, D3 - Coordinates of nodes in motion center coordinates
%   F2, F3 - Nodal reactions measured by LBCBs in motion center coordinates
%
% Output:
%   F1 - Nodal reaction at base of column
%
% Library of variables:
%   D1, D2, D3 - Coordinates of nodes in motion center coordinates; Di =
%       [x, y, rz]
%   F1, F2, F3 - Reactions at nodes; Fi = [Rx, Ry, Mz]
%   r12, r13 - vectors pointing from D1 to D2 and D1 to D3, respectively
%   tempF2, tempF3, tempCross - temporary storage vectors to perform cross
%       product

% Initialize F1:

F1 = zeros(1,3);

% Apply sum of forces in x direction to obtain F1(1) - reaction in x:

F1(1) = -F2(1) - F3(1);

% Sum of forces in y direction to obtain F1(2) - reaction in y:

F1(2) = -F2(2) - F3(2);

% Determine moment arms for summing moments:

r12 = D2(1:2) - D1(1:2);
r13 = D3(1:2) - D1(1:2);

% To implement cross product, have to add third dimension to vectors (i.e.
% add the zero z direction)

tempF2 = zeros(1,3);
tempF3 = zeros(1,3);


tempF2(1:2) = F2(1:2);
tempF3(1:2) = F3(1:2);

r12 = [r12 0];
r13 = [r13 0];


% Take sum of moments to determin moment reaction, F1(3):

tempCross = cross(r12,tempF2)+cross(r13,tempF3);
F1(3) = -(tempCross(3)+F2(3)+F3(3));

clear tempF2 tempF3 tempCross

% End.

% Test numbers:
%D1 = [0 0 0];
%D2 = [0 15 0];
%D3 = [5 10 0];
%F2 = [-10 20 -4];
%F3 = [15 -50 6];