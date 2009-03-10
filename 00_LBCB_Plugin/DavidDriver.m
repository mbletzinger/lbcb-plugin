clear all

%Run configuration function:
config = configExternalTransducers();

%Run initialization function for LBCB 1:
init = initExternalTransducers(config.Lbcb1.NumSensors,config.Lbcb2.NumSensors);

%Build state function:
State = InitExtTrans2Cartesian(config.Lbcb1,init.State);

%Input measurments:
B = [186.3891  137.8032   88.4985]';
A = [218.1349 146.1219 127.8625]';
State.Readings = A - B;
%State.LengthInc = State.Readings - State.Lengths;

%Run the program to get motion:
[LbcbDisp State] = ExtTrans2Cartesian(config.Lbcb1,State,config.Params)