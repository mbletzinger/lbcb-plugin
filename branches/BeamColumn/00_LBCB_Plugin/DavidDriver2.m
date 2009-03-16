% Perform a series of steps to track the motion of the LBCB with string
% pots, given an initial location.  Should examine how the errors at each
% step accumulate and verify how well the motion of the platinum is
% tracked.
%
%   Programmer:     David J. Bennier
%   Revisions:      3/16/09     Created
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

% Upload test data:
%StringsLBCB1 = (load('yonly_strings.txt'))*100;
%CentroidLBCB1 = load('yonly_centroid.txt');

% Generate test data:
df = [10 10 .5]'; % = [delta x, delta y, delta rotation z]
N = 10; % Number of steps to take
[StringsLBCB1 CentroidLBCB1] = TestDataElasticDef(df, N);

LBCB1Readings = DeltaString(StringsLBCB1);

% Configure the external transducers:
config = configExternalTransducers();
% Need to update config.Lbcb1.Base (apply translation of Lbcb)
%                config.Lbcb1.Plat (apply rotation of Lbcb)

CentroidLocation = zeros(1,8);
index = size(LBCB1Readings);
index = index(1);
for i = 1:index

    % Run initialization function for LBCB 1:
    init = initExternalTransducers(config.Lbcb1.NumSensors,config.Lbcb1.NumSensors);
    State = InitExtTrans2Cartesian(config.Lbcb1,init.State);
    
    % Input the step:
    State.Readings = LBCB1Readings(i,3:5)';
    
    %Run the program to get motion:
    [LbcbDisp State] = ExtTrans2Cartesian(config.Lbcb1,State,config.Params);
    CentroidLocation = [CentroidLocation; LBCB1Readings(i,1:2), LbcbDisp'];
    
    % Update pin locations:
    config.Lbcb1.Base = config.Lbcb1.Base - [1; 1; 1]*[CentroidLocation(i+1,3:5)];
    rot = CentroidLocation(i+1,7);
    config.Lbcb1.Plat = config.Lbcb1.Plat*[cos(rot) sin(rot) 0; -sin(rot) cos(rot) 0; 0 0 1];
    
end
CentroidLocation(1,:) = [];

%Location of centroid with start as origin:
CentroidStringsLBCB1 = Cumulative(CentroidLocation);

%Compare accuracy with actual displacements:
CentLocationFromStrings = CentroidStringsLBCB1(:,2:4)
index = size(CentroidLBCB1);
index = index(1);
Given = CentroidLBCB1(2:index,2:4)