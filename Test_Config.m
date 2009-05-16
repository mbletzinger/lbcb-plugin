% ____________________________________________________________________________________________________________
%
% External measurement system configuration 
% ____________________________________________________________________________________________________________

%Matrix from calibration 
Aux_Config.T     		= eye(3);

%Stringpot sensitivity
Aux_Config.sensitivity 	= [1 1 1]'; %'

%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
Aux_Config1.S1b = [25.2482   19.1739	  0 ]'/2.54;		%'% base coordinate
Aux_Config1.S1p = [0.18      18.8739	  0 ]'/2.54;		%'% platform coordinate
Aux_Config1.S2b = [27.1482   -17.6261	  0 ]'/2.54;		%'% base coordinate    
Aux_Config1.S2p = [0.0503    -17.8752	  0 ]'/2.54;        %'% platform coordinate
Aux_Config1.S3b = [0.5482    -42.5261	  0 ]'/2.54;		%'% base coordinate    
Aux_Config1.S3p = [-0.0503   -19.8727	  0 ]'/2.54;        %'% platform coordinate

Aux_Config1.InitialLength = [ .88727 .729669 1.16195 ]';                     % Initial string lengths of sensors

Aux_Config2.S1b = [.75		-53.475    0 ]'/2.54;		%'% base coordinate
Aux_Config2.S1p = [.25		-20.1750   0 ]'/2.54; 		%'% platform coordinate
Aux_Config2.S2b = [26.05	-16.975    0 ]'/2.54;		%'% base coordinate    
Aux_Config2.S2p = [.25		-17.8750   0 ]'/2.54;       %'% platform coordinate
Aux_Config2.S3b = [25.45	18.325     0 ]'/2.54;		%'% base coordinate    
Aux_Config2.S3p = [-.25		19.025     0 ]'/2.54;       %'% platform coordinate

Aux_Config2.InitialLength = [ 0.99303 1.03841 1.07882 ]';                 % Initial string lengths of sensors

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
%Aux_Config.Off_SPCM = [-0.26602 0 -0.4 0 -0.01 0]';
Aux_Config.Off_SPCM = [0 0 0 0 0 0]'; %'

%Offset for motion center: LBCB coordinate system, X, Z, Ry
%Aux_Config.Off_MCTR = [-1.5 0 1]'; %'
Aux_Config.Off_MCTR = [0 0 0]'; %'


%%% debugging code =================================================================================================================================
cmd_scale_rubber = 1;		% command scale factor to minimize the effect of force error. As rubber specimen will remain elastic, and as error in force reading is very large in comparison of displacement 
				% command will be amplified and force reading will be deamplified so we can get high resolution force.
				% The effect of this factor, a, is (where a is scalar)
				% a*F = K * (a*D); 
				% following scripts are modified.
				%	propose.m
				%	query_mean.m
%%% ========================================================================================================================================== %%%


% ____________________________________________________________________________________________________________
%
% LBCB COnfiguration 
% ____________________________________________________________________________________________________________

coord_n1 = [720 60];		
coord_n2 = [576 180];		
coord_n3 = [720 276];		


ScaleF = 1;			% displacement scale factor

T1 = [1  0  0
      0  0  1
      0 0  -1];			% coordinate transformation (translation, from Model to LBCB1)  

T1r = T1;			% coordinate transformation (rotation, from Model to LBCB1)                                   

T2 = [0 -1  0
      0  0  1
      1  0  0];			% coordinate transformation (translation, from Model to LBCB2)

%T2r = T2;			% coordinate transformation (rotation, from Model to LBCB2)
T2r = [0 1 0
       0 0 -1
       -1 0 0];
       


%------------------------------------------------------------------------------------
% Auxiliary module configuration
%------------------------------------------------------------------------------------
Num_Aux = 0;

% % Camera Module 1
% AUX(1).URL            = '127.0.0.1:21997';
% AUX(1).protocol       = 'LabView1';                       
% AUX(1).name           = 'Camera1';     
% AUX(1).Command        = {'displacement' 'z' 3500}; 
% 
% % Camera Module 1
% AUX(2).URL            = '127.0.0.1:21996';
% AUX(2).protocol       = 'LabView1';                       
% AUX(2).name           = 'Camera2';     
% AUX(2).Command        = {'displacement' 'z' 3500}; 
% % DAQ Module
% AUX(3).URL            = '127.0.0.1:21995';
% AUX(3).protocol       = 'LabView1';                       
% AUX(3).name           = 'DAQ';     
% AUX(3).Command        = {'displacement' 'z' 3500}; 
