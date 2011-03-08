close all; clear all

%% Defining configuration parameters
activeDOFs = [1 3 5];   % Specify which Degrees of Freedom are being
                        %   controlled: 1-x, 2-y, 3-z, 4-rx, 5-ry, 6-rz
                        
% platten pin location
p0 = [0     0   0       % String pot end points on specimen
      -27   10  0       %   [x1 y1 z1;
      27    10  0]';    %    x2 y2 z2;...]'
% base pin location
q0 = [-80   0   0       % String point anchor points (not on specimen)
      -27   10  156     %   [x1 y1 z1;
      27    10  156]';  %    x2 y2 z2;...]'

% Acceptable error for string length calculations vector of string pots
sp_tol = 0.00001;           % String pot tolerance parameter

% save for later
weight = 0.5;   %Predictive ED compensation weighting factor; between 0 & 1
EDlosses = [0.75  1  0.5  1  0.95  1]'; % LBCB motion multiplier to account for
                                        %   elastic deformation losses.

% Create input file
d_targets = [0        0     0       0   0           0
             0        0     0.25    0   0           0
             0.1      0     0.15    0   7.62e-3     0
             0.1      0     0.15    0   7.62e-3     0
             0.5      0     0.05    0   3.5e-2      0
             0        0     0       0   0           0
             -10      0     -1      0   -7.62e-2    0
             10       0     1       0   7.62e-2     0
             0        0     0       0   0           0];
       
     