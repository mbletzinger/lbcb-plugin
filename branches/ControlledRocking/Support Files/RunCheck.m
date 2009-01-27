function handles = RunCheck(handles)

Temp_InputFile=handles.MDL.InputFile;
handles.Stop=0;
tmp_flag = 0;
while get(handles.PB_Pause, 'value') == 0
	pause(0.01);
	if tmp_flag == 0
		tmp_flag = 1;
		enableGUI(handles);			% enable GUI menu
    end
    handles = readGUI(handles);
    if strcmp(handles.MDL.InputFile,Temp_InputFile)
    else
        handles.StepNo=0;
        disp_his=load(handles.MDL.InputFile);	% 6 column data
        handles.disp_his=disp_his;
        tmp = size(disp_his);
        if tmp(2) ~= 6
            error('Input file should have six columns of data.')
        end
        handles.MDL.totStep = tmp(1);
        TGT = disp_his(1,:)';
        TGT=[handles.SclFctrs(1)*TGT(1) handles.SclFctrs(2)*TGT(2) handles.SclFctrs(3)*TGT(3)...
        handles.SclFctrs(4)*TGT(4) handles.SclFctrs(5)*TGT(5) handles.SclFctrs(6)*TGT(6)]';
        % Display New Targets on the Screen
        set(handles.Target_DX,		'string',	num2str(TGT(1)));
        set(handles.Target_DY,		'string',	num2str(TGT(2)));
        set(handles.Target_FZ,		'string',	num2str(TGT(3)));
        set(handles.Target_RX,		'string',	num2str(TGT(4)));
        set(handles.Target_MY,		'string',	num2str(TGT(5)));
        set(handles.Target_RZ,		'string',	num2str(TGT(6)));
        guidata(hObject, handles);
        Temp_InputFile=handles.MDL.InputFile;
    end
end
if tmp_flag
	disableGUI(handles);
end