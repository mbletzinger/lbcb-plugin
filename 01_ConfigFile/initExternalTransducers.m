function init = initExternalTransducers(NumSensors1,NumSensors2)
init.Meas	= zeros(NumSensors1 + NumSensors2,1);      % Measured external transducers at each step
init.AvgMeas = zeros(NumSensors1 + NumSensors2,1);     % Measured external transducers at each step
init.State.StepNo               = 1;
init.Lbcb1.Base           = zeros(NumSensors1,3);
init.Lbcb1.Plat       = zeros(NumSensors1,3);
init.Lbcb1.Lengths        = zeros(NumSensors1,1); % Calculated string pot lengths
init.Lbcb1.StartLengths   = zeros(NumSensors1,1); % Calculated start lengths based on coordinates in 
                                                        % configExternalTransducers.m
init.Lbcb1.Platform_Ctr   = zeros(NumSensors1,1); % Platform coordinates returned as measured displacement.
init.Lbcb1.Jacob          = zeros(NumSensors1,NumSensors1);
init.Lbcb1.LengthInc      = zeros(NumSensors1,1); % Differences from calculated start lengths
init.Lbcb1.Platform_XYZ   = zeros(NumSensors1,1); % Current calculated platform coordinates.
init.Lbcb1.Readings       = zeros(NumSensors1,1);

init.Lbcb2.Base           = zeros(NumSensors2,3);
init.Lbcb2.Plat       = zeros(NumSensors2,3);
init.Lbcb2.Lengths        = zeros(NumSensors2,1);
init.Lbcb2.StartLengths   = zeros(NumSensors2,1);
init.Lbcb2.Platform_Ctr   = zeros(NumSensors2,1); % Platform coordinates returned as measured displacement.
init.Lbcb2.Jacob          = zeros(NumSensors2,NumSensors2);
init.Lbcb2.LengthInc      = zeros(NumSensors2,1);
init.Lbcb2.Platform_XYZ   = zeros(NumSensors2,1); % Current calculated platform coordinates.
init.Lbcb2.Readings       = zeros(NumSensors2,1);
