function handles = propose_execute_substeps(handles)

handles.MDL.LBCB_Target_1=handles.MDL.T_Disp;
if handles.MDL.CtrlMode==3  % For Static Mixed Module
	handles.MDL.LBCB_Target_1(handles.MDL.LBCB_FrcCtrlDOF==1)=handles.MDL.T_Forc(handles.MDL.LBCB_FrcCtrlDOF==1);
end

if handles.MDL.StepReduction == 1
	Increment = handles.MDL.LBCB_Target_1 - handles.MDL.LBCB_Target_0;
	OverLimit = abs(Increment)./handles.MDL.DispIncMax;
	[division MaxOverLimitDOF] = max(OverLimit);
	if division > 1 &	 ...					% if step size is larger than limit and
	   (handles.MDL.CtrlMode ==1 ||	 ...					% control mode is displacement control or
	   (handles.MDL.CtrlMode ==2 & (MaxOverLimitDOF ~= handles.MDL.FrcCtrlDOF)) ||	 ...	% if mixed mode control, the controlled DOF is not force controlled DOF)
	    handles.MDL.CtrlMode ==3)             % mixed Static mode control
	    
	    SR_Num=ceil(division);
		Increment = Increment/ceil(division);
		%handles.MDL.LBCB_Target_1 = handles.MDL.LBCB_Target_0; 
		Cur_GUIstr = get(handles.ET_GUI_Process_Text,'string');
		
		for i=1:SR_Num
			handles.MDL.LBCB_Target_1 = handles.MDL.LBCB_Target_0 + Increment;
			
			GUI_tmp_str =sprintf('%s,   Step Reduction %d/%d',Cur_GUIstr{end},i,SR_Num);
			UpdateStatusPanel(handles.ET_GUI_Process_Text,GUI_tmp_str,2); 
			
			StatusIndicator(handles,31);
			%
			handles = Check_BeforePropose (handles);
			
			handles.MDL = propose(handles.MDL); 	
			%if handles.MDL.UpdateMonitor, 
			updatePLOT(handles); %, end
			StatusIndicator(handles,32);	handles.MDL = execute(handles.MDL); 
			StatusIndicator(handles,33);	
			%
			handles = Query_Main(handles,3);
			%
			StatusIndicator(handles,30);	
			
		end
		
	else
		StatusIndicator(handles,21);	
		% 
		handles = Check_BeforePropose (handles);
	
		handles.MDL = propose(handles.MDL); 	
		%if handles.MDL.UpdateMonitor, 
		updatePLOT(handles); %, end
		StatusIndicator(handles,22);	handles.MDL = execute(handles.MDL); 
		%StatusIndicator(handles,23);	
		%%
		%handles = Query_Main(handles,3);
		%%
		%StatusIndicator(handles,20);	
	end
else
	StatusIndicator(handles,21);	
	% For UserInput Option
	handles = Check_BeforePropose (handles);
	
	handles.MDL = propose(handles.MDL); 	
	%if handles.MDL.UpdateMonitor, 
	updatePLOT(handles); %, end
	StatusIndicator(handles,22);	handles.MDL = execute(handles.MDL); 
	%StatusIndicator(handles,23);	
	%%
	%handles = Query_Main(handles,3);
	%%
	%StatusIndicator(handles,20);	
end
