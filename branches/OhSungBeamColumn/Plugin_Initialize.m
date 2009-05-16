function handles = Plugin_Initialize(handles, config)

if config == 1		% default
	handles.MDL = MDL_LBCB;
elseif config == 2	% use current.
	
end


set(handles.Edit_LBCB_IP_1,   'string',   num2str(handles.MDL.IP_1));
%set(handles.Edit_LBCB_IP_2,   'string',   num2str(handles.MDL.IP_2));
set(handles.Edit_LBCB_Port_1, 'string', handles.MDL.Port_1);
%set(handles.Edit_LBCB_Port_2, 'string', handles.MDL.Port_2);
%%%%%
% Modified by Sung Jig Kim, 05/02/2009
set(handles.Edit_LBCB_NetworkWaitTime, 'string', handles.MDL.NetworkWaitTime);
%%%%


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


%______________________________________________________________
%
% Popup menus
%______________________________________________________________

set(handles.PM_Axis_X1,		'value',	handles.MDL.Axis_X1);
set(handles.PM_Axis_Y1,		'value',	handles.MDL.Axis_Y1);
set(handles.PM_Axis_X2,		'value',	handles.MDL.Axis_X2);
set(handles.PM_Axis_Y2,		'value',	handles.MDL.Axis_Y2);
set(handles.PM_Axis_X3,		'value',	handles.MDL.Axis_X3);
set(handles.PM_Axis_Y3,		'value',	handles.MDL.Axis_Y3);
set(handles.PM_Axis_X4,		'value',	handles.MDL.Axis_X4);
set(handles.PM_Axis_Y4,		'value',	handles.MDL.Axis_Y4);


%______________________________________________________________
%
% Check boxes
%______________________________________________________________

set(handles.CB_Noise_Compensation,'value',	handles.MDL.NoiseCompensation);

set(handles.CB_Disp_Limit1,	'value',	handles.MDL.CheckLimit_Disp1);
set(handles.CB_Disp_Inc1,	'value',	handles.MDL.CheckLimit_DispInc1);
set(handles.CB_Forc_Limit1,	'value',	handles.MDL.CheckLimit_Forc1);
set(handles.CB_Disp_Limit2,	'value',	handles.MDL.CheckLimit_Disp2);
set(handles.CB_Disp_Inc2,	'value',	handles.MDL.CheckLimit_DispInc2);
set(handles.CB_Forc_Limit2,	'value',	handles.MDL.CheckLimit_Forc2);

set(handles.CB_MovingWindow,	'value',	handles.MDL.EnableMovingWin);

	set(handles.PM_Axis_X1,		'enable',	'on');
	set(handles.PM_Axis_Y1,		'enable',	'on');
	set(handles.PM_Axis_X2,		'enable',	'on');
	set(handles.PM_Axis_Y2,		'enable',	'on');
	set(handles.PM_Axis_X3,		'enable',	'on');
	set(handles.PM_Axis_Y3,		'enable',	'on');

	set(handles.CB_MovingWindow,	'enable',	'on');
	set(handles.Edit_Window_Size,	'enable',	'on');

set(handles.CB_Disp_Limit1,	'enable',	'on');
set(handles.CB_Disp_Inc1,	'enable',	'on');
set(handles.CB_Forc_Limit1,	'enable',	'on');
set(handles.CB_Disp_Limit2,	'enable',	'on');
set(handles.CB_Disp_Inc2,	'enable',	'on');
set(handles.CB_Forc_Limit2,	'enable',	'on');

set(handles.CB_MovingWindow,	'enable',	'on');


%%% if handles.MDL.CheckLimit_DispTot == 0
%%% 	set(handles.Edit_DL_DOF1,	'enable',	'off');
%%% 	set(handles.Edit_DL_DOF2,	'enable',	'off');
%%% 	set(handles.Edit_DL_DOF3,	'enable',	'off');
%%% 	set(handles.Edit_DL_DOF4,	'enable',	'off');
%%% 	set(handles.Edit_DL_DOF5,	'enable',	'off');
%%% 	set(handles.Edit_DL_DOF6,	'enable',	'off');
%%% else
%%% 	set(handles.Edit_DL_DOF1,	'enable',	'on');
%%% 	set(handles.Edit_DL_DOF2,	'enable',	'on');
%%% 	set(handles.Edit_DL_DOF3,	'enable',	'on');
%%% 	set(handles.Edit_DL_DOF4,	'enable',	'on');
%%% 	set(handles.Edit_DL_DOF5,	'enable',	'on');
%%% 	set(handles.Edit_DL_DOF6,	'enable',	'on');
%%% end
%%% 
%%% if handles.MDL.CheckLimit_ForcTot == 0
%%% 	set(handles.Edit_FL_DOF1,	'enable',	'off');
%%% 	set(handles.Edit_FL_DOF2,	'enable',	'off');
%%% 	set(handles.Edit_FL_DOF3,	'enable',	'off');
%%% 	set(handles.Edit_FL_DOF4,	'enable',	'off');
%%% 	set(handles.Edit_FL_DOF5,	'enable',	'off');
%%% 	set(handles.Edit_FL_DOF6,	'enable',	'off');
%%% else
%%% 	set(handles.Edit_FL_DOF1,	'enable',	'on');
%%% 	set(handles.Edit_FL_DOF2,	'enable',	'on');
%%% 	set(handles.Edit_FL_DOF3,	'enable',	'on');
%%% 	set(handles.Edit_FL_DOF4,	'enable',	'on');
%%% 	set(handles.Edit_FL_DOF5,	'enable',	'on');
%%% 	set(handles.Edit_FL_DOF6,	'enable',	'on');
%%% end
%%% 
%%% if handles.MDL.CheckLimit_DispInc == 0
%%% 	set(handles.Edit_DI_DOF1,	'enable',	'off');
%%% 	set(handles.Edit_DI_DOF2,	'enable',	'off');
%%% 	set(handles.Edit_DI_DOF3,	'enable',	'off');
%%% 	set(handles.Edit_DI_DOF4,	'enable',	'off');
%%% 	set(handles.Edit_DI_DOF5,	'enable',	'off');
%%% 	set(handles.Edit_DI_DOF6,	'enable',	'off');
%%% else
%%% 	set(handles.Edit_DI_DOF1,	'enable',	'on');
%%% 	set(handles.Edit_DI_DOF2,	'enable',	'on');
%%% 	set(handles.Edit_DI_DOF3,	'enable',	'on');
%%% 	set(handles.Edit_DI_DOF4,	'enable',	'on');
%%% 	set(handles.Edit_DI_DOF5,	'enable',	'on');
%%% 	set(handles.Edit_DI_DOF6,	'enable',	'on');
%%% end
%%% 
%%% if handles.MDL.CheckLimit_ForcInc == 0
%%% 	set(handles.Edit_FI_DOF1,	'enable',	'off');
%%% 	set(handles.Edit_FI_DOF2,	'enable',	'off');
%%% 	set(handles.Edit_FI_DOF3,	'enable',	'off');
%%% 	set(handles.Edit_FI_DOF4,	'enable',	'off');
%%% 	set(handles.Edit_FI_DOF5,	'enable',	'off');
%%% 	set(handles.Edit_FI_DOF6,	'enable',	'off');
%%% else
%%% 	set(handles.Edit_FI_DOF1,	'enable',	'on');
%%% 	set(handles.Edit_FI_DOF2,	'enable',	'on');
%%% 	set(handles.Edit_FI_DOF3,	'enable',	'on');
%%% 	set(handles.Edit_FI_DOF4,	'enable',	'on');
%%% 	set(handles.Edit_FI_DOF5,	'enable',	'on');
%%% 	set(handles.Edit_FI_DOF6,	'enable',	'on');
%%% end

%______________________________________________________________
%
% Edit boxes
%______________________________________________________________

set(handles.Edit_PortNo,		'string',	num2str(handles.MDL.InputPort));		
set(handles.Edit_File_Path,		'string',	handles.MDL.InputFile);
set(handles.Edit_LBCB_IP_1,       	'enable',	'on');
set(handles.Edit_LBCB_Port_1,     	'enable',	'on');
%set(handles.Edit_LBCB_IP_2,       	'enable',	'on');
%set(handles.Edit_LBCB_Port_2,     	'enable',	'on');

set(handles.EB_Max_Itr,		        'string',	num2str(handles.MDL.maxitr));

set(handles.Edit_DLmin_DOF11,		'string',	num2str(handles.MDL.CAP_D_min(1)));
set(handles.Edit_DLmin_DOF12,		'string',	num2str(handles.MDL.CAP_D_min(2)));
set(handles.Edit_DLmin_DOF13,		'string',	num2str(handles.MDL.CAP_D_min(3)));
set(handles.Edit_DLmin_DOF14,		'string',	num2str(handles.MDL.CAP_D_min(4)));
set(handles.Edit_DLmin_DOF15,		'string',	num2str(handles.MDL.CAP_D_min(5)));
set(handles.Edit_DLmin_DOF16,		'string',	num2str(handles.MDL.CAP_D_min(6)));
set(handles.Edit_DLmax_DOF11,		'string',	num2str(handles.MDL.CAP_D_max(1)));
set(handles.Edit_DLmax_DOF12,		'string',	num2str(handles.MDL.CAP_D_max(2)));
set(handles.Edit_DLmax_DOF13,		'string',	num2str(handles.MDL.CAP_D_max(3)));
set(handles.Edit_DLmax_DOF14,		'string',	num2str(handles.MDL.CAP_D_max(4)));
set(handles.Edit_DLmax_DOF15,		'string',	num2str(handles.MDL.CAP_D_max(5)));
set(handles.Edit_DLmax_DOF16,		'string',	num2str(handles.MDL.CAP_D_max(6)));
set(handles.Edit_DLinc_DOF11,		'string',	num2str(handles.MDL.TGT_D_inc(1)));
set(handles.Edit_DLinc_DOF12,		'string',	num2str(handles.MDL.TGT_D_inc(2)));
set(handles.Edit_DLinc_DOF13,		'string',	num2str(handles.MDL.TGT_D_inc(3)));
set(handles.Edit_DLinc_DOF14,		'string',	num2str(handles.MDL.TGT_D_inc(4)));
set(handles.Edit_DLinc_DOF15,		'string',	num2str(handles.MDL.TGT_D_inc(5)));
set(handles.Edit_DLinc_DOF16,		'string',	num2str(handles.MDL.TGT_D_inc(6)));
set(handles.Edit_FLmin_DOF11,		'string',	num2str(handles.MDL.CAP_F_min(1)));
set(handles.Edit_FLmin_DOF12,		'string',	num2str(handles.MDL.CAP_F_min(2)));
set(handles.Edit_FLmin_DOF13,		'string',	num2str(handles.MDL.CAP_F_min(3)));
set(handles.Edit_FLmin_DOF14,		'string',	num2str(handles.MDL.CAP_F_min(4)));
set(handles.Edit_FLmin_DOF15,		'string',	num2str(handles.MDL.CAP_F_min(5)));
set(handles.Edit_FLmin_DOF16,		'string',	num2str(handles.MDL.CAP_F_min(6)));
set(handles.Edit_FLmax_DOF11,		'string',	num2str(handles.MDL.CAP_F_max(1)));
set(handles.Edit_FLmax_DOF12,		'string',	num2str(handles.MDL.CAP_F_max(2)));
set(handles.Edit_FLmax_DOF13,		'string',	num2str(handles.MDL.CAP_F_max(3)));
set(handles.Edit_FLmax_DOF14,		'string',	num2str(handles.MDL.CAP_F_max(4)));
set(handles.Edit_FLmax_DOF15,		'string',	num2str(handles.MDL.CAP_F_max(5)));
set(handles.Edit_FLmax_DOF16,		'string',	num2str(handles.MDL.CAP_F_max(6)));
 set(handles.Edit_Dtol_DOF11,		'string',	num2str(handles.MDL.DispTolerance(1)));
 set(handles.Edit_Dtol_DOF12,		'string',	num2str(handles.MDL.DispTolerance(2)));
 set(handles.Edit_Dtol_DOF13,		'string',	num2str(handles.MDL.DispTolerance(3)));
 set(handles.Edit_Dtol_DOF14,		'string',	num2str(handles.MDL.DispTolerance(4)));
 set(handles.Edit_Dtol_DOF15,		'string',	num2str(handles.MDL.DispTolerance(5)));
 set(handles.Edit_Dtol_DOF16,		'string',	num2str(handles.MDL.DispTolerance(6)));
 set(handles.Edit_Dsub_DOF11,		'string',	num2str(handles.MDL.DispIncMax(1)));
 set(handles.Edit_Dsub_DOF12,		'string',	num2str(handles.MDL.DispIncMax(2)));
 set(handles.Edit_Dsub_DOF13,		'string',	num2str(handles.MDL.DispIncMax(3)));
 set(handles.Edit_Dsub_DOF14,		'string',	num2str(handles.MDL.DispIncMax(4)));
 set(handles.Edit_Dsub_DOF15,		'string',	num2str(handles.MDL.DispIncMax(5)));
 set(handles.Edit_Dsub_DOF16,		'string',	num2str(handles.MDL.DispIncMax(6)));

set(handles.Edit_DLmin_DOF21,		'string',	num2str(handles.MDL.CAP_D_min(7)));
set(handles.Edit_DLmin_DOF22,		'string',	num2str(handles.MDL.CAP_D_min(8)));
set(handles.Edit_DLmin_DOF23,		'string',	num2str(handles.MDL.CAP_D_min(9)));
set(handles.Edit_DLmin_DOF24,		'string',	num2str(handles.MDL.CAP_D_min(10)));
set(handles.Edit_DLmin_DOF25,		'string',	num2str(handles.MDL.CAP_D_min(11)));
set(handles.Edit_DLmin_DOF26,		'string',	num2str(handles.MDL.CAP_D_min(12)));
set(handles.Edit_DLmax_DOF21,		'string',	num2str(handles.MDL.CAP_D_max(7)));
set(handles.Edit_DLmax_DOF22,		'string',	num2str(handles.MDL.CAP_D_max(8)));
set(handles.Edit_DLmax_DOF23,		'string',	num2str(handles.MDL.CAP_D_max(9)));
set(handles.Edit_DLmax_DOF24,		'string',	num2str(handles.MDL.CAP_D_max(10)));
set(handles.Edit_DLmax_DOF25,		'string',	num2str(handles.MDL.CAP_D_max(11)));
set(handles.Edit_DLmax_DOF26,		'string',	num2str(handles.MDL.CAP_D_max(12)));
set(handles.Edit_DLinc_DOF21,		'string',	num2str(handles.MDL.TGT_D_inc(7)));
set(handles.Edit_DLinc_DOF22,		'string',	num2str(handles.MDL.TGT_D_inc(8)));
set(handles.Edit_DLinc_DOF23,		'string',	num2str(handles.MDL.TGT_D_inc(9)));
set(handles.Edit_DLinc_DOF24,		'string',	num2str(handles.MDL.TGT_D_inc(10)));
set(handles.Edit_DLinc_DOF25,		'string',	num2str(handles.MDL.TGT_D_inc(11)));
set(handles.Edit_DLinc_DOF26,		'string',	num2str(handles.MDL.TGT_D_inc(12)));
set(handles.Edit_FLmin_DOF21,		'string',	num2str(handles.MDL.CAP_F_min(7)));
set(handles.Edit_FLmin_DOF22,		'string',	num2str(handles.MDL.CAP_F_min(8)));
set(handles.Edit_FLmin_DOF23,		'string',	num2str(handles.MDL.CAP_F_min(9)));
set(handles.Edit_FLmin_DOF24,		'string',	num2str(handles.MDL.CAP_F_min(10)));
set(handles.Edit_FLmin_DOF25,		'string',	num2str(handles.MDL.CAP_F_min(11)));
set(handles.Edit_FLmin_DOF26,		'string',	num2str(handles.MDL.CAP_F_min(12)));
set(handles.Edit_FLmax_DOF21,		'string',	num2str(handles.MDL.CAP_F_max(7)));
set(handles.Edit_FLmax_DOF22,		'string',	num2str(handles.MDL.CAP_F_max(8)));
set(handles.Edit_FLmax_DOF23,		'string',	num2str(handles.MDL.CAP_F_max(9)));
set(handles.Edit_FLmax_DOF24,		'string',	num2str(handles.MDL.CAP_F_max(10)));
set(handles.Edit_FLmax_DOF25,		'string',	num2str(handles.MDL.CAP_F_max(11)));
set(handles.Edit_FLmax_DOF26,		'string',	num2str(handles.MDL.CAP_F_max(12)));
 set(handles.Edit_Dtol_DOF21,		'string',	num2str(handles.MDL.DispTolerance(7)));
 set(handles.Edit_Dtol_DOF22,		'string',	num2str(handles.MDL.DispTolerance(8)));
 set(handles.Edit_Dtol_DOF23,		'string',	num2str(handles.MDL.DispTolerance(9)));
 set(handles.Edit_Dtol_DOF24,		'string',	num2str(handles.MDL.DispTolerance(10)));
 set(handles.Edit_Dtol_DOF25,		'string',	num2str(handles.MDL.DispTolerance(11)));
 set(handles.Edit_Dtol_DOF26,		'string',	num2str(handles.MDL.DispTolerance(12)));
 set(handles.Edit_Dsub_DOF21,		'string',	num2str(handles.MDL.DispIncMax(7)));
 set(handles.Edit_Dsub_DOF22,		'string',	num2str(handles.MDL.DispIncMax(8)));
 set(handles.Edit_Dsub_DOF23,		'string',	num2str(handles.MDL.DispIncMax(9)));
 set(handles.Edit_Dsub_DOF24,		'string',	num2str(handles.MDL.DispIncMax(10)));
 set(handles.Edit_Dsub_DOF25,		'string',	num2str(handles.MDL.DispIncMax(11)));
 set(handles.Edit_Dsub_DOF26,		'string',	num2str(handles.MDL.DispIncMax(12)));


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


set(handles.TXT_Disp_T_LBCB,		'string',	tmp1);


%______________________________________________________________
%
% Graphics 
%______________________________________________________________

load Resources;



axes(handles.axes_monitor2);					% Obtain handle of figure box
x1 = 0;		y1 = 0;						% Initial values of plots
x2 = 0;		y2 = 0;
h_plot1 = plot(x1,y1,'r',x2,y2,'b',0,0,'r.',0,0,'b.');		% handles to plot
legend('(X1, Y1)','(X2, Y2)',2);				% legend
handles.h_plot11 = h_plot1(1);					% obtain handle of the plot 1, x1, y1
handles.h_plot12 = h_plot1(2);					% obtain handle of the plot 2, x2, y2
handles.h_plot13 = h_plot1(3);					% obtain handle of the plot 2, x1, y1 (last point)
handles.h_plot14 = h_plot1(4);					% obtain handle of the plot 2, x2, y2 (last point)
set(h_plot1(3),'markersize',15);
set(h_plot1(4),'markersize',15);


axes(handles.axes_monitor1);					% Obtain handle of figure box
x1 = 0;		y1 = 0;						% Initial values of plots
x2 = 0;		y2 = 0;
h_plot2 = plot(x1,y1,'r',x2,y2,'b',0,0,'r.',0,0,'b.');		% handles to plot
legend('(X3, Y3)','(X4, Y4)',2);				% legend
handles.h_plot21 = h_plot2(1);					% obtain handle of the plot 1, x1, y1
handles.h_plot22 = h_plot2(2);					% obtain handle of the plot 2, x2, y2
handles.h_plot23 = h_plot2(3);					% obtain handle of the plot 2, x1, y1 (last point)
handles.h_plot24 = h_plot2(4);					% obtain handle of the plot 2, x2, y2 (last point)
set(h_plot2(3),'markersize',15);
set(h_plot2(4),'markersize',15);


%______________________________________________________________
%
% Buttons
%______________________________________________________________

set(handles.PB_Pause,		'enable',	'off');
set(handles.PB_LBCB_Disconnect,	'enable',	'off');
%%%%%
% Modified by Sung Jig Kim, 05/02/2009
set(handles.PB_LBCB_Reconnect,	'enable',	'off');
%%%%
set(handles.PB_LBCB_Connect,	'enable',	'on');

set(handles.Edit_DLmin_DOF11,	'enable',	'on');
set(handles.Edit_DLmin_DOF12,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF13,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF14,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF15,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF16,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF11,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF12,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF13,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF14,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF15,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF16,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF11,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF12,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF13,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF14,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF15,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF16,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF11,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF12,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF13,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF14,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF15,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF16,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF11,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF12,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF13,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF14,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF15,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF16,	'enable',	'on');                       
                       
set(handles.Edit_DLmin_DOF21,	'enable',	'on');
set(handles.Edit_DLmin_DOF22,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF23,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF24,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF25,	'enable',	'on');                       
set(handles.Edit_DLmin_DOF26,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF21,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF22,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF23,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF24,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF25,	'enable',	'on');                       
set(handles.Edit_DLmax_DOF26,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF21,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF22,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF23,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF24,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF25,	'enable',	'on');                       
set(handles.Edit_DLinc_DOF26,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF21,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF22,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF23,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF24,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF25,	'enable',	'on');                       
set(handles.Edit_FLmin_DOF26,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF21,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF22,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF23,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF24,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF25,	'enable',	'on');                       
set(handles.Edit_FLmax_DOF26,	'enable',	'on');                       
                       



%______________________________________________________________
%
% Class member variables
%______________________________________________________________
handles.MDL.M_Disp        = zeros(12,1);                       % Measured displacement at each step, Num_DOFx1
handles.MDL.M_Forc        = zeros(12,1);                       % Measured force at each step, Num_DOFx1
handles.MDL.T_Disp_0      = zeros(12,1);                       % Previous step's target displacement, Num_DOFx1
handles.MDL.T_Disp        = zeros(12,1);                       % Target displacement, Num_DOFx1
handles.MDL.Comm_obj_1      = {};                       % communication object
handles.MDL.Comm_obj_2      = {};                       % communication object

% Following six variables are only used GUI mode to plot history of data
handles.MDL.tDisp_history     = zeros(10000,12);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.tForc_history     = zeros(10000,12);                   % History of target   displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.mDisp_history     = zeros(10000,12);                   % History of measured displacement in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.mForc_history     = zeros(10000,12);                   % History of measured force in global system, total step numbet x Num_DOF, in HSF space
handles.MDL.TransID           = '';                  % Transaction ID
handles.MDL.curStep       	= 0;                        % Current step number for this module
handles.MDL.totStep       	= 0;                        % Total number of steps to be tested
handles.MDL.curState      	= 0;                        % Current state of simulation

StatusIndicator(handles,0);


% Read external measurement configuration
Test_Config;

handles.MDL.Aux_Config1.T            =  Aux_Config.T;
handles.MDL.Aux_Config1.sensitivity  =  Aux_Config.sensitivity;
handles.MDL.Aux_Config1.S1b          =  Aux_Config1.S1b;
handles.MDL.Aux_Config1.S1p          =  Aux_Config1.S1p;
handles.MDL.Aux_Config1.S2b          =  Aux_Config1.S2b;
handles.MDL.Aux_Config1.S2p          =  Aux_Config1.S2p;
handles.MDL.Aux_Config1.S3b          =  Aux_Config1.S3b;
handles.MDL.Aux_Config1.S3p          =  Aux_Config1.S3p;
handles.MDL.Aux_Config1.Off_SPCM     =  Aux_Config.Off_SPCM;
handles.MDL.Aux_Config1.Off_MCTR     =  Aux_Config.Off_MCTR;
handles.MDL.Aux_Config1.InitialLength= Aux_Config1.InitialLength;

handles.MDL.Aux_Config2.T            =  Aux_Config.T;
handles.MDL.Aux_Config2.sensitivity  =  Aux_Config.sensitivity;
handles.MDL.Aux_Config2.S1b          =  Aux_Config2.S1b;
handles.MDL.Aux_Config2.S1p          =  Aux_Config2.S1p;
handles.MDL.Aux_Config2.S2b          =  Aux_Config2.S2b;
handles.MDL.Aux_Config2.S2p          =  Aux_Config2.S2p;
handles.MDL.Aux_Config2.S3b          =  Aux_Config2.S3b;
handles.MDL.Aux_Config2.S3p          =  Aux_Config2.S3p;
handles.MDL.Aux_Config2.Off_SPCM     =  Aux_Config.Off_SPCM;
handles.MDL.Aux_Config2.Off_MCTR     =  Aux_Config.Off_MCTR;
handles.MDL.Aux_Config2.InitialLength= Aux_Config2.InitialLength;

%------------------------------------------------------------------------------------
% Read AUXModule
%------------------------------------------------------------------------------------
% 05/10/2009, Sung Jig Kim
handles.AUX = MDL_AUX;
handles.Num_AuxModules=Num_Aux;

set (handles.PB_AuxModule_Connect,    'enable', 'off');
set (handles.PB_AuxModule_Reconnect,  'enable', 'off');
set (handles.PB_AuxModule_Disconnect, 'enable', 'off');

if handles.Num_AuxModules >= 1
	for i=1:length(AUX)
		handles.AUX(i)          = MDL_AUX ;    % Create objects of MDL_RF
		handles.AUX(i).URL      = AUX(i).URL;      
		handles.AUX(i).protocol = AUX(i).protocol; 
		handles.AUX(i).name     = AUX(i).name     ;
		handles.AUX(i).Command  = AUX(i).Command  ;
	end

	% Initialize the AUX Modules 
	handles.AUX= initialize(handles.AUX);
	for i=1:length(AUX)
		AUX_Initialized(i)=handles.AUX(i).Initialized;
	end
	
	if all(AUX_Initialized)~=1
		errordlg({'The current version can handle the only Labview1 protocol for AUX Module'; 'Please modify input'},...
		         'AUX Module Input Error');
	else
		set (handles.PB_AuxModule_Connect,    'enable', 'on');
		set(handles.PB_AuxModule_Connect, 'UserData',AUX_Initialized*0);
	end
end

Plugin_Initialize_CreateFile;  % DJB: Creates a file to store the test data