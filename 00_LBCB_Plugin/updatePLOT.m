function updatePLOT(handles)

% Figure 1 ----------------------------------------------------------------------------------------------------
xVal11 = get(handles.PM_Axis_X1,'value')-1;   % x axis of figure 1, line 1
xVal12 = get(handles.PM_Axis_X2,'value')-1;   % x axis of figure 1, line 2
xVal13 = get(handles.PM_Axis_X3,'value')-1;   % x axis of figure 1, line 3
yVal11 = get(handles.PM_Axis_Y1,'value')-1;   % y axis of figure 1, line 1
yVal12 = get(handles.PM_Axis_Y2,'value')-1;   % y axis of figure 1, line 2
yVal13 = get(handles.PM_Axis_Y3,'value')-1;   % y axis of figure 1, line 3

if handles.MDL.curState == 3				% result received (end of each step)
	McurStep = handles.MDL.curStep;			% current step of measured data
else
	McurStep = handles.MDL.curStep-1;		% current step of measured data
end
if McurStep == 0, McurStep = 1; end;

% For X
% for line 1	
dof = mod(xVal11-1, 6)+1;							% DOF 
if     xVal11 == 0								
	xdata11 = [1:handles.MDL.curStep];					% step number
elseif                0 < xVal11 	& xVal11 <= 6				% Target displacement
	xdata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < xVal11 	& xVal11 <= 6*2						% Measured displacement
	xdata11 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < xVal11 	& xVal11 <= 6*3						% Measured force
	xdata11 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < xVal11 	& xVal11 <= 6*4						% Input Target Displacement
	xdata11 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);
end

% for line 2
dof = mod(xVal12-1, 6)+1;							% DOF 
if     xVal12 == 0								
	xdata12 = [1:handles.MDL.curStep];					% step number
elseif                0 < xVal12 	& xVal12 <= 6				% Target displacement
	xdata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < xVal12 	& xVal12 <= 6*2						% Measured displacement
	xdata12 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < xVal12 	& xVal12 <= 6*3						% Measured force
	xdata12 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < xVal12 	& xVal12 <= 6*4						% Input Target Displacement
	xdata12 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);
end

% for line 3
dof = mod(xVal13-1, 6)+1;							% DOF 
if     xVal13 == 0								
	xdata13 = [1:handles.MDL.curStep];					% step number
elseif                0 < xVal13 	& xVal13 <= 6				% Target displacement
	xdata13 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < xVal13 	& xVal13 <= 6*2						% Measured displacement
	xdata13 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < xVal13 	& xVal13 <= 6*3						% Measured force
	xdata13 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < xVal13 	& xVal13 <= 6*4						% Input Target Displacement
	xdata13 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);
end

% For Y
% for line 1	
dof = mod(yVal11-1, 6)+1;							% DOF 
if     yVal11 == 0
	ydata11 = [1:handles.MDL.curStep];					% step number
elseif                0 < yVal11 	& yVal11 <= 6				% Target displacement
	ydata11 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < yVal11 	& yVal11 <= 6*2						% Measured displacement
	ydata11 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < yVal11 	& yVal11 <= 6*3						% Measured force
	ydata11 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < yVal11 	& yVal11 <= 6*4						% Input Target Displacement
	ydata11 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);		
end

% for line 2
dof = mod(yVal12-1, 6)+1;							% DOF 
if     yVal12 == 0				
	ydata12 = [1:handles.MDL.curStep];					% step number
elseif                0 < yVal12 	& yVal12 <= 6				% Target displacement
	ydata12 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < yVal12 	& yVal12 <= 6*2						% Measured displacement
	ydata12 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < yVal12 	& yVal12 <= 6*3						% Measured force
	ydata12 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < yVal12 	& yVal12 <= 6*4						% Input Target Displacement
	ydata12 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);
end

% for line 3
dof = mod(yVal13-1, 6)+1;							% DOF 
if     yVal13 == 0				
	ydata13 = [1:handles.MDL.curStep];					% step number
elseif                0 < yVal13 	& yVal13 <= 6				% Target displacement
	ydata13 = handles.MDL.tDisp_history(1:handles.MDL.curStep,dof);
elseif 6   < yVal13 	& yVal13 <= 6*2						% Measured displacement
	ydata13 = handles.MDL.mDisp_history(1:McurStep,dof);
elseif 6*2 < yVal13 	& yVal13 <= 6*3						% Measured force
	ydata13 = handles.MDL.mForc_history(1:McurStep,dof);
elseif 6*3 < yVal13 	& yVal13 <= 6*4						% Input Target Displacement
	ydata13 = handles.MDL.tDisp_history_SC(1:handles.MDL.curStep,dof);
end

% Plot data

if get(handles.CB_MovingWindow,'value')==1
	window = str2num(get(handles.Edit_Window_Size,'string'));
	
	% Plot 1
	tmp = min([length(xdata11) length(ydata11)]);  
	if tmp>window
		lowend = tmp - window;
	else
		lowend = 1;
	end
	set(handles.h_plot11,'xdata',xdata11(lowend:tmp)); 		
	set(handles.h_plot11,'ydata',ydata11(lowend:tmp)); 
	set(handles.h_plot14,'xdata',xdata11(tmp));  		
	set(handles.h_plot14,'ydata',ydata11(tmp)); 
	
	% Plot 2					
	tmp = min([length(xdata12) length(ydata12)]);  	
	if tmp>window
		lowend = tmp - window;
	else
		lowend = 1;
	end
	set(handles.h_plot12,'xdata',xdata12(lowend:tmp)); 		
	set(handles.h_plot12,'ydata',ydata12(lowend:tmp)); 		
	set(handles.h_plot15,'xdata',xdata12(tmp));  
	set(handles.h_plot15,'ydata',ydata12(tmp)); 
	
	% Plot 3					    
    tmp = min([length(xdata13) length(ydata13)]);                                                                                                    
    if tmp>window
		lowend = tmp - window;
	else
		lowend = 1;
	end
	set(handles.h_plot13,'xdata',xdata13(lowend:tmp)); 		
	set(handles.h_plot13,'ydata',ydata13(lowend:tmp)); 		
	set(handles.h_plot16,'xdata',xdata13(tmp));
	set(handles.h_plot16,'ydata',ydata13(tmp));  
	                                                                                                       
else
	% Plot 1
	tmp = min([length(xdata11) length(ydata11)]);  
	lowend = 1;
	set(handles.h_plot11,'xdata',xdata11(lowend:tmp)); 		
	set(handles.h_plot11,'ydata',ydata11(lowend:tmp)); 		
	set(handles.h_plot14,'xdata',xdata11(tmp));   
	set(handles.h_plot14,'ydata',ydata11(tmp)); 

	% Plot 2						
	tmp = min([length(xdata12) length(ydata12)]);  	
	lowend = 1;
	set(handles.h_plot12,'xdata',xdata12(lowend:tmp)); 		
 	set(handles.h_plot12,'ydata',ydata12(lowend:tmp)); 		
	set(handles.h_plot15,'xdata',xdata12(tmp));   
	set(handles.h_plot15,'ydata',ydata12(tmp));                                                                                                         

	% Plot 3
	tmp = min([length(xdata13) length(ydata13)]);  	
	lowend = 1;
	set(handles.h_plot13,'xdata',xdata13(lowend:tmp)); 		
 	set(handles.h_plot13,'ydata',ydata13(lowend:tmp)); 		
	set(handles.h_plot16,'xdata',xdata13(tmp));   
	set(handles.h_plot16,'ydata',ydata13(tmp));  
end		                                                                                                        