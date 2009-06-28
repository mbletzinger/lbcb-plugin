function updateGui(handles)
    % Update handles structure
    disp(dbstack);
guidata(handles.LbcbPlugin, handles);
end