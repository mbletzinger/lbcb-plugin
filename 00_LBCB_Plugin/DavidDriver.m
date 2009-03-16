clear all
clc

%Run configuration function:

config = configExternalTransducers();

%Run initialization function for LBCB 1:
init = initExternalTransducers(config.Lbcb1.NumSensors,config.Lbcb1.NumSensors);
State = InitExtTrans2Cartesian(config.Lbcb1,init.State);
    
%Upload test data:
StringsLBCB1 = (load('xonly_strings.txt'))*100;
CentroidLBCB1 = load('xonly_centroid.txt');

LBCB1Readings = DeltaString(StringsLBCB1);
CentroidLocation = zeros(1,8);
index = size(LBCB1Readings);
index = index(1);
for i = 1:index
    State.Readings = LBCB1Readings(i,3:5)';
%Run the program to get motion:
    [LbcbDisp State] = ExtTrans2Cartesian(config.Lbcb1,State,config.Params);
    CentroidLocation = [CentroidLocation; LBCB1Readings(i,1:2), LbcbDisp'];
end
CentroidLocation(1,:) = [];
IncrementCentroid = CentroidLocation
%Location of centroid with start as origin:
CentroidStringsLBCB1 = Cumulative(CentroidLocation);

%Compare accuracy with actual displacements:
CentLocationFromStrings = CentroidStringsLBCB1(:,2:4)
index = size(CentroidLBCB1);
index = index(1);
Given = CentroidLBCB1(2:index,2:4)