%Run_Simulation_Script01_UpdateMonitor

disp(sprintf('Step %d -----------------------------',StepNo));
set(handles.TXT_Disp_T_Model  , 'string', sprintf('%+12.5f\n', TGT));
set(handles.TXT_Model_Tgt_Step, 'string', sprintf('Step #: %d',StepNo));
set(handles.TXT_LBCB_Tgt_Itr, 'string', sprintf('Iteration #: %d',ItrNo));
switch handles.MDL.CtrlMode 	
	case 1					% If displacement control mode
		set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n', Disp_Command));
	case 2					% If mixed control mode
		switch (handles.MDL.FrcCtrlDOF)
			case 1
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command(2:end)));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 2
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1 3:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 3
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1:2 4:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 4                                                                                                                                         
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n', Disp_Command([1:3 5:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n%+12.5f\n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 5
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n', Disp_Command([1:4 6])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n%+12.5f\n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 6
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n', Disp_Command([1:5])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n%+12.5f\n', Forc_Command(handles.MDL.FrcCtrlDOF)));
		end
	
	case 3					% If mixed control mode
		switch (handles.MDL.FrcCtrlDOF)
			case 1
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command(2:end)));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 2
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1 3:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n%+12.5f\n        -     \n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 3
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n%+12.5f\n', Disp_Command([1:2 4:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n%+12.5f\n        -     \n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 4                                                                                                                                         
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n%+12.5f\n', Disp_Command([1:3 5:end])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n%+12.5f\n        -     \n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 5
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n%+12.5f\n', Disp_Command([1:4 6])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n%+12.5f\n        -     \n', Forc_Command(handles.MDL.FrcCtrlDOF)));
			case 6
				set(handles.TXT_Disp_T_LBCB, 'string', sprintf('%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n%+12.5f\n        -     \n', Disp_Command([1:5])));
				set(handles.TXT_Forc_T_LBCB, 'string', sprintf('        -     \n        -     \n        -     \n        -     \n        -     \n%+12.5f\n', Forc_Command(handles.MDL.FrcCtrlDOF)));
		end	
end