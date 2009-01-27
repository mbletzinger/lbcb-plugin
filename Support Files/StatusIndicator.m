function StatusIndicator(handles,status)

disabled = [.8 .8 .8];
enabled1 = [.6 .5 1];
enabled2 = [1  1 .7];

switch status
	case 0	% disable all
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', disabled);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', disabled);
	case 1	% Processing
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', disabled);
		set(handles.Process,        'backgroundcolor', enabled1);
		set(handles.Iterns,             'backgroundcolor', disabled);
	case 2	% Waiting for OM
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', enabled1);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', disabled);
	case 3	% Getting Targets
		set(handles.Get_TGT,		'backgroundcolor', enabled1); 
		set(handles.Wait_OM,              'backgroundcolor', disabled);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', disabled);
	case 4 % Running Iterations
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', disabled);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', enabled1);
    case 41 % Running Iterations and Processing
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', enabled1);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', enabled2);
    case 42 % Running Iterations and Waiting for OM
		set(handles.Get_TGT,		'backgroundcolor', disabled); 
		set(handles.Wait_OM,              'backgroundcolor', enabled1);
		set(handles.Process,        'backgroundcolor', disabled);
		set(handles.Iterns,             'backgroundcolor', enabled2);
end
