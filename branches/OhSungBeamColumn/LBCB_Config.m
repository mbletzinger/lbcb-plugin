%Matrix from calibration 
Aux_Config.T     		= eye(3);

%Stringpot sensitivity
Aux_Config.sensitivity 	= [1 1 1]';

%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
Aux_Config.S1b = [-496.085,  3.349,  -6.998]'/25.4;		% base coordinate
Aux_Config.S1p = [-228.064, -2.602,   0.674]'/25.4;		% platform coordinate
Aux_Config.S2b = [-193.208, -423.583,-4.428]'/25.4;		% base coordinate    
Aux_Config.S2p = [-191.633, -0.103,  -6.959]'/25.4;            	% platform coordinate
Aux_Config.S3b = [ 187.711, -449.115,-5.257]'/25.4;		% base coordinate    
Aux_Config.S3p = [ 189.679, -6.127,  -0.217]'/25.4;             	% platform coordinate

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
%Aux_Config.Off_SPCM = [-0.26602 0 -0.4 0 -0.01 0]';
Aux_Config.Off_SPCM = [0 0 0 0 0 0]';

%Offset for motion center: LBCB coordinate system, X, Z, Ry
%Aux_Config.Off_MCTR = [-1.5 0 1]';
Aux_Config.Off_MCTR = [0 0 0]';  %'


%------------------------------------------------------------------------------------
% Auxiliary module configuration
%------------------------------------------------------------------------------------
Num_Aux = 3;

% Camera Module 1
AUX(1).URL            = '127.0.0.1:21997';
AUX(1).protocol       = 'LabView1';                       
AUX(1).name           = 'Camera1';     
AUX(1).Command        = {'displacement' 'z' 3500}; 

% Camera Module 1
AUX(2).URL            = '127.0.0.1:21996';
AUX(2).protocol       = 'LabView1';                       
AUX(2).name           = 'Camera2';     
AUX(2).Command        = {'displacement' 'z' 3500}; 
% DAQ Module
AUX(3).URL            = '127.0.0.1:21995';
AUX(3).protocol       = 'LabView1';                       
AUX(3).name           = 'DAQ';     
AUX(3).Command        = {'displacement' 'z' 3500}; 