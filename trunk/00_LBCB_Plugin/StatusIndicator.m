function StatusIndicator(handles,status)

disabled = [.8 .8 .8];
enabled1 = [.6 .5 1];
enabled2 = [1  1 .7];


switch status
	case 0	% disable all
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 1	% wating command
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', enabled1); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 20	% Disp. Iteration, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', enabled2);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);

	case 21	% Disp. Iteration, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', enabled2);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 22 % Disp. Iteration, Execute
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', enabled2);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 23	% Disp. Iteration, Query
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', enabled2);
	case 30	% Step reduction, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', enabled1);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', enabled2);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 31	% Step reduction, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', enabled1);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', enabled2);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 32 % Step reduction, Execute
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', enabled1);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', enabled2);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 33	% Step reduction, Query
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', enabled1);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', enabled1);
		set(handles.Edit_Force_Itr,             'backgroundcolor', disabled);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', enabled2);
	case 40	% Force iteration, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', enabled1);
		set(handles.Edit_Processing,            'backgroundcolor', enabled2);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 41	% Force iteration, Propose
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', enabled1);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', enabled2);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 42 % Force iteration, Execute
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', enabled1);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', enabled2);
		set(handles.Edit_Querying,              'backgroundcolor', disabled);
	case 43	% Force iteration, Query
		set(handles.Edit_Waiting_CMD,		'backgroundcolor', disabled); 
		set(handles.Edit_Disp_Itr,              'backgroundcolor', disabled);
		set(handles.Edit_Step_Reduction,        'backgroundcolor', disabled);
		set(handles.Edit_Force_Itr,             'backgroundcolor', enabled1);
		set(handles.Edit_Processing,            'backgroundcolor', disabled);
		set(handles.Edit_Propose,               'backgroundcolor', disabled);
		set(handles.Edit_Execute,               'backgroundcolor', disabled);
		set(handles.Edit_Querying,              'backgroundcolor', enabled2);
end