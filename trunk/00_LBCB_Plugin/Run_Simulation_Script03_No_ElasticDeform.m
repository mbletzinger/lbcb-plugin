%Run_Simulation_Script03_No_ElasticDeform

handles.MDL.T_Disp = tmpTGT;
handles.MDL.T_Forc = Forc_Command;

accepted = 0;
while accepted == 0
	accepted = LimitCheck(handles);
	handles  = HoldCheck(handles);
end

disp(sprintf('  Elastic Deformation %d',ItrNo)); 
set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Disp. Iteration #: %d',ItrNo));
handles = propose_execute_substeps(handles);
StatusIndicator(handles,23);	
handles.MDL = query_mean(handles.MDL);
StatusIndicator(handles,20);	
handles.MDL.M_Disp = handles.MDL.M_Disp - offset;	%Remove offset

if handles.MDL.UpdateMonitor
	updatePLOT(handles);
	set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
	set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
end
set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Disp. Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));