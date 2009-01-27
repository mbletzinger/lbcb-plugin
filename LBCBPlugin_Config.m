% LBCBPlugin Configuration
%------------------------------------------------------------------------------------
% Auxiliary module configuration
%------------------------------------------------------------------------------------
Num_Aux = 2;

% Camera
AUX(1).URL            = '127.0.0.1:21997';
AUX(1).protocol       = 'LabView1';                       
AUX(1).name           = 'Camera1';     % Module ID of this mdoule is 1    
AUX(1).Command        = {'displacement' 'z' 3500}; 

% DAQ
AUX(2).URL            = '127.0.0.1:21995';
AUX(2).protocol       = 'LabView1';                       
AUX(2).name           = 'DAQ';     % Module ID of this mdoule is 1    
AUX(2).Command        = {'displacement' 'z' 3500}; 

%------------------------------------------------------------------------------------
% Configuration for external measurement
%------------------------------------------------------------------------------------
%Matrix from calibration 
Aux_Config.T=eye(4);

%Stringpot sensitivity
Aux_Config.sensitivity 	= [1 1 1 1]';
%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
Aux_Config.S1b = [123.5,-1.125,-40.5]';		% base coordinate
Aux_Config.S1p = [0,-1.125,-40.5]';		% platform coordinate
Aux_Config.S2b = [-68.125,-94.875,-28.875]';		% base coordinate    
Aux_Config.S2p = [-68.125,-4,-28.875]';            	% platform coordinate
Aux_Config.S3b = [69,-95.375,-28.875]';		% base coordinate    
Aux_Config.S3p = [69,-4,-28.875]';             	% platform coordinate
Aux_Config.S4b = [0,-97.75,59.9375]';              % base coordinate    
Aux_Config.S4p = [0,-4,59.9375]';                 % platform coordinate

% Initial length of String pot
% [SP_Horizontal_Top,SP_Left,SP_Right,SP_Horizontal_Bottom,SP_Front];
Aux_Config.InitialLength=[9.4714; 1.9726; 1.8475; 4.7718; 0.6957];

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
%Aux_Config.Off_SPCM = [+3.2462193e-005	+0.0000000e+000	-1.2633834e-004	-1.3093158e-005	-8.8546946e-006	+0.0000000e+000]';
%Aux_Config.Off_SPCM = [-3.4656355e+000	+0.0000000e+000	-4.2808401e-001	+1.3496010e-004	+1.0618791e-004	+0.0000000e+000]';
Aux_Config.Off_SPCM = [-5.0128958e+000	+0.0000000e+000	-5.2849421e-001	+1.3802363e-004	-6.5966908e-005	+0.0000000e+000]';
%Offset for motion center: LBCB coordinate system, X, Y, Z '
Aux_Config.Off_MCTR = [0, 0, 0]';

