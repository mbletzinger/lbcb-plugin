function handles = Plugin_Initialize(handles, config)


if config == 1		% default
	% 10-25-2007 
	questResult = questdlg('Please backup previous simulation results if necessary. All previous files will be deleted.', 'New Simulation','Okay','Cancel','Okay');
	
	DateStr=clock;
	TestDate_Str=sprintf('%04d%02d%02d%02d%02d',DateStr(1:5));
	
	if strcmp(questResult,'Okay')
		Plugin_Initialize_CreateFile (TestDate_Str);
	else
	  return;
	end 
	
	%
	handles.MDL = MDL_LBCB;
	% To save data file with date string
	handles.DataSave_TestDate_Str=TestDate_Str;
	%handles.MDL.TestDate_Str=TestDate_Str;

elseif config == 2	% use current.
	
end
%
% image file
Fun_banner = imread('CABER_Banner.bmp'); % Read the image file banner.bmp
axes(handles.CABER_Banner);
image(Fun_banner);
set(handles.CABER_Banner, 'Visible', 'off');

StatusTextOut = {...
  ' LBCB Plugin v 2.0',...
  ' -------------------------------------------',...
  ' Interface between UI-SimCor and LBCB Operation Manager',...
  ' This version is customized for CABER project',...
  ' by Sung Jig Kim, Curtis Holub, and Oh-Sung Kwon',...
  ' University of Illinois at Urbana-Champaign'};

set(handles.ET_GUI_Process_Text,'String',StatusTextOut);
%______________________________________________________________
%
% Radio buttonS 
%______________________________________________________________

set(handles.RB_Monitor_Coord_Model, 'value' ,1);
set(handles.RB_Monitor_Coord_LBCB,  'value' ,0);
set(handles.RB_PlotData_ModelStep,     'value' ,0);
set(handles.RB_PlotData_LBCBStep,      'value' ,1);

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
		
		set(handles.PM_FileInput_Select,    'enable', 'on');
		set(handles.Edit_FileInput_Add_Num, 'enable', 'on');
		set(handles.PB_FileInput_Add,       'enable', 'on');
		set(handles.PB_Input_Plot,          'enable', 'on');
		
	case 2	% network
		set(handles.RB_Source_Network,	'value',	1);
		set(handles.Edit_PortNo,	'enable',	'on');
		
		set(handles.RB_Source_File,	'value',	0);
		set(handles.Edit_File_Path,	'enable',	'off');
		set(handles.PB_Load_File,	'enable',	'off');
		
		set(handles.PM_FileInput_Select,    'enable', 'off');
		set(handles.Edit_FileInput_Add_Num, 'enable', 'off');
		set(handles.PB_FileInput_Add,       'enable', 'off');
		set(handles.PB_Input_Plot,          'enable', 'off');
end

set(handles.RB_Disp_Ctrl,	'enable',	'on');
set(handles.RB_Forc_Ctrl,	'enable',	'on');  
set(handles.RB_MixedControl_Static,	'enable',	'on');

%handles.MDL.LBCB_FrcCtrlDOF=zeros (6,1);  % 0 for displacement control, 1 for force control;

switch handles.MDL.CtrlMode
	case 1	% displacement
		set(handles.RB_Disp_Ctrl,	        'value',	1);
		set(handles.RB_Forc_Ctrl,	        'value',	0);
		set(handles.RB_MixedControl_Static,	'value',	0);

		set(handles.PM_Frc_Ctrl_DOF,	'enable',	'off');
		set(handles.Edit_K_low,		'enable',	'off');
		set(handles.Edit_Iteration_Ksec,'enable',	'off');
		set(handles.Edit_K_factor,	'enable',	'off');
		
	case 2	% force
		set(handles.RB_Disp_Ctrl,	        'value',	0);
		set(handles.RB_Forc_Ctrl,	        'value',	1);
		set(handles.RB_MixedControl_Static,	'value',	0);

		set(handles.PM_Frc_Ctrl_DOF,	'enable',	'on');
		set(handles.Edit_K_low,		'enable',	'on');
		set(handles.Edit_Iteration_Ksec,'enable',	'on');
		set(handles.Edit_K_factor,	'enable',	'on');   
		handles.MDL.LBCB_FrcCtrlDOF=zeros (6,1);
		handles.MDL.LBCB_FrcCtrlDOF(handles.MDL.FrcCtrlDOF) = 1;
		
	case 3	% Static module
		set(handles.RB_Disp_Ctrl,	        'value',	0);
		set(handles.RB_Forc_Ctrl,	        'value',	0);
		set(handles.RB_MixedControl_Static,	'value',	1);

		set(handles.PM_Frc_Ctrl_DOF,	'enable',	'off');
		set(handles.Edit_K_low,		'enable',	'off');
		set(handles.Edit_Iteration_Ksec,'enable',	'off');
		set(handles.Edit_K_factor,	'enable',	'off');
		
end
set(handles.Edit_Max_Itr,	'enable',	'on');

UpdateGUI_FontColor (handles, 1);


% User Input Option
set(handles.UserInputOption_On,  'value', 0);
set(handles.UserInputOption_Off, 'value', 1);
set(handles.User_Cmd_Txt_Dx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Dz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Ry, 'enable', 'off');              
set(handles.User_Cmd_Txt_Rz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fx, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fy, 'enable', 'off');              
set(handles.User_Cmd_Txt_Fz, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mx, 'enable', 'off');              
set(handles.User_Cmd_Txt_My, 'enable', 'off');              
set(handles.User_Cmd_Txt_Mz, 'enable', 'off');              
                                                            
set(handles.STR_UserInput_PreviousTarget,             'enable', 'off');
set(handles.UserInputOption_M_AdjustedCMD, 'value', 0);     
set(handles.UserInputOption_M_AdjustedCMD, 'enable', 'off');   
set(handles.STXT_AdjustedCMD, 'enable', 'off');

set(handles.PB_UserCMD_Pre_DOF1,  'string',	sprintf('%+12.3f',0));
set(handles.PB_UserCMD_Pre_DOF2,  'string',	sprintf('%+12.3f',0));
set(handles.PB_UserCMD_Pre_DOF3,  'string',	sprintf('%+12.3f',0));
set(handles.PB_UserCMD_Pre_DOF4,  'string',	sprintf('%+12.3f',0));
set(handles.PB_UserCMD_Pre_DOF5,  'string',	sprintf('%+12.3f',0));
set(handles.PB_UserCMD_Pre_DOF6,  'string',	sprintf('%+12.3f',0));

set(handles.PB_UserCMD_Pre_DOF1,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF2,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF3,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF4,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF5,        'enable', 'off');
set(handles.PB_UserCMD_Pre_DOF6,        'enable', 'off');

set(handles.PB_UserCMD_Decrease_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Decrease_DOF6,   'enable', 'off');

set(handles.PB_UserCMD_Increase_DOF1,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF2,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF3,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF4,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF5,   'enable', 'off');
set(handles.PB_UserCMD_Increase_DOF6,   'enable', 'off');

set(handles.ED_UserCMD_Increment_DOF1,  'string',	num2str(handles.MDL.DispTolerance(1)));
set(handles.ED_UserCMD_Increment_DOF2,  'string',	num2str(handles.MDL.DispTolerance(2)));
set(handles.ED_UserCMD_Increment_DOF3,  'string',	num2str(handles.MDL.DispTolerance(3)));
set(handles.ED_UserCMD_Increment_DOF4,  'string',	num2str(handles.MDL.DispTolerance(4)));
set(handles.ED_UserCMD_Increment_DOF5,  'string',	num2str(handles.MDL.DispTolerance(5)));
set(handles.ED_UserCMD_Increment_DOF6,  'string',	num2str(handles.MDL.DispTolerance(6)));

set(handles.ED_UserCMD_Increment_DOF1,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF2,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF3,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF4,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF5,  'enable', 'off');
set(handles.ED_UserCMD_Increment_DOF6,  'enable', 'off');

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

set(handles.PM_Axis_X1,		'enable',	'on');
set(handles.PM_Axis_Y1,		'enable',	'on');
set(handles.PM_Axis_X2,		'enable',	'on');
set(handles.PM_Axis_Y2,		'enable',	'on');
set(handles.PM_Axis_X3,		'enable',	'on');
set(handles.PM_Axis_Y3,		'enable',	'on');

set(handles.CB_MovingWindow,	'enable',	'on');
set(handles.Edit_Window_Size,	'enable',	'on');

set(handles.CB_Disp_Limit,	'enable',	'on');
set(handles.CB_Disp_Inc,	'enable',	'on');
set(handles.CB_Forc_Limit,	'enable',	'on');
set(handles.CB_MovingWindow,	'enable',	'on');

% Static Modlue
if get(handles.RB_MixedControl_Static,	'value')
	set(handles.CB_MixedCtrl_Fx,	'enable',	'on');
	set(handles.CB_MixedCtrl_Fy,	'enable',	'on');
	set(handles.CB_MixedCtrl_Fz,	'enable',	'on');
	set(handles.CB_MixedCtrl_Mx,	'enable',	'on');
	set(handles.CB_MixedCtrl_My,	'enable',	'on');
	set(handles.CB_MixedCtrl_Mz,	'enable',	'on');
else
	set(handles.CB_MixedCtrl_Fx,	'enable',	'off');
	set(handles.CB_MixedCtrl_Fy,	'enable',	'off');
	set(handles.CB_MixedCtrl_Fz,	'enable',	'off');
	set(handles.CB_MixedCtrl_Mx,	'enable',	'off');
	set(handles.CB_MixedCtrl_My,	'enable',	'off');
	set(handles.CB_MixedCtrl_Mz,	'enable',	'off');
end

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

%
handles.MDL.DispScale(1:3)=handles.MDL.ScaleF(1);
handles.MDL.DispScale(4:6)=handles.MDL.ScaleF(2);
handles.MDL.ForcScale(1:3)=handles.MDL.ScaleF(3);
handles.MDL.ForcScale(4:6)=handles.MDL.ScaleF(4);
	
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


set(handles.User_Cmd_DOF1,  'string' , sprintf('%+12.3f',0));
set(handles.User_Cmd_DOF2,  'string' , sprintf('%+12.3f',0));
set(handles.User_Cmd_DOF3,  'string' , sprintf('%+12.3f',0));
set(handles.User_Cmd_DOF4,  'string' , sprintf('%+12.3f',0));
set(handles.User_Cmd_DOF5,  'string' , sprintf('%+12.3f',0));
set(handles.User_Cmd_DOF6,  'string' , sprintf('%+12.3f',0));
	                           
if get(handles.UserInputOption_On,  'value');
	set(handles.User_Cmd_DOF1,  'enable' , 'on');
	set(handles.User_Cmd_DOF2,  'enable' , 'on');
	set(handles.User_Cmd_DOF3,  'enable' , 'on');
	set(handles.User_Cmd_DOF4,  'enable' , 'on');
	set(handles.User_Cmd_DOF5,  'enable' , 'on');
	set(handles.User_Cmd_DOF6,  'enable' , 'on');
else
	set(handles.User_Cmd_DOF1,  'enable' , 'off');
	set(handles.User_Cmd_DOF2,  'enable' , 'off');
	set(handles.User_Cmd_DOF3,  'enable' , 'off');
	set(handles.User_Cmd_DOF4,  'enable' , 'off');
	set(handles.User_Cmd_DOF5,  'enable' , 'off');
	set(handles.User_Cmd_DOF6,  'enable' , 'off');
end                                          

for i=1:length(handles.MDL.InputFilePath)
	if isempty(handles.MDL.InputFilePath{i})~=1
		if strcmp(handles.MDL.InputFilePath{i},handles.MDL.InputFile)
			set(handles.Edit_FileInput_Add_Num, 'string',sprintf('%02d',i));
			break;
		end
	end
end

% Pop up menu
Input_Num=length(handles.MDL.InputFilePath);
InputFile_List=get (handles.PM_FileInput_Select, 'string');
ModifiedList=cell(Input_Num+1,1);
for i=1:length(InputFile_List)
	ModifiedList{i}=InputFile_List{i};
end
for i=2:Input_Num+1
	if isempty(ModifiedList{i})
		ModifiedList{i}=sprintf('Input %02d: Empty',i-1);
	else
		ModifiedList{i}=sprintf('Input %02d: %s', i-1, handles.MDL.InputFilePath{i-1});
	end
end
set (handles.PM_FileInput_Select, 'string',ModifiedList);
set (handles.PM_FileInput_Select, 'UserData', handles.MDL.InputFilePath);
%                                       [SimulationIndex, CurrentStep];
set(handles.PB_Input_Plot, 'UserData', [0 0]);
%______________________________________________________________
%
% Static Text 
%______________________________________________________________

%set(handles.TXT_Model_Tgt_Step, 	'string',	sprintf('Step #: %03d',0));
%set(handles.TXT_Model_Mes_Step, 	'string',	sprintf('Step #: %03d',0));
%set(handles.TXT_LBCB_Tgt_Itr, 		'string',	sprintf('Iteration #: %03d',0));
%set(handles.TXT_LBCB_Mes_Itr, 		'string',	sprintf('Iteration #: %03d',0));

tmp_a = sprintf('%+12.7f',0);
tmp1 = {tmp_a,tmp_a,tmp_a,tmp_a,tmp_a,tmp_a};
tmp_b = sprintf('     -     ');
tmp2 = {tmp_b,tmp_b,tmp_b,tmp_b,tmp_b,tmp_b};
tmp_c = sprintf('%+12.9f',0);
tmp3 = {tmp_c,tmp_c,tmp_c,tmp_c,tmp_c,tmp_c};
tmp_d = sprintf('%+12.3f',0);
tmp4 = {tmp_d,tmp_d,tmp_d,tmp_d,tmp_d,tmp_d};
tmp_e = sprintf('%+12.6f',0);
tmp5 = {tmp_e,tmp_e,tmp_e,tmp_e,tmp_e,tmp_e};

set(handles.TXT_Disp_T_Model,		'string',	tmp1);
set(handles.TXT_Forc_T_Model,		'string',	tmp2);
set(handles.TXT_Disp_M_Model,		'string',	tmp1);
set(handles.TXT_Forc_M_Model,		'string',	tmp4);
set(handles.TXT_Disp_Model_Error_Dx, 'string', tmp_c);
set(handles.TXT_Disp_Model_Error_Dy, 'string', tmp_c);
set(handles.TXT_Disp_Model_Error_Dz, 'string', tmp_c);
set(handles.TXT_Disp_Model_Error_Rx, 'string', tmp_c);
set(handles.TXT_Disp_Model_Error_Ry, 'string', tmp_c);
set(handles.TXT_Disp_Model_Error_Rz, 'string', tmp_c);
set(handles.TXT_Force_Model_Error,   'string', tmp5 );


set(handles.TXT_Disp_M_LBCB,		'string',	tmp1);
set(handles.TXT_Forc_M_LBCB,		'string',	tmp4);

set(handles.TXT_Disp_M_LBCB_Error,	'string',	tmp3);
set(handles.TXT_Forc_M_LBCB_Error,	'string',	tmp5);

switch handles.MDL.CtrlMode
	case 1	% displacement control 
		set(handles.TXT_Disp_T_LBCB,		'string',	tmp1);
		set(handles.TXT_Forc_T_LBCB,		'string',	tmp2);
		%set(handles.TXT_Disp_Next_T_LBCB,	'string',	tmp1);
		%set(handles.TXT_Forc_Next_T_LBCB,	'string',	tmp2);
	case 2	% force control
		tmp1(handles.MDL.FrcCtrlDOF) = {tmp_b};
		tmp2(handles.MDL.FrcCtrlDOF) = {tmp_a};
		set(handles.TXT_Disp_T_LBCB,		'string',	tmp1);
		set(handles.TXT_Forc_T_LBCB,		'string',	tmp2);
		%set(handles.TXT_Disp_Next_T_LBCB,	'string',	tmp1);
		%set(handles.TXT_Forc_Next_T_LBCB,	'string',	tmp2);
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

% For Model Step Plot
handles.MDL.Model_tDisp_history     = zeros(10000,6); 
handles.MDL.Model_tForc_history     = zeros(10000,6); 
handles.MDL.Model_mDisp_history     = zeros(10000,6); 
handles.MDL.Model_mForc_history     = zeros(10000,6); 
handles.MDL.Model_tDisp_history_SC  = zeros(10000,6); 


handles.MDL.TransID           = '';                  % Transaction ID
handles.MDL.curStep       	= 0;                        % Current step number for this module
handles.MDL.totStep       	= 0;                        % Total number of steps to be tested
handles.MDL.curState      	= 0;                        % Current state of simulation

StatusIndicator(handles,0);
% For Transformation Matrix
handles = SetTransMCoord(handles); 
handles.MDL.Model_FrcCtrlDOF=abs(inv(handles.MDL.TransM)*handles.MDL.LBCB_FrcCtrlDOF);
% For error check at readGUI
handles.error_check=0;
%______________________________________________________________
%
% Load LBCBPlugin_Config
%______________________________________________________________

LBCBPlugin_Config;

% Read external measurement configuration
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

% Read AUXModule

handles.AUX = MDL_AUX;
handles.Num_AuxModule=Num_Aux;

if handles.Num_AuxModule==0
	set(handles.AUXModule_Connect,	    'enable',	'off');
	%set(handles.PB_LBCB_Connect,	'enable',	'on');
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
	
	AUX_Initialized=zeros(length(AUX),1);
	for i=1:length(AUX)
		AUX_Initialized(i)=handles.AUX(i).Initialized;
	end
	
	set(handles.AUXModule_Connect, 'UserData',AUX_Initialized); 
	
	% AUX module
	set(handles.AUXModule_Connect,	     'enable',	'on');	% this will automatically set OFF to 0
	% Disable LBCB connection button
	%set(handles.PB_LBCB_Connect,	'enable',	'on');
end
set(handles.AUXModule_Disconnect,	'enable',	'off');


