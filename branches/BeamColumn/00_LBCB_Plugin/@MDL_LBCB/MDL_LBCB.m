function p = MDL_LBCB(vargin)

% _____________________________________________________________________________________________________________________
%
% Public variables 
% _________________________________________________________________________
% ____________________________________________
p.Gui = configGuiDefaults();
p.Limits = configLimitDefaults();
p.Lbcb1 = initLbcbData();
p.Lbcb2 = initLbcbData();
p.ExtTrans.Config = configExternalTransducers();
p.ExtTrans.State = initExternalTransducers(p.ExtTrans.Config.Lbcb1.NumSensors,...
    p.ExtTrans.Config.Lbcb1.NumSensors);




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
                                            
%SJKIM Oct01-2007



% Averaged Measurements



p.T_Disp_SC_his  = zeros(6,1);                       % Input target displacement (ex, from simcor)

% _____________________________________________________________________________________________________________________
%
% Private variables 
% _____________________________________________________________________________________________________________________
p.Comm_obj      = {};                       % communication object

% LBCB Step, Following six variables are only used GUI mode to plot history of data
p.Lbcb1.tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb1.tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb1.mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb1.mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
p.tDisp_history_SC  = zeros(10000,6);                   % History of target   displacement in SimCor Space

% Model Step
p.Model_tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Model_tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb1.Model_mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb1.Model_mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.Model_mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
p.Lbcb2.Model_mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
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

% ===================================================================================
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
