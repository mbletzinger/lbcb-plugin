%Run_Simulation_Script04_ApplyForce
F_prev = handles.MDL.M_Forc(handles.MDL.FrcCtrlDOF);	% Force of force controlled DOF, LBCB space
D_prev = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);	% Force of displacement controlled DOF, LBCB space
D_v(ItrNo) = D_prev;
F_v(ItrNo) = F_prev;

% Hold lateral displacement and apply vertical force
Conv_Flag = 0;						% Flag to identify convergence
K_F = handles.MDL.K_vert_ini;				% initial vertical stiffness at beginning of each iteration

while (Conv_Flag == 0 )					% while it does not satisfy criteria
	% if target displacement is exceeded, end iteration
	if  (tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev_s) * (D_prev - tmpTGT(handles.MDL.FrcCtrlDOF)) > 0 
		Conv_Flag = 1;
		disp('Target displacement exceeded.');
	end

	% if within tolerance limit, end iteration
	if  abs(tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev)<handles.MDL.DispTolerance(handles.MDL.FrcCtrlDOF)
		Conv_Flag = 1;
		disp('Tolerance satisfied.');
	end

	% if maximum iteration reached
	if ItrNo >= handles.MDL.max_itr
		Conv_Flag = 1;
		disp('Maximum number of iteration reached.');
	end

	if Conv_Flag == 0 		
		ItrNo = ItrNo+1;							% increase iteration number
		F_target = F_prev + (tmpTGT(handles.MDL.FrcCtrlDOF)-D_prev)*K_F;	% increase force from previous step
		Forc_Command(handles.MDL.FrcCtrlDOF) = F_target;			% update force command.
		handles.MDL.T_Forc = Forc_Command;
		time_i = clock;					
	
		if handles.MDL.UpdateMonitor
			set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Force Iteration #: %d',ItrNo));
			switch (handles.MDL.FrcCtrlDOF)
				case 1
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				case 2
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				case 3
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				case 4                                                                                                                                         
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n%+12.5f\n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				case 5
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n%+12.5f\n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
				case 6
					set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n%+12.5f\n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			end
			disp(sprintf('  Iteration %d,  LBCB_DOF: %d   StepTarget D: %e,  IterationTarget F: %e',ItrNo,handles.MDL.FrcCtrlDOF,Disp_Command(handles.MDL.FrcCtrlDOF),Forc_Command(handles.MDL.FrcCtrlDOF)));
		end
		
		accepted = 0;
		while accepted == 0
			accepted = LimitCheck(handles);
			handles = HoldCheck(handles);
		end
	
		%handles = propose_execute_substeps(handles);
		StatusIndicator(handles,41);	handles.MDL = propose(handles.MDL); 	
		if handles.MDL.UpdateMonitor, updatePLOT(handles), end
		StatusIndicator(handles,42);	handles.MDL = execute(handles.MDL); 
		StatusIndicator(handles,43);	handles.MDL = query_mean(handles.MDL);
		StatusIndicator(handles,40);	
		if handles.MDL.UpdateMonitor
			updatePLOT(handles);
			set(handles.TXT_Disp_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Disp));
			set(handles.TXT_Forc_M_LBCB, 'string', sprintf('%+12.5f\n', handles.MDL.M_Forc));
		end
		set(handles.TXT_LBCB_Mes_Itr,'string', sprintf('Force Iteration #: %d   %5.2f sec',ItrNo,etime(clock, time_i)));					

		F_prev = handles.MDL.M_Forc(handles.MDL.FrcCtrlDOF);
		D_prev = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);
	
		D_v(ItrNo) = D_prev;
		F_v(ItrNo) = F_prev;
			disp(sprintf('                 Current D: %e, Current F: %e',D_prev,F_prev));
	
		if ItrNo >= handles.MDL.secK_eval_itr		% if iteration goes over predefined steps, update secant stiffness
			%K_F = mean((F_v(j-secK_moving_average_window+2:j)-F_v(j-secK_moving_average_window+1:j-1))./(D_v(j-secK_moving_average_window+2:j)-D_v(j-secK_moving_average_window+1:j-1)))*secK_factor;
			tmp = polyfit(D_v(1:ItrNo),F_v(1:ItrNo),1);
			K_F = tmp(1)*handles.MDL.secK_factor;

			if K_F < handles.MDL.K_vert_ini		% if stiffness becomes smaller than lower bound stiffness, use lower bound stiffness
				K_F = handles.MDL.K_vert_ini;
			end
		end
	
		% Check Pause before getting command -----------------------------------------------
		handles = HoldCheck(handles);
		% -----------------------------------------------------------------------------------
	end
end
D_prev_s = handles.MDL.M_Disp(handles.MDL.FrcCtrlDOF);		% vertical displacement.