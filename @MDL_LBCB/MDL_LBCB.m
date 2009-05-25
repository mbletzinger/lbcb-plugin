function p = MDL_LBCB(vargin)

% _____________________________________________________________________________________________________________________
%
% Variables in GUI
% _____________________________________________________________________________________________________________________
p.StepNo =0;
p.InputSource		= 1;			    	% 1 for file, 2 for network
p.InputFile 		= 'DispHistory.txt';	    	% 6 column displacement data. Model space.
p.InputPort 		= 11998;		    	% Connection port from UI-SimCor, use LabView2 protocol


% p.IP_1            	= '127.0.0.1';              	% IP address
% p.IP_2            	= '127.0.0.1';              	% IP address
p.IP_1            	= 'rc3018.cee.uiuc.edu';              	% IP address
%p.IP_2            	= '130.126.243.18';              	% IP address
p.Port_1          	= 6342;                    	% Port number
%p.Port_2          	= 6343;                    	% Port number   

p.NetworkConnectionState = 1;                    % Network Connection Status with Operation Manager
                                                 % 0 -> when connection is not established or connection is failed
                                                 % 1 -> when connection is established or for the first trial connection
p.NetworkWaitTime   = 60;                         % Network waiting time. 


p.ItrElasticDeform 	= 1;				% 0 for no iteration, 1 for iteration
p.maxitr                = 10;				% maximum number of iteration
p.DispTolerance    	= [0.001 0.001 0.001 0.0005 0.0005 0.0005 0.001 0.001 0.001 0.0005 0.0005 0.0005]';	%'
							% Displacement tolerance for displacement iteration stage. LBCB coordinate system.


p.StepReduction 	= 1;				% 0 for no step reduction, 1 for step reduction when displacement increment is large                	
p.DispIncMax       	= [0.1  0.1  0.1  0.05  0.05  0.05 0.1  0.1  0.1  0.05  0.05  0.05]';	%'
							% Maximum displacement increment. 
                     
                     
p.CheckLimit_Disp1 	= 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_DispInc1 	= 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_Forc1 	= 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_Disp2 	= 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_DispInc2 	= 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_Forc2 	= 1;                   % 1 for check, 0 for ignore     

p.CAP_D_min      = [-0.75    -0.5    -0.5    -0.05  -0.05  -0.05     -0.75    -0.5    -0.5    -0.05  -0.05  -0.05]';             %'% Displacement limit
p.CAP_D_max      = [0.75    0.5    0.5    0.05  0.05  0.05    0.75    0.5    0.5    0.05  0.05  0.05]';             %'% Displacement limit
p.TGT_D_inc      = [ .25     .25     .25     0.01  0.01  0.01       .25     .25     .25   0.01  0.01  0.01]';             %'% Displacement increment limit
p.CAP_F_min      = [-1000 -1000 -1500 -2000 -2000 -2000   -1000 -1000 -1500  -2000 -2000 -2000]';    %'% Force limit
p.CAP_F_max      = [ 1000  1000  1500  2000  2000  2000    1000  1000  1500   2000  2000  2000]';    %'% Force limit

p.DispMesurementSource = 1;	% 0 for LBCb, 1 for external mesurement
p.NoiseCompensation = 1;	% 0 for single reading, 1 for multiple reading and use average value

p.Axis_X1	 = 1;			    % Default monitoring chart
p.Axis_X2	 = 1;			    % Default monitoring chart
p.Axis_X3	 = 1;			    % Default monitoring chart
p.Axis_X4	 = 1;			    % Default monitoring chart

p.Axis_Y1	 = 2;			    % Default monitoring chart
p.Axis_Y2	 = 8;			    % Default monitoring chart
p.Axis_Y3	 = 2;			    % Default monitoring chart
p.Axis_Y4	 = 8;			    % Default monitoring chart

p.EnableMovingWin = 1;			    % Moving window display? 1 for yes, 0 for no
p.MovingWinWidth  = 50;			    % Moving window step with, 50




% _____________________________________________________________________________________________________________________
%
% Internval variables 
% _____________________________________________________________________________________________________________________

p.n1 = zeros(3,1);				% nodal displacement at column base.


p.M_Disp        = zeros(12,1);                  % Measured displacement at each step, Num_DOFx1
p.M_Disp1       = zeros(6,1);                  	% Measured displacement at each step, Num_DOFx1
p.M_Disp2       = zeros(6,1);                  	% Measured displacement at each step, Num_DOFx1

p.M_AuxDisp1	= zeros(3,1);			% Measured axusiliary displacement at each step
p.M_AuxDisp2	= zeros(3,1);			% Measured axusiliary displacement at each step

p.M_Forc        = zeros(12,1);                  % Measured force at each step, Num_DOFx1
p.M_Forc1        = zeros(6,1);                  % Measured force at each step, Num_DOFx1
p.M_Forc2        = zeros(6,1);                  % Measured force at each step, Num_DOFx1

p.T_Disp_0      = zeros(12,1);                   % Previous step's target displacement, Num_DOFx1
p.T_Disp        = zeros(12,1);                   % Target displacement, Num_DOFx1

p.Disp_T_Model  = zeros(12,1);


% _____________________________________________________________________________________________________________________
%
% Private variables 
% _____________________________________________________________________________________________________________________

p.Comm_obj_1      = {};                       % communication object
p.Comm_obj_2      = {};                       % communication object
%p.vec_MES_D_inc = [];                       % dimension => p.Num_DOF x 1
%p.vec_MES_F_inc = [];                       % dimension => p.Num_DOF x 1
%p.vec_TGT_D_inc = [];                       % dimension => p.Num_DOF x 1
%p.vec_CAP_D_tot = [];                       % dimension => p.Num_DOF x 1
%p.vec_CAP_F_tot = [];                       % dimension => p.Num_DOF x 1
%p.vec_TOL_D_inc = [];                       % dimension => p.Num_DOF x 1


% Following six variables are only used GUI mode to plot history of data
p.tDisp_history     = zeros(10000,12);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.tForc_history     = zeros(10000,12);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.mDisp_history     = zeros(10000,12);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.mForc_history     = zeros(10000,12);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space


% ------------------------------------------
% Command flags used for communication
% ------------------------------------------
p.CMD.RQST_INITIALIZE       = char( 3);
p.CMD.RPLY_INITIALIZE_OK    = char( 4);
p.CMD.RQST_PUT_TARGET_DIS   = char(11);
p.CMD.RPLY_PUT_DATA         = char(16);
p.CMD.RQST_TEST_COMPLETE    = char(17);
p.CMD.RQST_OPENNETWORK      = char(51);
p.CMD.RQST_OPENNETWORK_OK   = char(52);
p.CMD.ACKNOWLEDGE           = char(99);


p.TransID           = '';                  % Transaction ID
p.curStep       	= 0;                        % Current step number for this module
p.totStep       	= 0;                        % Total number of steps to be tested

p.curState      	= 0;                        % Current state of simulation
                      %   0 before simulation
                      %   1   proposed
                      %   2   executed
                      %   3   result received
                      %   4   test complete






% ------------------------------------------
% Parameters for string pot control
% ------------------------------------------
p.NumSample	   = 20;					% number of samples to use to estimate average force and displacement 




p.Aux_Config1.T     = eye(3);

%Sensitivity of string pot reading(sort of calibration factor)
p.Aux_Config1.sensitivity = [1 1 1]';
	
	
%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
p.Aux_Config1.S1b = [0  0  0 ]'/2.54;        % base coordinate
p.Aux_Config1.S1p = [0  0  0 ]'/2.54;        % platform coordinate                     
 
p.Aux_Config1.S2b = [0  0  0 ]'/2.54;        % base coordinate    
p.Aux_Config1.S2p = [0  0  0 ]'/2.54;        % platform coordinate
                 
p.Aux_Config1.S3b = [0  0  0 ]'/2.54;        % base coordinate    
p.Aux_Config1.S3p = [0  0  0 ]'/2.54;        % platform coordinate

p.Aux_Config1.InitialLength = [0 0 0];

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
%p.Aux_Config1.Off_SPCM = [-0.26602 0 -0.4 0 -0.01 0]';
p.Aux_Config1.Off_SPCM = [0 0 0 0 0 0]';

%Offset for motion center: LBCB coordinate system, X, Z, Ry
%p.Aux_Config1.Off_MCTR = [-1.5 0 1]';
p.Aux_Config1.Off_MCTR = [0 0 0]';

% Allowable tolerance for jacobian updates
p.Aux_Config1.TOL = [0.0001 0.0001 0.00005]';

% Perturbation for jacobian estimation 
p.Aux_Config1.dx  = 0.001;
p.Aux_Config1.dy  = 0.001;
p.Aux_Config1.drz = 0.001;


p.Aux_Config2 = p.Aux_Config1;

p.Aux_Config2.sensitivity = [1 1 1]';

%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
p.Aux_Config2.S1b  = [0  0  0 ]'/2.54;           % Base coordinate
p.Aux_Config2.S1p  = [0  0  0 ]'/2.54;           % Plat coordinate
                                                                
p.Aux_Config2.S2b  = [0  0  0 ]'/2.54;           % Base coordinate    
p.Aux_Config2.S2p  = [0  0  0 ]'/2.54;           % Plat coordinate
                                                                
p.Aux_Config2.S3b  = [0  0  0 ]'/2.54;           % Base coordinate    
p.Aux_Config2.S3p  = [0  0  0 ]'/2.54;           % Plat coordinate

p.Aux_Config2.InitialLength = [0 0 0];

% ===================================================================================
p.Aux_State1.StepNo       = 1;
p.Aux_State1.S1b_off      = zeros(3,1);
p.Aux_State1.S2b_off      = zeros(3,1);
p.Aux_State1.S3b_off      = zeros(3,1);
p.Aux_State1.S1p_off      = zeros(3,1);
p.Aux_State1.S2p_off      = zeros(3,1);
p.Aux_State1.S3p_off      = zeros(3,1);
p.Aux_State1.S            = zeros(3,1);
p.Aux_State1.So           = zeros(3,1);
p.Aux_State1.Platform_Ctr = zeros(3,1);
p.Aux_State1.Strn_Inc     = zeros(3,1);
p.Aux_State1.J            = zeros(3,3);
p.Aux_State1.Strn_Inc     = zeros(3,1);

p.Aux_State2.StepNo       = 1;
p.Aux_State2.S1b_off      = zeros(3,1);
p.Aux_State2.S2b_off      = zeros(3,1);
p.Aux_State2.S3b_off      = zeros(3,1);
p.Aux_State2.S1p_off      = zeros(3,1);
p.Aux_State2.S2p_off      = zeros(3,1);
p.Aux_State2.S3p_off      = zeros(3,1);
p.Aux_State2.S            = zeros(3,1);
p.Aux_State2.So           = zeros(3,1);
p.Aux_State2.Platform_Ctr = zeros(3,1);
p.Aux_State2.Strn_Inc     = zeros(3,1);
p.Aux_State2.J            = zeros(3,3);
p.Aux_State2.Strn_Inc     = zeros(3,1);


% _____________________________________________________________________________________________________________________
%
% Register the structure as class
% _____________________________________________________________________________________________________________________
p = class(p,'MDL_LBCB');
