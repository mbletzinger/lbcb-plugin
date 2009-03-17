function init = initElastDef(NumSensors)
init.Base           = zeros(NumSensors,3); % Base pin coordinates these should not move
init.Plat       = zeros(NumSensors,3);     % Current platform pin coordinates
init.Lengths        = zeros(NumSensors,1); % Calculated string pot lengths
init.StartLengths   = zeros(NumSensors,1); % Calculated start lengths based on coordinates in 
                                                        % configExternalTransducers.m
init.Platform_Ctr   = zeros(NumSensors,1); % Platform coordinates returned as measured displacement.
init.Jacob          = zeros(NumSensors,NumSensors);
init.LengthInc      = zeros(NumSensors,1); % Differences from calculated start lengths
init.Platform_XYZ   = zeros(NumSensors,1); % Current calculated platform coordinates.
