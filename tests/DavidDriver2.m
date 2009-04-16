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

% Generate test data:
df = [10 10 1]'; % = [delta x, delta y, delta rotation z]
N = 10; % Number of steps to take
[StringsLBCB1 CentroidLBCB1] = TestDataElasticDef(df, N);

LBCB1Readings = DeltaString(StringsLBCB1);

% Configure the external transducers:
[allExtTrans,lbcbGeos,params] = createExternalTransducerObjects();

%Run initialization function for LBCB 1:
state = externalTransducers2LbcbLocation(lbcbGeos{1});
state.init();
% Need to update config.Lbcb1.Base (apply translation of Lbcb)
%                config.Lbcb1.Plat (apply rotation of Lbcb)
%state = initElastDef(config.NumSensors);
%state = InitExtTrans2Cartesian(config,state);


CentroidLocation = zeros(1,8);
index = size(LBCB1Readings);
index = index(1);
for i = 1:index
        
    %Run the program to get motion:
    allExtTrans.update([LBCB1Readings(i,3:5) 0 0 0]);
    LbcbDisp = ExtTrans2Cartesian(state,params,allExtTrans.currentLengths');
    CentroidLocation = [CentroidLocation; LBCB1Readings(i,1:2), LbcbDisp'];
    state.reset();
end

CentroidLocation(1,:) = [];

%Location of centroid with start as origin:
CentroidStringsLBCB1 = Cumulative(CentroidLocation);

%Compare accuracy with actual displacements:
CentLocationFromStrings = CentroidStringsLBCB1(:,2:4)
index = size(CentroidLBCB1);
index = index(1);
Given = CentroidLBCB1(2:index,2:4)