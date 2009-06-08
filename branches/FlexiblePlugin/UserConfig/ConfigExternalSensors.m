function config = ConfigExternalSensors(cfg)

spd = SensorParametersDao(cfg);
config.Lbcb1.NumSensors = spd.numSensors(0);
config.Lbcb2.NumSensors = spd.numSensors(1);
config.AllNumSensors = config.Lbcb1.NumSensors + config.Lbcb2.NumSensors;

%SJKIM OCT01-2007
% Initial length of String pot
config.InitialLength = zeros(config.AllNumSensors,1);

config.Lbcb1.Base = zeros(config.Lbcb1.NumSensors,3);
config.Lbcb1.Plat = zeros(config.Lbcb1.NumSensors,3);

config.Lbcb2.Base = zeros(config.Lbcb2.NumSensors,3);
config.Lbcb2.Plat = zeros(config.Lbcb2.NumSensors,3);

%Pin locations: Model coordinate system, inches. Origin of coordinate system should be Platform center
config.Lbcb1.Base(1,:) = [-19.15  -23.65    0]'/2.54;           % Base coordinate: LBCB1 Long. Transducer
config.Lbcb1.Plat(1,:) = [-18.85  0.95      0]'/2.54;           % Plat coordinate
                                                                
config.Lbcb1.Base(2,:) = [17.65   -25.55    0]'/2.54;           % Base coordinate: LBCB1 Lat. Left Transducer    
config.Lbcb1.Plat(2,:) = [17.85   -0.95     0]'/2.54;           % Plat coordinate
                                                                
config.Lbcb1.Base(3,:) = [42.55   1.05      0]'/2.54;           % Base coordinate: LBCB1 Lat. Right Transducer
config.Lbcb1.Plat(3,:) = [19.85   -0.95     0]'/2.54;           % Plat coordinate
                                                                
config.Lbcb2.Base(1,:) = [.75     -53.475   0]'/2.54;           % Base coordinate
config.Lbcb2.Plat(1,:) = [.25     -20.1750  0]'/2.54;           % Plat coordinate
                                                                
config.Lbcb2.Base(2,:) = [26.05   -16.975   0]'/2.54;           % Base coordinate    
config.Lbcb2.Plat(2,:) = [.25     -17.8750  0]'/2.54;           % Plat coordinate
                                                                
config.Lbcb2.Base(3,:) = [25.45   18.325    0]'/2.54;           % Base coordinate    
config.Lbcb2.Plat(3,:) = [-.25    19.025    0]'/2.54;           % Plat coordinate
                                                                

% Allowable tolerance for jacobian updates
config.Params.TOL = [0.000001 0.000001 0.000005]';

% Perturbation for jacobian estimation
config.Params.pertDx  = 0.001;
config.Params.pertDz  = 0.001;
config.Params.pertRy = 0.001;


