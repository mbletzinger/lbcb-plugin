function updatePLOT(handles)

		if handles.MDL.curState == 3				% result received (end of each step)
			McurStep = handles.MDL.curStep;			% current step of measured data
		else
			McurStep = handles.MDL.curStep-1;		% current step of measured data
		end
		if McurStep == 0, McurStep = 1; end;
		
		
		
		% Figure 1 ----------------------------------------------------------------------------------------------------
		xVal11 = get(handles.PM_Axis_X1,'value')-1;   % x axis of figure 1, line 1
		xVal12 = get(handles.PM_Axis_X2,'value')-1;   % x axis of figure 1, line 2
		yVal11 = get(handles.PM_Axis_Y1,'value')-1;   % y axis of figure 1, line 1
		yVal12 = get(handles.PM_Axis_Y2,'value')-1;   % y axis of figure 1, line 2
		
		
			
		dof = mod(xVal11-1, 6)+1;							% DOF 
		if     xVal11 == 0								
			xdata11 = [1:handles.MDL.curStep];					% step number
		elseif                0 < xVal11 	& xVal11 <= 6				% Target displacement
			xdata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < xVal11 	& xVal11 <= 6*2						% Measured displacement
			xdata11 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < xVal11 	& xVal11 <= 6*3						% Measured force
			xdata11 = handles.MDL.mForc_history(1:McurStep,dof);
		end

		dof = mod(xVal12-1, 6)+1;							% DOF 
		if     xVal12 == 0								
			xdata12 = [1:handles.MDL.curStep];					% step number
		elseif                0 < xVal12 	& xVal12 <= 6				% Target displacement
			xdata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < xVal12 	& xVal12 <= 6*2						% Measured displacement
			xdata12 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < xVal12 	& xVal12 <= 6*3						% Measured force
			xdata12 = handles.MDL.mForc_history(1:McurStep,dof);
		end
		
		dof = mod(yVal11-1, 6)+1;							% DOF 
		if     yVal11 == 0
			ydata11 = [1:handles.MDL.curStep];					% step number
		elseif                0 < yVal11 	& yVal11 <= 6				% Target displacement
			ydata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < yVal11 	& yVal11 <= 6*2						% Measured displacement
			ydata11 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < yVal11 	& yVal11 <= 6*3						% Measured force
			ydata11 = handles.MDL.mForc_history(1:McurStep,dof);
		end

		dof = mod(yVal12-1, 6)+1;							% DOF 
		if     yVal12 == 0				
			ydata12 = [1:handles.MDL.curStep];					% step number
		elseif                0 < yVal12 	& yVal12 <= 6				% Target displacement
			ydata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < yVal12 	& yVal12 <= 6*2						% Measured displacement
			ydata12 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < yVal12 	& yVal12 <= 6*3						% Measured force
			ydata12 = handles.MDL.mForc_history(1:McurStep,dof);
		end
		
		if get(handles.CB_MovingWindow,'value')==1
			window = str2num(get(handles.Edit_Window_Size,'string'));
			tmp = min([length(xdata11) length(ydata11)]);  
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot11,'xdata',xdata11(lowend:tmp)); 		
								set(handles.h_plot13,'xdata',xdata11(tmp));   
							
			tmp = min([length(xdata12) length(ydata12)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot12,'xdata',xdata12(lowend:tmp)); 		
								set(handles.h_plot14,'xdata',xdata12(tmp));   
		                                                                                                        
		                                                                                                        
			tmp = min([length(xdata11) length(ydata11)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot11,'ydata',ydata11(lowend:tmp)); 		
								set(handles.h_plot13,'ydata',ydata11(tmp));   
			tmp = min([length(xdata12) length(ydata12)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot12,'ydata',ydata12(lowend:tmp)); 		
								set(handles.h_plot14,'ydata',ydata12(tmp));   
		else
			tmp = min([length(xdata11) length(ydata11)]);  
			lowend = 1;
								set(handles.h_plot11,'xdata',xdata11(lowend:tmp)); 		
								set(handles.h_plot13,'xdata',xdata11(tmp));   
							
			tmp = min([length(xdata12) length(ydata12)]);  	
			lowend = 1;
								set(handles.h_plot12,'xdata',xdata12(lowend:tmp)); 		
								set(handles.h_plot14,'xdata',xdata12(tmp));   
		                                                                                                        
			tmp = min([length(xdata11) length(ydata11)]);  	
			lowend = 1;
								set(handles.h_plot11,'ydata',ydata11(lowend:tmp)); 		
								set(handles.h_plot13,'ydata',ydata11(tmp));   

			tmp = min([length(xdata12) length(ydata12)]);  	
			lowend = 1;
								set(handles.h_plot12,'ydata',ydata12(lowend:tmp)); 		
								set(handles.h_plot14,'ydata',ydata12(tmp));   
		end		                                                                                                        
		
		
		
		
		
		% Figure 2 ----------------------------------------------------------------------------------------------------
		xVal23 = get(handles.PM_Axis_X3,'value')-1;   % x axis of figure 1, line 1
		xVal24 = get(handles.PM_Axis_X4,'value')-1;   % x axis of figure 1, line 2
		yVal23 = get(handles.PM_Axis_Y3,'value')-1;   % y axis of figure 1, line 1
		yVal24 = get(handles.PM_Axis_Y4,'value')-1;   % y axis of figure 1, line 2
		
			
		dof = mod(xVal23-1, 6)+1+6;							% DOF 
		if     xVal23 == 0								
			xdata11 = [1:handles.MDL.curStep];					% step number
		elseif                0 < xVal23 	& xVal23 <= 6				% Target displacement
			xdata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < xVal23 	& xVal23 <= 6*2						% Measured displacement
			xdata11 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < xVal23 	& xVal23 <= 6*3						% Measured force
			xdata11 = handles.MDL.mForc_history(1:McurStep,dof);
		end

		dof = mod(xVal24-1, 6)+1+6;							% DOF 
		if     xVal24 == 0								
			xdata12 = [1:handles.MDL.curStep];					% step number
		elseif                0 < xVal24 	& xVal24 <= 6				% Target displacement
			xdata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < xVal24 	& xVal24 <= 6*2						% Measured displacement
			xdata12 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < xVal24 	& xVal24 <= 6*3						% Measured force
			xdata12 = handles.MDL.mForc_history(1:McurStep,dof);
		end
		
		dof = mod(yVal23-1, 6)+1+6;							% DOF 
		if     yVal23 == 0
			ydata11 = [1:handles.MDL.curStep];					% step number
		elseif                0 < yVal23 	& yVal23 <= 6				% Target displacement
			ydata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < yVal23 	& yVal23 <= 6*2						% Measured displacement
			ydata11 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < yVal23 	& yVal23 <= 6*3						% Measured force
			ydata11 = handles.MDL.mForc_history(1:McurStep,dof);
		end

		dof = mod(yVal24-1, 6)+1+6;							% DOF 
		if     yVal24 == 0				
			ydata12 = [1:handles.MDL.curStep];					% step number
		elseif                0 < yVal24 	& yVal24 <= 6				% Target displacement
			ydata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
		elseif 6   < yVal24 	& yVal24 <= 6*2						% Measured displacement
			ydata12 = handles.MDL.mDisp_history(1:McurStep,dof);
		elseif 6*2 < yVal24 	& yVal24 <= 6*3						% Measured force
			ydata12 = handles.MDL.mForc_history(1:McurStep,dof);
		end
		
		if get(handles.CB_MovingWindow,'value')==1
			window = str2num(get(handles.Edit_Window_Size,'string'));
			tmp = min([length(xdata11) length(ydata11)]);  
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot21,'xdata',xdata11(lowend:tmp)); 		
								set(handles.h_plot23,'xdata',xdata11(tmp));   
							
			tmp = min([length(xdata12) length(ydata12)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot22,'xdata',xdata12(lowend:tmp)); 		
								set(handles.h_plot24,'xdata',xdata12(tmp));   
		                                                                                                        
		                                                                                                        
			tmp = min([length(xdata11) length(ydata11)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot21,'ydata',ydata11(lowend:tmp)); 		
								set(handles.h_plot23,'ydata',ydata11(tmp));   
			tmp = min([length(xdata12) length(ydata12)]);  	
			if tmp>window
				lowend = tmp - window;
			else
				lowend = 1;
			end
								set(handles.h_plot22,'ydata',ydata12(lowend:tmp)); 		
								set(handles.h_plot24,'ydata',ydata12(tmp));   
		else
			tmp = min([length(xdata11) length(ydata11)]);  
			lowend = 1;
								set(handles.h_plot21,'xdata',xdata11(lowend:tmp)); 		
								set(handles.h_plot23,'xdata',xdata11(tmp));   
							
			tmp = min([length(xdata12) length(ydata12)]);  	
			lowend = 1;
								set(handles.h_plot22,'xdata',xdata12(lowend:tmp)); 		
								set(handles.h_plot24,'xdata',xdata12(tmp));   
		                                                                                                        
			tmp = min([length(xdata11) length(ydata11)]);  	
			lowend = 1;
								set(handles.h_plot21,'ydata',ydata11(lowend:tmp)); 		
								set(handles.h_plot23,'ydata',ydata11(tmp));   

			tmp = min([length(xdata12) length(ydata12)]);  	
			lowend = 1;
								set(handles.h_plot22,'ydata',ydata12(lowend:tmp)); 		
								set(handles.h_plot24,'ydata',ydata12(tmp));   
		end		