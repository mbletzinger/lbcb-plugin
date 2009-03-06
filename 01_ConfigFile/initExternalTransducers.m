function init = initExternalTransducers(NumSensors1,NumSensors2)
init.Meas	= zeros(NumSensors1 + NumSensors2,1);      % Measured external transducers at each step
init.AvgMeas = zeros(NumSensors1 + NumSensors2,1);     % Measured external transducers at each step
init.State.StepNo               = 1;
init.Lbcb1.State.Base           = zeros(NumSensors1,3);
init.Lbcb1.State.Plat       = zeros(NumSensors1,3);
init.Lbcb1.State.Lengths        = zeros(NumSensors1,1); % Calculated string pot lengths
init.Lbcb1.State.StartLengths   = zeros(NumSensors1,1); % Calculated start lengths based on coordinates in 
                                                        % configExternalTransducers.m
init.Lbcb1.State.Platform_Ctr   = zeros(NumSensors1,1); % Platform coordinates returned as measured displacement.
init.Lbcb1.State.Jacob          = zeros(NumSensors1,NumSensors1);
init.Lbcb1.State.LengthInc      = zeros(NumSensors1,1); % Differences from calculated start lengths
init.Lbcb1.State.Platform_XYZ   = zeros(NumSensors1,1); % Current calculated platform coordinates.
init.Lbcb1.State.Readings       = zeros(NumSensors1,1);

init.Lbcb2.State.Base           = zeros(NumSensors2,3);
init.Lbcb2.State.Plat       = zeros(NumSensors2,3);
init.Lbcb2.State.Lengths        = zeros(NumSensors2,1);
init.Lbcb2.State.StartLengths   = zeros(NumSensors2,1);
init.Lbcb2.State.Platform_Ctr   = zeros(NumSensors2,1); % Platform coordinates returned as measured displacement.
init.Lbcb2.State.Jacob          = zeros(NumSensors2,NumSensors2);
init.Lbcb2.State.LengthInc      = zeros(NumSensors2,1);
init.Lbcb2.State.Platform_XYZ   = zeros(NumSensors2,1); % Current calculated platform coordinates.
init.Lbcb2.State.Readings       = zeros(NumSensors2,1);
