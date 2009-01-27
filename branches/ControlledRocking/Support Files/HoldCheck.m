function handles = HoldCheck(handles)

tmp_flag = 0;
while get(handles.PB_Pause, 'value') == 0
	pause(0.01);
	if tmp_flag == 0
		tmp_flag = 1;
		enableGUI(handles);			% enable GUI menu
	end
%	handles = guidata(hObject);		% update data to check change in GUI 
end
if tmp_flag
	disableGUI(handles);
	handles = readGUI(handles);
end