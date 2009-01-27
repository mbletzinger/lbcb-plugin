function handles = PauseStopCheck(handles)

tmp_flag = 0;
while get(handles.PauseBut, 'value') == 1
	pause(0.01);
    if tmp_flag == 0
		tmp_flag = 1;
		enableGUI(handles);			% enable GUI menu
	end
end

if tmp_flag
	disableGUI(handles);
	handles = readGUI(handles);
end




if get(handles.PB_Pause, 'value') == 0
    % End the Step and Don't Run anymore substeps
    handles.Stop=1;
end

