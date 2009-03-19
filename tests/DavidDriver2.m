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
mdl = MDL_LBCB();

%Run initialization function for LBCB 1:
mdl.ElastDef.Lbcb1 = ResetElastDefState(mdl.ElastDef.Lbcb1,...
    mdl.ExtTrans.Config.Lbcb1.NumSensors);
config = mdl.ExtTrans.Config.Lbcb1;
state = mdl.ElastDef.Lbcb1;
params = mdl.ExtTrans.Config.Params;
% Need to update config.Lbcb1.Base (apply translation of Lbcb)
%                config.Lbcb1.Plat (apply rotation of Lbcb)
state = initElastDef(config.NumSensors);
state = InitExtTrans2Cartesian(config,state);


CentroidLocation = zeros(1,8);
index = size(LBCB1Readings);
index = index(1);
for i = 1:index
        
    %Run the program to get motion:
    [LbcbDisp state] = ExtTrans2Cartesian(config,state,params,LBCB1Readings(i,3:5)');
    CentroidLocation = [CentroidLocation; LBCB1Readings(i,1:2), LbcbDisp'];
    state = ResetElastDefState(state,config.NumSensors);
    
end
CentroidLocation(1,:) = [];

%Location of centroid with start as origin:
CentroidStringsLBCB1 = Cumulative(CentroidLocation);

%Compare accuracy with actual displacements:
CentLocationFromStrings = CentroidStringsLBCB1(:,2:4)
index = size(CentroidLBCB1);
index = index(1);
Given = CentroidLBCB1(2:index,2:4)