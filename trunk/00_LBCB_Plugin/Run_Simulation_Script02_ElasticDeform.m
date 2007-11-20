%Run_Simulation_Script02_ElasticDeform

% initialize iteration for elastic deformation
delta_disp = 10*ones(6,1);
ItrNo = 0;					% Increment iteration number
% SJKIM Oct24-2007  
% DispCtrlDOF = [1 2 3 4 5 6]' ~= handles.MDL.FrcCtrlDOF;  %'
if handles.MDL.CtrlMode
	DispCtrlDOF = ones(6,1);
else
	DispCtrlDOF = [1 2 3 4 5 6]' ~= handles.MDL.FrcCtrlDOF;  %'
end

% run while loop if displacement controlled DOFs error is larger than tolerance	
while any(abs(delta_disp)>handles.MDL.DispTolerance & DispCtrlDOF) & ItrNo < handles.MDL.max_itr
	handles.MDL.T_Disp = Disp_Command;
	handles.MDL.T_Forc = Forc_Command;
	
	switch handles.MDL.CtrlMode
		case 1
		case 2
			handles.MDL.T_Disp(handles.MDL.FrcCtrlDOF) = tmpTGT(handles.MDL.FrcCtrlDOF);
		case 3	% For the static test
			handles.MDL.T_Disp(handles.MDL.FrcCtrlDOF) = tmpTGT(handles.MDL.FrcCtrlDOF);
	end

	accepted = 0;
	while accepted == 0
		accepted = LimitCheck(handles);
		handles  = HoldCheck(handles);
	end
	ItrNo = ItrNo+1;
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

	delta_disp = handles.MDL.TransM*(handles.MDL.DispScale.*TGT) - handles.MDL.M_Disp;		% in LBCB space
	Adjusted_Command = Adjusted_Command + (inv(handles.MDL.TransM) * delta_disp)./handles.MDL.DispScale;						% in model space
	Disp_Command = handles.MDL.TransM * (handles.MDL.DispScale.* Adjusted_Command);			% in LBCB space
end	
Adjusted_Commandlast = Adjusted_Command;
TGTlast = TGT;