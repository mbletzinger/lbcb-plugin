function config = ConfigExternalTransducers()

config.AllNames = {...
    '1_LBCB2_y',...
    '2_LBCB2_x_bot',...
    '3_LBCB2_x_top',...
    '4_LBCB1_y_left',...
    '5_LBCB1_y_right',...
    '6_LBCB1_x'
    };
config.Lbcb1.IdxBounds = [4,6];
config.Lbcb1.NumSensors = config.Lbcb1.IdxBounds(2)...
    - config.Lbcb1.IdxBounds(1) + 1;
config.Lbcb2.IdxBounds = [1,3];
config.Lbcb2.NumSensors = config.Lbcb2.IdxBounds(2)...
    - config.Lbcb2.IdxBounds(1) + 1;
config.AllNumSensors = length(config.AllNames);

%Sensitivity of string pot reading(sort of calibration factor)
config.Sensitivities = ones(1,config.AllNumSensors)';

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
                                                                


%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
config.Lbcb1.Off_SPCM = [0 0 0 0 0 0]';
config.Lbcb2.Off_SPCM = [0 0 0 0 0 0]';
config.Lbcb1.McTransform = eye(3);
config.Lbcb2.McTransform = eye(3);

%Offset for motion center: LBCB coordinate system, X, Y, Z
config.Lbcb1.Off_MCTR = [0 0 0]';
config.Lbcb2.Off_MCTR = [0 0 0]';

% Allowable tolerance for jacobian updates vector size is AllNumSensors
config.Params.TOL = [0.000001 0.000001 0.000005]';

% Perturbation for jacobian estimation '
config.Params.Dx  = 0.001;
config.Params.Dz  = 0.001;
config.Params.Ry = 0.001;


