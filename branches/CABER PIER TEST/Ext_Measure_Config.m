%------------------------------------------------------------------------------------
% Configuration for external measurement
%------------------------------------------------------------------------------------
%Matrix from calibration 
Aux_Config.T=eye(4);

%Stringpot sensitivity
Aux_Config.sensitivity 	= [1 1 1 1]';
%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
Aux_Config.S1b = [121.75,-1.50,-34]';		% base coordinate
Aux_Config.S1p = [0,-1.50,-34]';		% platform coordinate
Aux_Config.S2b = [-67.625,-113.375,-29]';		% base coordinate    
Aux_Config.S2p = [-67.625,-4.25,-29]';            	% platform coordinate
Aux_Config.S3b = [68.625,-112.625,-29]';		% base coordinate    
Aux_Config.S3p = [68.625,-4.25,-29]';             	% platform coordinate
Aux_Config.S4b = [0,-114.4375,59.6875]';              % base coordinate    
Aux_Config.S4p = [0,-4,59.6875]';                 % platform coordinate

% Initial length of String pot
% [SP_Horizontal_Top,SP_Left,SP_Right,SP_Horizontal_Bottom,SP_Front];
Aux_Config.InitialLength=[9.8264; 4.1463; 4.1622; 6.0553; 1.0374];

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
Aux_Config.Off_SPCM = [+1.5030992e+000	+0.0000000e+000	-2.1304457e-001	+4.5968458e-004	+1.7289259e-003	+0.0000000e+000]';

%Offset for motion center: LBCB coordinate system, X, Y, Z '
Aux_Config.Off_MCTR = [0, 0, 0]';
