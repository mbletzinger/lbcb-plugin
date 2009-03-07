function config = configExternalTransducers()

config.AllNames = {...
    'Ext.Long.LBCB2',...
    'Ext.Tranv.TopLBCB2',...
    'Ext.Tranv.Bot.LBCB2',...
    'Ext.Long.LBCB1',...
    'Ext.Tranv.LeftLBCB1',...
    'Ext.Tranv.RightLBCB1'
    };
config.Lbcb1.IdxBounds = [4,6];
config.Lbcb1.NumSensors = config.Lbcb1.IdxBounds(2)...
    - config.Lbcb1.IdxBounds(1) + 1;
config.Lbcb2.IdxBounds = [1,3];
config.Lbcb2.NumSensors = config.Lbcb2.IdxBounds(2)...
    - config.Lbcb2.IdxBounds(1) + 1;
config.AllNumSensors = length(config.AllNames);

config.Lbcb1.TransformLbcb2Model     = eye(3);
config.Lbcb2.TransformLbcb2Model     = eye(3);

%Sensitivity of string pot reading(sort of calibration factor)
config.Lbcb1.Sensitivities = ones(1,config.Lbcb1.NumSensors)';
config.Lbcb2.Sensitivities = ones(1,config.Lbcb2.NumSensors)';

%SJKIM OCT01-2007  '
% Initial length of String pot
config.Lbcb1.InitialLength = zeros(config.Lbcb1.NumSensors,1);
config.Lbcb2.InitialLength = zeros(config.Lbcb2.NumSensors,1);

config.Lbcb1.Base = zeros(config.Lbcb1.NumSensors,3);
config.Lbcb1.Plat = zeros(config.Lbcb1.NumSensors,3);

%Pin locations: Model coordinate system, inches. Origin of coordinate system should be Platform center
config.Lbcb1.Base(1,:) = [0        144.5670 0]';%/25.4;           % Base coordinate: LBCB1 Long. Transducer
config.Lbcb1.Plat(1,:) = [185.7796 159.6276 0]';%/25.4;           % Plat coordinate
                                                                
config.Lbcb1.Base(2,:) = [156.3667 0        0]';%/25.4;           % Base coordinate: LBCB1 Lat. Left Transducer    
config.Lbcb1.Plat(2,:) = [185.7796 134.6276 0]';%/25.4;           % Plat coordinate
                                                                
config.Lbcb1.Base(3,:) = [368.2819 47.8761  0]';%/25.4;           % Base coordinate: LBCB1 Lat. Right Transducer
config.Lbcb1.Plat(3,:) = [385.7796 134.6276 0]';%/25.4;           % Plat coordinate
                                                                
config.Lbcb2.Base(1,:) = [-496.085,  3.349,  -6.998]';%/25.4;           % Base coordinate
config.Lbcb2.Plat(1,:) = [-228.064, -2.602,   0.674]';%/25.4;           % Plat coordinate
                                                                
config.Lbcb2.Base(2,:) = [-193.208, -423.583,-4.428]';%/25.4;           % Base coordinate    
config.Lbcb2.Plat(2,:) = [-191.633, -0.103,  -6.959]';%/25.4;           % Plat coordinate
                                                                
config.Lbcb2.Base(3,:) = [ 187.711, -449.115,-5.257]';%/25.4;           % Base coordinate    
config.Lbcb2.Plat(3,:) = [ 189.679, -6.127,  -0.217]';%/25.4;           % Plat coordinate
                                                                


%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
config.Lbcb1.Off_SPCM = [0 0 0 0 0 0]';
config.Lbcb2.Off_SPCM = [0 0 0 0 0 0]';
config.Lbcb1.McTransform = eye(3);
config.Lbcb2.McTransform = eye(3);

%Offset for motion center: LBCB coordinate system, X, Y, Z
config.Lbcb1.Off_MCTR = [0 0 0]';
config.Lbcb2.Off_MCTR = [0 0 0]';

% Allowable tolerance for jacobian updates vector size is AllNumSensors
config.Params.TOL = [0.0001 0.0001 0.00005]';

% Perturbation for jacobian estimation '
config.Params.Dx  = 0.001;
config.Params.Dz  = 0.001;
config.Params.Ry = 0.001;


