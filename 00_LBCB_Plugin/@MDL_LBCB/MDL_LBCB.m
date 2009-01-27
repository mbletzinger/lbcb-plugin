function p = MDL_LBCB(vargin)

% _____________________________________________________________________________________________________________________
%
% Public variables 
% _____________________________________________________________________________________________________________________
p.TestDate_Str      ='02082008';                 % Date string to save data file with this date

p.name          	= 'LBCB';           		% Name of the stiffness module
%p.protocol      	= 'LabView1';               	% Protocol for communication with LBCB
%p.IP            	= '130.126.240.242';              	% IP address
%p.Port          	= 44000;                    	% Port number

p.IP            	= '127.0.0.1';              	% IP address
p.Port          	= 11998;                    	% Port number
                	                            	
p.InputSource		= 2;			    	% 1 for file, 2 for network
p.InputFile 		= 'Input.txt';  %'DispHistory.txt';	    	% 6 column displacement data. Model space.
p.InputFilePath     = cell(1,1);
p.InputFilePath{1}  = p.InputFile;
p.InputPort 		= 11999;		    	% Connection port from UI-SimCor, use LabView2 protocol
                	
p.CtrlMode  		= 1;				% Control mode, 1 for displacement, 2 for mixed, 3 for Mixed static.
% if CtrlMode == 2, define following variables. 
p.FrcCtrlDOF 		= 3;				% Force controlled DOF in LBCB space. Used only when CtrlMode == 2
p.K_vert_ini    	= 3000 * 0.3;			% Initial stiffnes of force controlled DOF. LBCB space (lb, in)
p.secK_factor    	= 0.7;				% secant stiffness factor, the larger value, the larger chance for overshoot.
p.secK_eval_itr   	= 5;				% after this number of iteration, secant stiffness will be evaluated with 1st order regression
p.max_itr        	= 20;				% maximum number of iteration

p.IN_DOF        = [0 0 0 0 0 0];            		% 6 DOF control. DOF 2 is force controlled
                                             		

p.ScaleF        	= [1 1 1 1];                	% Scale factor for displacement, rotation, force, and moment.
                                            		% Remote sites are not always in full scale. Use this factors to apply scale
                                            		% factors.
                                            		% The displacement scale factors are multiplied before the displacements are
                                            		% sent to remote site. Measured force and moments are divided with scale factors
                                            		% before they are returned.


p.LBCB_FrcCtrlDOF = zeros(6,1);                 % 0 for displacement control, 1 for force control
p.Model_FrcCtrlDOF = zeros(6,1);                 % 0 for displacement control, 1 for force control

                                           		
p.DispScale     	= [1 1 1 1 1 1]';             	% A vector of displacement scale factors. Dimension: Num_DOF x 1
p.ForcScale     	= [1 1 1 1 1 1]';             	% A vector of force scale factors. Dimension: Num_DOF x 1

p.ModelCoord    	= 1;			    	% GUI data. Model coordinate system
p.LBCBCoord    	 	= 1;			    	% GUI data. LBCB coordinate system
p.TransM        	= eye(6);                   	% A matrix used for coordinate transformation when necessary. d2 = TransM * d1,
                                            		% where d1 is input to this stiffnes module, d2 is output to remote site
                                            		% The dimension of this matrix should be Num_DOF x Num_DOF
                                            
% ------------------------------------------
p.CheckLimit_Disp = 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_DispInc = 1;                   % 1 for check, 0 for ignore     
p.CheckLimit_Forc = 0;                   % 1 for check, 0 for ignore     

% ------------------------------------------
% The dimension of the following matrices should be same as that of p.EFF_DOF

p.CAP_D_min      = [-3 -3  -2  -0.2 -0.2 -0.2 ]';   % Displacement limit
p.CAP_D_max      = [ 3  3   2   0.2  0.2  0.2 ]';   % Displacement limit
p.TGT_D_inc      = [ 1  1   1   0.05 0.05 0.05]';   % Displacement increment limit
p.CAP_F_min      = [-1000 -1000 -1500 -2000 -2000 -2000]'; % Force limit
p.CAP_F_max      = [ 1000  1000  1500  2000  2000  2000]'; % Force limit '

p.M_Disp        = zeros(6,1);                       % Measured displacement at each step, Num_DOFx1
%SJKIM Oct01-2007
p.M_AuxDisp_Raw	= zeros(5,1);			    % Measured axusiliary displacement at each step
p.M_AuxDisp	    = zeros(3,1);			    % Measured axusiliary displacement at each step
p.M_Forc        = zeros(6,1);                       % Measured force at each step, Num_DOFx1
p.T_Disp_0      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
p.T_Disp        = zeros(6,1);                       % Target displacement, Num_DOFx1
p.T_Forc_0      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
p.T_Forc        = zeros(6,1);                       % Target displacement, Num_DOFx1
p.T_Data_0      = zeros(6,1);                       % Previous Target Data to LBCB
p.T_Data_1      = zeros(6,1);                       % Current Target Data to LBCB

p.T_Forc        = zeros(6,1);                       % Target displacement, Num_DOFx1
%p.T_ForcRS      = [];                       % Target displacement sent to remote site
p.T_Disp_SC_his  = zeros(6,1);                       % Input target displacement (ex, from simcor)


p.Axis_X1	 = 1;			    % Default monitoring chart
p.Axis_X2	 = 1;			    % Default monitoring chart
p.Axis_X3	 = 1;			    % Default monitoring chart
p.Axis_Y1	 = 20;			    % Default monitoring chart
p.Axis_Y2	 = 2;			    % Default monitoring chart
p.Axis_Y3	 = 8;			    % Default monitoring chart

p.EnableMovingWin = 1;			    % Moving window display? 1 for yes, 0 for no
p.MovingWinWidth  = 50;			    % Moving window step with, 50

% _____________________________________________________________________________________________________________________
%
% Private variables 
% _____________________________________________________________________________________________________________________
p.Comm_obj      = {};                       % communication object

% LBCB Step, Following six variables are only used GUI mode to plot history of data
p.tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
p.tDisp_history_SC  = zeros(10000,6);                   % History of target   displacement in SimCor Space

% Model Step
p.Model_tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Model_tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Model_mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.Model_mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
p.Model_tDisp_history_SC  = zeros(10000,6);                   % History of target   displacement in SimCor Space


%p.mDisp_history_RS  = [];                   % History of measured displacement in global system, total step numbet x Num_DOF, in remote site space
%p.mForc_history_RS  = [];                   % History of measured force in global system, total step numbet x Num_DOF, in remote site space

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
p.StepNos           = 0;                       % SimCor Step. Added by SJKIM
p.curStep       	= 0;                        % Current step number for this module
p.totStep       	= 0;                        % Total number of steps to be tested

p.curState      	= 0;                        % Current state of simulation
                      %   0 before simulation
                      %   1   proposed
                      %   2   executed
                      %   3   result received
                      %   4   test complete

%p.UpdateMonitor	   = 1;
p.ItrElasticDeform = 1;		% 0 for no iteration, 1 for iteration
p.StepReduction = 1;		% 0 for no step reduction, 1 for step reduction when displacement increment is large
p.DispMesurementSource = 1;	% 0 for LBCb, 1 for external mesurement
p.NoiseCompensation = 1;	% 0 for single reading, 1 for multiple reading and use average value

% ------------------------------------------
% Parameters for stringpot control
% ------------------------------------------
p.NumSample	   = 10;					% number of samples to use to estimate average force and displacement 
p.DispTolerance    = [0.001 0.001 0.001 0.0005 0.0005 0.0005]';	% Displacement tolerance for displacement iteration stage. LBCB coordinate system.
p.DispIncMax       = [0.01  0.01  0.01  0.005  0.005  0.005 ]';	% Maximum displacement increment. 
p.Aux_Config.T     = eye(4);

%Sensitivity of string pot reading(sort of calibration factor)
p.Aux_Config.sensitivity = [1 1 1 1]';

%SJKIM OCT01-2007  '
% Initial length of String pot
p.Aux_Config.InitialLength = zeros(5,1);
	
%Pin locations: Model coordinate system, inches. Origin of coordinate system should be platform center
p.Aux_Config.S1b = [-496.085,  3.349,  -6.998]'/25.4;           % base coordinate
p.Aux_Config.S1p = [-228.064, -2.602,   0.674]'/25.4;           % platform coordinate
                                                                
p.Aux_Config.S2b = [-193.208, -423.583,-4.428]'/25.4;           % base coordinate    
p.Aux_Config.S2p = [-191.633, -0.103,  -6.959]'/25.4;           % platform coordinate
                                                                
p.Aux_Config.S3b = [ 187.711, -449.115,-5.257]'/25.4;           % base coordinate    
p.Aux_Config.S3p = [ 189.679, -6.127,  -0.217]'/25.4;           % platform coordinate
                                                                
p.Aux_Config.S4b = [ 187.711, -449.115,-5.257]'/25.4;           % base coordinate    
p.Aux_Config.S4p = [ 189.679, -6.127,  -0.217]'/25.4;           % platform coordinate

%Offset for specimen: LBCB coordinate system, inches. Offset from motion center. X, Y, Z, Rx, Ry, Rz
p.Aux_Config.Off_SPCM = [0 0 0 0 0 0]';

%Offset for motion center: LBCB coordinate system, X, Y, Z
p.Aux_Config.Off_MCTR = [0 0 0]';

% Allowable tolerance for jacobian updates
p.Aux_Config.TOL = [0.0001 0.0001 0.00005 0.00005]';

% Perturbation for jacobian estimation '
p.Aux_Config.dx  = 0.001;
p.Aux_Config.dy  = 0.001;
p.Aux_Config.drz = 0.001;
p.Aux_Config.drx = 0.001;

% ===================================================================================
p.Aux_State.StepNo         = 1;
p.Aux_State.S1b_off        = zeros(3,1);
p.Aux_State.S2b_off        = zeros(3,1);
p.Aux_State.S3b_off        = zeros(3,1);
p.Aux_State.S4b_off        = zeros(3,1);
p.Aux_State.S1p_off        = zeros(3,1);
p.Aux_State.S2p_off        = zeros(3,1);
p.Aux_State.S3p_off        = zeros(3,1);
p.Aux_State.S4p_off        = zeros(3,1);
p.Aux_State.S              = zeros(4,1);
p.Aux_State.So             = zeros(4,1);
p.Aux_State.Platform_Ctr   = zeros(4,1);
p.Aux_State.Strn_Inc       = zeros(4,1);
p.Aux_State.J              = zeros(4,4);
p.Aux_State.Strn_Inc       = zeros(4,1);
p.Aux_State.Platform_XYZ   = zeros(4,1);
% _____________________________________________________________________________________________________________________
%
% To monitor data
% _____________________________________________________________________________________________________________________
%Model Target
p.Model_T_Displ = zeros(6,1);
p.Model_T_Force = zeros(6,1);
% LBCB Target
p.LBCB_T_Displ = zeros(6,1);
p.LBCB_T_Force = zeros(6,1);
p.LBCB_Target_1= zeros(6,1);
p.LBCB_Target_0= zeros(6,1);
%p.CABER_Displ_Error = zeros(6,1);     % Difference between CABER_TDispl and CABER_ED_MDispl

p.LBCB_MDispl = zeros(6,1);     % Measured Displ from LBCB


p.Initial_Offset    = zeros (6,1);   %initial offset
p.SimCorStepData    = zeros (22,1);  % For the SimCor Step Data

% For Control Mode 3, Static Test



% _____________________________________________________________________________________________________________________
%
% Register the structure as class
% _____________________________________________________________________________________________________________________
p = class(p,'MDL_LBCB');
