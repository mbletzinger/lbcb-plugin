function handles = propose_execute_substeps(handles)

if handles.MDL.StepReduction == 1
	Increment = handles.MDL.T_Disp-handles.MDL.T_Disp_0;
	OverLimit = abs(Increment)./handles.MDL.DispIncMax;
	[division MaxOverLimitDOF] = max(OverLimit);
	if division > 1 &	 ...					% if step size is larger than limit and
	   (handles.MDL.CtrlMode ==1 ||	 ...					% control mode is displacement control or
	   (handles.MDL.CtrlMode ==2 & (MaxOverLimitDOF ~= handles.MDL.FrcCtrlDOF)) || ...	% if mixed mode control, the controlled DOF is not force controlled DOF)      
	   (handles.MDL.CtrlMode ==3 & (MaxOverLimitDOF ~= handles.MDL.FrcCtrlDOF)))	% if mixed mode control, the controlled DOF is not force controlled DOF) 
		Increment = Increment/ceil(division);
		handles.MDL.T_Disp = handles.MDL.T_Disp_0; 
		for i=1:ceil(division)
			handles.MDL.T_Disp = handles.MDL.T_Disp + Increment;
            
			accepted = 0;
			while accepted == 0
				accepted = LimitCheck(handles);
				handles  = HoldCheck(handles);
			end
			StatusIndicator(handles,31);	handles.MDL = propose(handles.MDL); 	
			if handles.MDL.UpdateMonitor, updatePLOT(handles), end
			StatusIndicator(handles,32);	handles.MDL = execute(handles.MDL); 
			StatusIndicator(handles,33);	handles.MDL = query_mean(handles.MDL,1);
			StatusIndicator(handles,30);	
		end
		
	else
		StatusIndicator(handles,21);	handles.MDL = propose(handles.MDL); 	
		if handles.MDL.UpdateMonitor, updatePLOT(handles), end
		StatusIndicator(handles,22);	handles.MDL = execute(handles.MDL); 
		%StatusIndicator(handles,23);	handles.MDL = query_mean(handles.MDL,1);
		%StatusIndicator(handles,20);	
	end
else
	StatusIndicator(handles,21);	handles.MDL = propose(handles.MDL); 	
	if handles.MDL.UpdateMonitor, updatePLOT(handles), end
	StatusIndicator(handles,22);	handles.MDL = execute(handles.MDL); 
	%StatusIndicator(handles,23);	handles.MDL = query_mean(handles.MDL,1);
	%StatusIndicator(handles,20);	
end
