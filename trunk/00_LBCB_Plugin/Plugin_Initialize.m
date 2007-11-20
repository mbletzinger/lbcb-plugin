function handles = Plugin_Initialize(handles, config)

if config == 1		% default
	% 10-25-2007 
	questResult = questdlg('Please backup previous simulation results if necessary. All previous files will be deleted.', 'New Simulation For CABER Pier','Okay','Cancel','Okay');
	
	if strcmp(questResult,'Okay')
		Plugin_Initialize_CreateFile;
	else
	  return;
	end 
	
	%
	handles.MDL = MDL_LBCB;    
	

elseif config == 2	% use current.
	
end

handles.Fun_banner = imread('Funbanner.bmp'); % Read the image file banner.bmp

axes(handles.Fun_Banner_axes);
image(handles.Fun_banner)
%set(handles.axes_banner, 'Visible', 'off', 'Units', 'pixels');
set(handles.Fun_Banner_axes, 'Visible', 'off');


%______________________________________________________________
%
% Radio buttonS 
%______________________________________________________________
switch handles.MDL.ItrElasticDeform
	case 0
		set(handles.RB_Elastic_Deformation_OFF,	'value',	1);	% this will automatically set ON to 0
	case 1
		set(handles.RB_Elastic_Deformation_ON,	'value',	1);	% this will automatically set OFF to 0
end
switch handles.MDL.StepReduction
	case 0
		set(handles.RB_Disp_Refine_OFF,	'value',	1);	% this will automatically set ON to 0
	case 1
		set(handles.RB_Disp_Refine_ON,	'value',	1);	% this will automatically set OFF to 0
end
switch handles.MDL.DispMesurementSource
	case 0
		set(handles.RB_Disp_Mesurement_LBCB,	'value',	1);	
	case 1
		set(handles.RB_Disp_Mesurement_External,'value',	1);	
end




set(handles.RB_Source_Network,	'enable',	'on');
set(handles.RB_Source_File,	'enable',	'on');

switch handles.MDL.InputSource
	case 1	% file
		set(handles.RB_Source_Network,	'value',	0);
		set(handles.Edit_PortNo,	'enable',	'off');
		
		set(handles.RB_Source_File,	'value',	1);
		set(handles.Edit_File_Path,	'enable',	'on');
		set(handles.PB_Load_File,	'enable',	'on');
	case 2	% network
		set(handles.RB_Source_Network,	'value',	1);
		set(handles.Edit_PortNo,	'enable',	'on');
		
		set(handles.RB_Source_File,	'value',	0);
		set(handles.Edit_File_Path,	'enable',	'off');
		set(handles.PB_Load_File,	'enable',	'off');
end

set(handles.RB_Disp_Ctrl,	'enable',	'on');
set(handles.RB_Forc_Ctrl,	'enable',	'on');
set(handles.MixedControl_Static,	'enable',	'on');

switch handles.MDL.CtrlMode
	case 1	% displacement
		set(handles.RB_Disp_Ctrl,	'value',	1);
		
		set(handles.RB_Forc_Ctrl,	'value',	0);
		set(handles.MixedControl_Static,		'value',	0);
		
		set(handles.PM_Frc_Ctrl_DOF,	'enable',	'off');
		set(handles.Edit_K_low,		'enable',	'off');
		set(handles.Edit_Iteration_Ksec,'enable',	'off');
		set(handles.Edit_K_factor,	'enable',	'off');
		set(handles.Edit_Max_Itr,	'enable',	'off');
		
	case 2	% force
		set(handles.RB_Disp_Ctrl,	'value',	0);
		
		set(handles.RB_Forc_Ctrl,	'value',	1);
		set(handles.MixedControl_Static,		'value',	0);
		
		set(handles.PM_Frc_Ctrl_DOF,	'enable',	'on');
		set(handles.Edit_K_low,		'enable',	'on');
		set(handles.Edit_Iteration_Ksec,'enable',	'on');
		set(handles.Edit_K_factor,	'enable',	'on');
		set(handles.Edit_Max_Itr,	'enable',	'on');
		
	case 3 % Mixed Mode Static
		set(handles.RB_Disp_Ctrl,		'value',	0);
		set(handles.RB_Forc_Ctrl,		'value',	0);
		set(handles.MixedControl_Static,		'value',	1);
		
		set(handles.PM_Frc_Ctrl_DOF,		'enable',	'on');
		set(handles.Edit_K_low,			'enable',	'off');
		set(handles.Edit_Iteration_Ksec,	'enable',	'off');
		set(handles.Edit_K_factor,		'enable',	'off');
		set(handles.Edit_Max_Itr,		'enable',	'on');
end


%______________________________________________________________
%
% Popup menus
%______________________________________________________________

set(handles.PM_Frc_Ctrl_DOF,	'value',	handles.MDL.FrcCtrlDOF);
set(handles.PM_Model_Coord,	'value',	handles.MDL.ModelCoord);
set(handles.PM_LBCB_Coord,	'value',	handles.MDL.LBCBCoord);
set(handles.PM_Axis_X1,		'value',	handles.MDL.Axis_X1);
set(handles.PM_Axis_Y1,		'value',	handles.MDL.Axis_Y1);
set(handles.PM_Axis_X2,		'value',	handles.MDL.Axis_X2);
set(handles.PM_Axis_Y2,		'value',	handles.MDL.Axis_Y2);
set(handles.PM_Axis_X3,		'value',	handles.MDL.Axis_X3);
set(handles.PM_Axis_Y3,		'value',	handles.MDL.Axis_Y3);


set(handles.PM_Model_Coord,	'enable',	'on');
set(handles.PM_LBCB_Coord,	'enable',	'on');
%______________________________________________________________
%
% Check boxes
%______________________________________________________________

set(handles.CB_Noise_Compensation,'value',	handles.MDL.NoiseCompensation);

set(handles.CB_Disp_Limit,	'value',	handles.MDL.CheckLimit_Disp);
set(handles.CB_Disp_Inc,	'value',	handles.MDL.CheckLimit_DispInc);
set(handles.CB_Forc_Limit,	'value',	handles.MDL.CheckLimit_Forc);
set(handles.CB_MovingWindow,	'value',	handles.MDL.EnableMovingWin);
set(handles.CB_UpdateMonitor, 	'value', 	handles.MDL.UpdateMonitor);

if handles.MDL.UpdateMonitor
	set(handles.PM_Axis_X1,		'enable',	'on');
	set(handles.PM_Axis_Y1,		'enable',	'on');
	set(handles.PM_Axis_X2,		'enable',	'on');
	set(handles.PM_Axis_Y2,		'enable',	'on');
	set(handles.PM_Axis_X3,		'enable',	'on');
	set(handles.PM_Axis_Y3,		'enable',	'on');

	set(handles.CB_MovingWindow,	'enable',	'on');
	set(handles.Edit_Window_Size,	'enable',	'on');
else
	set(handles.PM_Axis_X1,		'enable',	'off');
	set(handles.PM_Axis_Y1,		'enable',	'off');
	set(handles.PM_Axis_X2,		'enable',	'off');
	set(handles.PM_Axis_Y2,		'enable',	'off');
	set(handles.PM_Axis_X3,		'enable',	'off');
	set(handles.PM_Axis_Y3,		'enable',	'off');

	set(handles.CB_MovingWindow,	'enable',	'off');
	set(handles.Edit_Window_Size,	'enable',	'off');
end

set(handles.CB_Disp_Limit,	'enable',	'on');
set(handles.CB_Disp_Inc,	'enable',	'on');
set(handles.CB_Forc_Limit,	'enable',	'on');
set(handles.CB_MovingWindow,	'enable',	'on');

%______________________________________________________________
%
% Edit boxes
%______________________________________________________________

set(handles.Edit_PortNo,		'string',	num2str(handles.MDL.InputPort));		
set(handles.Edit_File_Path,		'string',	handles.MDL.InputFile);
set(handles.Edit_LBCB_IP,		'string',	num2str(handles.MDL.IP));
set(handles.Edit_LBCB_Port,		'string',	num2str(handles.MDL.Port));
set(handles.Edit_LBCB_IP,       	'enable',	'on');
set(handles.Edit_LBCB_Port,     	'enable',	'on');

set(handles.Edit_K_low,			'string',	num2str(handles.MDL.K_vert_ini));
set(handles.Edit_Iteration_Ksec,	'string',	num2str(handles.MDL.secK_eval_itr));
set(handles.Edit_K_factor,		'string',	num2str(handles.MDL.secK_factor));
set(handles.Edit_Max_Itr,		'string',	num2str(handles.MDL.max_itr));

set(handles.Edit_Disp_SF,		'string',	num2str(handles.MDL.ScaleF(1)));
set(handles.Edit_Rotation_SF,		'string',	num2str(handles.MDL.ScaleF(2)));
set(handles.Edit_Forc_SF,		'string',	num2str(handles.MDL.ScaleF(3)));
set(handles.Edit_Moment_SF,		'string',	num2str(handles.MDL.ScaleF(4)));

set(handles.Edit_DLmin_DOF1,		'string',	num2str(handles.MDL.CAP_D_min(1)));
set(handles.Edit_DLmin_DOF2,		'string',	num2str(handles.MDL.CAP_D_min(2)));
set(handles.Edit_DLmin_DOF3,		'string',	num2str(handles.MDL.CAP_D_min(3)));
set(handles.Edit_DLmin_DOF4,		'string',	num2str(handles.MDL.CAP_D_min(4)));
set(handles.Edit_DLmin_DOF5,		'string',	num2str(handles.MDL.CAP_D_min(5)));
set(handles.Edit_DLmin_DOF6,		'string',	num2str(handles.MDL.CAP_D_min(6)));

set(handles.Edit_DLmax_DOF1,		'string',	num2str(handles.MDL.CAP_D_max(1)));
set(handles.Edit_DLmax_DOF2,		'string',	num2str(handles.MDL.CAP_D_max(2)));
set(handles.Edit_DLmax_DOF3,		'string',	num2str(handles.MDL.CAP_D_max(3)));
set(handles.Edit_DLmax_DOF4,		'string',	num2str(handles.MDL.CAP_D_max(4)));
set(handles.Edit_DLmax_DOF5,		'string',	num2str(handles.MDL.CAP_D_max(5)));
set(handles.Edit_DLmax_DOF6,		'string',	num2str(handles.MDL.CAP_D_max(6)));

set(handles.Edit_DLinc_DOF1,		'string',	num2str(handles.MDL.TGT_D_inc(1)));
set(handles.Edit_DLinc_DOF2,		'string',	num2str(handles.MDL.TGT_D_inc(2)));
set(handles.Edit_DLinc_DOF3,		'string',	num2str(handles.MDL.TGT_D_inc(3)));
set(handles.Edit_DLinc_DOF4,		'string',	num2str(handles.MDL.TGT_D_inc(4)));
set(handles.Edit_DLinc_DOF5,		'string',	num2str(handles.MDL.TGT_D_inc(5)));
set(handles.Edit_DLinc_DOF6,		'string',	num2str(handles.MDL.TGT_D_inc(6)));

set(handles.Edit_FLmin_DOF1,		'string',	num2str(handles.MDL.CAP_F_min(1)));
set(handles.Edit_FLmin_DOF2,		'string',	num2str(handles.MDL.CAP_F_min(2)));
set(handles.Edit_FLmin_DOF3,		'string',	num2str(handles.MDL.CAP_F_min(3)));
set(handles.Edit_FLmin_DOF4,		'string',	num2str(handles.MDL.CAP_F_min(4)));
set(handles.Edit_FLmin_DOF5,		'string',	num2str(handles.MDL.CAP_F_min(5)));
set(handles.Edit_FLmin_DOF6,		'string',	num2str(handles.MDL.CAP_F_min(6)));

set(handles.Edit_FLmax_DOF1,		'string',	num2str(handles.MDL.CAP_F_max(1)));
set(handles.Edit_FLmax_DOF2,		'string',	num2str(handles.MDL.CAP_F_max(2)));
set(handles.Edit_FLmax_DOF3,		'string',	num2str(handles.MDL.CAP_F_max(3)));
set(handles.Edit_FLmax_DOF4,		'string',	num2str(handles.MDL.CAP_F_max(4)));
set(handles.Edit_FLmax_DOF5,		'string',	num2str(handles.MDL.CAP_F_max(5)));
set(handles.Edit_FLmax_DOF6,		'string',	num2str(handles.MDL.CAP_F_max(6)));

set(handles.Edit_Dtol_DOF1,		'string',	num2str(handles.MDL.DispTolerance(1)));
set(handles.Edit_Dtol_DOF2,		'string',	num2str(handles.MDL.DispTolerance(2)));
set(handles.Edit_Dtol_DOF3,		'string',	num2str(handles.MDL.DispTolerance(3)));
set(handles.Edit_Dtol_DOF4,		'string',	num2str(handles.MDL.DispTolerance(4)));
set(handles.Edit_Dtol_DOF5,		'string',	num2str(handles.MDL.DispTolerance(5)));
set(handles.Edit_Dtol_DOF6,		'string',	num2str(handles.MDL.DispTolerance(6)));

set(handles.Edit_Dsub_DOF1,		'string',	num2str(handles.MDL.DispIncMax(1)));
set(handles.Edit_Dsub_DOF2,		'string',	num2str(handles.MDL.DispIncMax(2)));
set(handles.Edit_Dsub_DOF3,		'string',	num2str(handles.MDL.DispIncMax(3)));
set(handles.Edit_Dsub_DOF4,		'string',	num2str(handles.MDL.DispIncMax(4)));
set(handles.Edit_Dsub_DOF5,		'string',	num2str(handles.MDL.DispIncMax(5)));
set(handles.Edit_Dsub_DOF6,		'string',	num2str(handles.MDL.DispIncMax(6)));

set(handles.Edit_Window_Size,		'string',	num2str(handles.MDL.MovingWinWidth));
set(handles.Edit_Sample_Size,		'string',	num2str(handles.MDL.NumSample));

%______________________________________________________________
%
% Static Text 
%______________________________________________________________

set(handles.TXT_Model_Tgt_Step, 	'string',	sprintf('Step #: %03d',0));
set(handles.TXT_Model_Mes_Step, 	'string',	sprintf('Step #: %03d',0));
set(handles.TXT_LBCB_Tgt_Itr, 		'string',	sprintf('Iteration #: %03d',0));
set(handles.TXT_LBCB_Mes_Itr, 		'string',	sprintf('Iteration #: %03d',0));

tmp_a = sprintf('%+12.5f',0);
tmp1 = {tmp_a,tmp_a,tmp_a,tmp_a,tmp_a,tmp_a};
tmp_b = sprintf('        -     ');
tmp2 = {tmp_b,tmp_b,tmp_b,tmp_b,tmp_b,tmp_b};

set(handles.TXT_Disp_T_Model,		'string',	tmp1);
set(handles.TXT_Disp_M_Model,		'string',	tmp1);
set(handles.TXT_Forc_M_Model,		'string',	tmp1);
set(handles.TXT_Disp_M_LBCB,		'string',	tmp1);
set(handles.TXT_Forc_M_LBCB,		'string',	tmp1);
switch handles.MDL.CtrlMode
	case 1	% displacement control
		set(handles.TXT_Disp_T_LBCB,		'string',	tmp1);
		set(handles.TXT_Forc_T_LBCB,		'string',	tmp2);
	case 2	% force control
		tmp1(handles.MDL.FrcCtrlDOF) = {tmp_b};
		tmp2(handles.MDL.FrcCtrlDOF) = {tmp_a};
		set(handles.TXT_Disp_T_LBCB,		'string',	tmp1);
		set(handles.TXT_Forc_T_LBCB,		'string',	tmp2);
end

%______________________________________________________________
%
% Graphics 
%______________________________________________________________

load Resources;

axes(handles.axes_model);
switch handles.MDL.ModelCoord
	case 1
		image(ModelCoord01); % Read the image file banner.bmp)		
	case 2
		image(ModelCoord02); % Read the image file banner.bmp)		
end
set(handles.axes_model, 'Visible', 'off');

axes(handles.axes_LBCB);
switch handles.MDL.LBCBCoord
	case 1
		image(LBCB_R_Coord01); % Read the image file banner.bmp
	case 2
		image(LBCB_R_Coord02); % Read the image file banner.bmp
	case 3
		image(LBCB_R_Coord03); % Read the image file banner.bmp
	case 4
		image(LBCB_R_Coord04); % Read the image file banner.bmp
end
set(handles.axes_LBCB, 'Visible', 'off');
%handles = SetTransMCoord(handles);

axes(handles.axes_monitor);					% Obtain handle of figure box
x1 = 0;		y1 = 0;						% Initial values of plots
x2 = 0;		y2 = 0;
x3 = 0;		y3 = 0;
h_plot = plot(x1,y1,'k',x2,y2,'b',x3,y3,'r',0,0,'k.',0,0,'b.',0,0,'r.');		% handles to plot
legend('(X1, Y1)','(X2, Y2)','(X3, Y3)',2);				% legend
handles.h_plot11 = h_plot(1);					% obtain handle of the plot 1, x1, y1
handles.h_plot12 = h_plot(2);					% obtain handle of the plot 2, x2, y2
handles.h_plot13 = h_plot(3);					% obtain handle of the plot 3, x3, y3
handles.h_plot14 = h_plot(4);					% obtain handle of the plot 1, x1, y1 (last point)
handles.h_plot15 = h_plot(5);					% obtain handle of the plot 2, x2, y2 (last point)
handles.h_plot16 = h_plot(6);					% obtain handle of the plot 3, x3, y3 (last point)
set(h_plot(4),'markersize',15);
set(h_plot(5),'markersize',15);
set(h_plot(6),'markersize',15);


%______________________________________________________________
%
% Buttons
%______________________________________________________________

set(handles.PB_Load_Config ,	'enable',	'on');
set(handles.PB_Load_Default,	'enable',	'on');
set(handles.PB_Save_Config ,	'enable',	'on');
set(handles.PB_Pause,		'enable',	'off');

set(handles.PB_LBCB_Disconnect,	'enable',	'off');
set(handles.PB_LBCB_Connect,	'enable',	'on');

set(handles.Edit_DLmin_DOF1,	'enable',	'on');
set(handles.Edit_DLmin_DOF2,	'enable',	'on');
set(handles.Edit_DLmin_DOF3,	'enable',	'on');
set(handles.Edit_DLmin_DOF4,	'enable',	'on');
set(handles.Edit_DLmin_DOF5,	'enable',	'on');
set(handles.Edit_DLmin_DOF6,	'enable',	'on');

set(handles.Edit_DLmax_DOF1,	'enable',	'on');
set(handles.Edit_DLmax_DOF2,	'enable',	'on');
set(handles.Edit_DLmax_DOF3,	'enable',	'on');
set(handles.Edit_DLmax_DOF4,	'enable',	'on');
set(handles.Edit_DLmax_DOF5,	'enable',	'on');
set(handles.Edit_DLmax_DOF6,	'enable',	'on');

set(handles.Edit_DLinc_DOF1,	'enable',	'on');
set(handles.Edit_DLinc_DOF2,	'enable',	'on');
set(handles.Edit_DLinc_DOF3,	'enable',	'on');
set(handles.Edit_DLinc_DOF4,	'enable',	'on');
set(handles.Edit_DLinc_DOF5,	'enable',	'on');
set(handles.Edit_DLinc_DOF6,	'enable',	'on');

set(handles.Edit_FLmin_DOF1,	'enable',	'on');
set(handles.Edit_FLmin_DOF2,	'enable',	'on');
set(handles.Edit_FLmin_DOF3,	'enable',	'on');
set(handles.Edit_FLmin_DOF4,	'enable',	'on');
set(handles.Edit_FLmin_DOF5,	'enable',	'on');
set(handles.Edit_FLmin_DOF6,	'enable',	'on');

set(handles.Edit_FLmax_DOF1,	'enable',	'on');
set(handles.Edit_FLmax_DOF2,	'enable',	'on');
set(handles.Edit_FLmax_DOF3,	'enable',	'on');
set(handles.Edit_FLmax_DOF4,	'enable',	'on');
set(handles.Edit_FLmax_DOF5,	'enable',	'on');
set(handles.Edit_FLmax_DOF6,	'enable',	'on');


set(handles.Edit_Disp_SF,	'enable',	'on');
set(handles.Edit_Rotation_SF,	'enable',	'on');
set(handles.Edit_Forc_SF,	'enable',	'on');
set(handles.Edit_Moment_SF,	'enable',	'on');


%______________________________________________________________
%
% Class member variables
%______________________________________________________________
handles.MDL.M_Disp        = zeros(6,1);                       % Measured displacement at each step, Num_DOFx1
handles.MDL.M_Forc        = zeros(6,1);                       % Measured force at each step, Num_DOFx1
handles.MDL.T_Disp_0      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
handles.MDL.T_Disp        = zeros(6,1);                       % Target displacement, Num_DOFx1
handles.MDL.T_Forc_0      = zeros(6,1);                       % Previous step's target displacement, Num_DOFx1
handles.MDL.T_Forc        = zeros(6,1);                       % Target displacement, Num_DOFx1
handles.MDL.Comm_obj      = {};                       % communication object

% Following six variables are only used GUI mode to plot history of data
handles.MDL.tDisp_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.tForc_history     = zeros(10000,6);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.mDisp_history     = zeros(10000,6);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.mForc_history     = zeros(10000,6);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
% For SimCOr Step
handles.MDL.tDisp_history_SC  = zeros(10000,6);
handles.MDL.T_Disp_SC_his     = zeros(6,1);

handles.MDL.TransID           = '';                  % Transaction ID
handles.MDL.curStep       	= 0;                        % Current step number for this module
handles.MDL.totStep       	= 0;                        % Total number of steps to be tested
handles.MDL.curState      	= 0;                        % Current state of simulation

StatusIndicator(handles,0);

%______________________________________________________________
%
% Read external measurement configuration
%______________________________________________________________

Ext_Measure_Config;
handles.MDL.Aux_Config.T            =  Aux_Config.T;
handles.MDL.Aux_Config.sensitivity  =  Aux_Config.sensitivity;
handles.MDL.Aux_Config.S1b          =  Aux_Config.S1b;
handles.MDL.Aux_Config.S1p          =  Aux_Config.S1p;
handles.MDL.Aux_Config.S2b          =  Aux_Config.S2b;
handles.MDL.Aux_Config.S2p          =  Aux_Config.S2p;
handles.MDL.Aux_Config.S3b          =  Aux_Config.S3b;
handles.MDL.Aux_Config.S3p          =  Aux_Config.S3p;
handles.MDL.Aux_Config.S4b          =  Aux_Config.S4b;
handles.MDL.Aux_Config.S4p          =  Aux_Config.S4p;
handles.MDL.Aux_Config.Off_SPCM     =  Aux_Config.Off_SPCM;
handles.MDL.Aux_Config.Off_MCTR     =  Aux_Config.Off_MCTR;

% SJKIM OCT01-2007
handles.MDL.Aux_Config.InitialLength =  Aux_Config.InitialLength;

%______________________________________________________________
%
% Read AUXModule;
%______________________________________________________________


handles.AUX = MDL_AUX;

AUX_Config;

if Num_Aux==0
	set(handles.AUX_Module_Select,	'enable',	'off');	% this will automatically set OFF to 0
	set(handles.AUX_Connect,	'enable',	'off');
	set(handles.AUX_Disconnect,	'enable',	'off');
else
	for i=1:length(AUX)
		handles.AUX(i)          = MDL_AUX ;    % Create objects of MDL_RF
		handles.AUX(i).URL      = AUX(i).URL;      
		handles.AUX(i).protocol = AUX(i).protocol; 
		handles.AUX(i).name     = AUX(i).name     ;
		handles.AUX(i).Command  = AUX(i).Command  ;
	end

	% Initialize the AUX Modules 
	handles.AUX= initialize(handles.AUX);
	
	% AUX module
	set(handles.AUX_Module_Select,	'value',	1);	% this will automatically set OFF to 0
	set(handles.AUX_Disconnect,	'enable',	'off');
end
