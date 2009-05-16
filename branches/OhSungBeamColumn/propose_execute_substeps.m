function handles = propose_execute(handles)

if handles.MDL.StepReduction == 1
	Increment = handles.MDL.T_Disp-handles.MDL.T_Disp_0;
	OverLimit = abs(Increment)./handles.MDL.DispIncMax;
	
	[division MaxOverLimitDOF] = max(OverLimit);
	if division > 1  					% if step size is larger than limit and
		Increment = Increment/ceil(division);
		handles.MDL.T_Disp = handles.MDL.T_Disp_0; 
		for i=1:ceil(division)
			handles.MDL.T_Disp = handles.MDL.T_Disp + Increment;
			
			accepted = 0;
			while accepted == 0
				accepted = LimitCheck(handles);
				handles  = HoldCheck(handles);
			end
			set(handles.TXT_Disp_T_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.T_Disp([1 3 5 7 9 11])));
			StatusIndicator(handles,31);	
			handles.MDL = propose(handles.MDL); 	
			
			% Modified by Sung Jig Kim, 05/02/2009
			if handles.MDL.NetworkConnectionState
				updatePLOT(handles);
				StatusIndicator(handles,32);	
				handles.MDL = execute(handles.MDL); 
			end
			
			% Modified by Sung Jig Kim, 05/02/2009
			if handles.MDL.NetworkConnectionState
				StatusIndicator(handles,33);	
				handles.MDL = query_mean(handles.MDL,1);
				set(handles.TXT_Disp_M_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
				set(handles.TXT_Forc_M_LBCB, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
                set(handles.TXT_Disp_M_Model, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
				set(handles.TXT_Forc_M_Model, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
                updatePLOT(handles);
				StatusIndicator(handles,30);	
			else
				break;  % stop the current process due to the network failure
			end
		end
	else
		accepted = 0;
		while accepted == 0
			accepted = LimitCheck(handles);
			handles  = HoldCheck(handles);
		end
		set(handles.TXT_Disp_T_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.T_Disp([1 3 5 7 9 11])));
		StatusIndicator(handles,21);	
		handles.MDL = propose(handles.MDL); 	
		
		% Modified by Sung Jig Kim, 05/02/2009
		if handles.MDL.NetworkConnectionState
			updatePLOT(handles);
			StatusIndicator(handles,22);	
			handles.MDL = execute(handles.MDL); 
		end
		
		% Modified by Sung Jig Kim, 05/02/2009
		if handles.MDL.NetworkConnectionState
			StatusIndicator(handles,23);	
			handles.MDL = query_mean(handles.MDL,1);
			set(handles.TXT_Disp_M_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.3f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.3f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
			set(handles.TXT_Forc_M_LBCB, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
			set(handles.TXT_Disp_M_Model, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
            set(handles.TXT_Forc_M_Model, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
            updatePLOT(handles);
			StatusIndicator(handles,20);	
		end
	end
else
	accepted = 0;
	while accepted == 0
		accepted = LimitCheck(handles);
		handles  = HoldCheck(handles);
	end
	set(handles.TXT_Disp_T_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.T_Disp([1 3 5 7 9 11])));
	StatusIndicator(handles,21);	
	handles.MDL = propose(handles.MDL); 	
	
	% Modified by Sung Jig Kim, 05/02/2009
	if handles.MDL.NetworkConnectionState
		updatePLOT(handles);
		StatusIndicator(handles,22);	
		handles.MDL = execute(handles.MDL); 
	end
	
	% Modified by Sung Jig Kim, 05/02/2009
	if handles.MDL.NetworkConnectionState
		StatusIndicator(handles,23);	
		handles.MDL = query_mean(handles.MDL,1);
		set(handles.TXT_Disp_M_LBCB, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.3f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.3f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
		set(handles.TXT_Forc_M_LBCB, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
		set(handles.TXT_Disp_M_Model, 'string', sprintf('L1x %+8.3f\nL1z %+8.3f\nL1r %+8.4f\n\nL2x %+8.3f\nL2z %+8.3f\nL2r %+8.4f\n', handles.MDL.M_Disp([1 3 5 7 9 11])));
		set(handles.TXT_Forc_M_Model, 'string', sprintf('L1x %+8.0f\nL1z %+8.0f\nL1r %+8.0f\n\nL2x %+8.0f\nL2z %+8.0f\nL2r %+8.0f\n', handles.MDL.M_Forc([1 3 5 7 9 11])));
        updatePLOT(handles);
		StatusIndicator(handles,20);	
	end
end
