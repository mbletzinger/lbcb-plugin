clear all
clc

%Run configuration function:

mdl = MDL_LBCB();

%Run initialization function for LBCB 1:
mdl.ElastDef.Lbcb1 = ResetElastDefState(mdl.ElastDef.Lbcb1,...
    mdl.ExtTrans.Config.Lbcb1.NumSensors)
config = mdl.ExtTrans.Config.Lbcb1;
state = mdl.ElastDef.Lbcb1;
params = mdl.ExtTrans.Config.Params;
%Upload test data:
StringsLBCB1 = (load('xonly_strings.txt'))*100;
CentroidLBCB1 = load('xonly_centroid.txt');

LBCB1Readings = DeltaString(StringsLBCB1);
CentroidLocation = zeros(1,8);
index = size(LBCB1Readings);
index = index(1);
for i = 1:index
    mdl.Avg = ;
%Run the program to get motion:
    [LbcbDisp state] = ExtTrans2Cartesian(config,state,params,LBCB1Readings(i,3:5)');
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