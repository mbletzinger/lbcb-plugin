function [accepted] = LimitCheck(handles)

denied1 = zeros(6,1);
denied2 = zeros(6,1);
denied3 = zeros(6,1);
denied4 = zeros(6,1);
denied5 = zeros(6,1);
MaxLim=[handles.MDL.CAP_D_max(1) handles.MDL.CAP_D_max(2)...
    handles.MDL.CAP_F_max(3) handles.MDL.CAP_D_max(4)...
    handles.MDL.CAP_F_max(5) handles.MDL.CAP_D_max(6)]';

% Displacement limit ---------------------------------------------------------------------------------------
if get(handles.CB_Disp_Limit, 'value')
%   Command in Limit Check is:      handles.MDL.T_Disp
%   Upper Displacement Limits are:  MaxLim
%   Lower Displacmenet Limits are:  handles.MDL.CAP_D_min
    denied1 = handles.MDL.T_Disp < handles.MDL.CAP_D_min;   % Check absolute displacement
    denied2 = handles.MDL.T_Disp > MaxLim;                  % Check absolute displacement
    
    if denied1(1)
    	set(handles.Edit_DLmin_DOF1, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF1, 'backgroundcolor',[1 1 1]);
    end
    if denied1(2)
    	set(handles.Edit_DLmin_DOF2, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF2, 'backgroundcolor',[1 1 1]);
    end
    if denied1(3)
    	set(handles.Edit_DLmin_DOF3, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF3, 'backgroundcolor',[1 1 1]);
    end
    if denied1(4)
    	set(handles.Edit_DLmin_DOF4, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF4, 'backgroundcolor',[1 1 1]);
    end
    if denied1(5)
    	set(handles.Edit_DLmin_DOF5, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF5, 'backgroundcolor',[1 1 1]);
    end
    if denied1(6)
    	set(handles.Edit_DLmin_DOF6, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF6, 'backgroundcolor',[1 1 1]);
    end

    if denied2(1)
    	set(handles.Edit_DLmax_DOF1, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF1, 'backgroundcolor',[1 1 1]);
    end
    if denied2(2)
    	set(handles.Edit_DLmax_DOF2, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF2, 'backgroundcolor',[1 1 1]);
    end
    if denied2(3)
    	set(handles.Edit_DLmax_DOF3, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF3, 'backgroundcolor',[1 1 1]);
    end
    if denied2(4)
    	set(handles.Edit_DLmax_DOF4, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF4, 'backgroundcolor',[1 1 1]);
    end
    if denied2(5)
    	set(handles.Edit_DLmax_DOF5, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF5, 'backgroundcolor',[1 1 1]);
    end
    if denied2(6)
    	set(handles.Edit_DLmax_DOF6, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF6, 'backgroundcolor',[1 1 1]);
    end
end

% Displacement increment ---------------------------------------------------------------------------------------
if get(handles.CB_Disp_Inc, 'value')
    denied5 = abs(handles.MDL.T_Disp-handles.MDL.T_Disp_0) > handles.MDL.TGT_D_inc;     % Check absolute displacement increment
    if denied5(1)
    	set(handles.Edit_DLinc_DOF1, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF1, 'backgroundcolor',[1 1 1]);
    end
    if denied5(2)
    	set(handles.Edit_DLinc_DOF2, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF2, 'backgroundcolor',[1 1 1]);
    end
    if denied5(3)
    	set(handles.Edit_DLinc_DOF3, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF3, 'backgroundcolor',[1 1 1]);
    end
    if denied5(4)
    	set(handles.Edit_DLinc_DOF4, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF4, 'backgroundcolor',[1 1 1]);
    end
    if denied5(5)
    	set(handles.Edit_DLinc_DOF5, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF5, 'backgroundcolor',[1 1 1]);
    end
    if denied5(6)
    	set(handles.Edit_DLinc_DOF6, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF6, 'backgroundcolor',[1 1 1]);
    end
end

% Force limit ---------------------------------------------------------------------------------------
if get(handles.CB_Forc_Limit, 'value')
    denied3 = handles.MDL.M_Forc < handles.MDL.CAP_F_min;               % Check absolute displacement
    denied4 = handles.MDL.M_Forc > handles.MDL.CAP_F_max;               % Check absolute displacement
    
    if denied3(1)
    	set(handles.Edit_FLmin_DOF1, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF1, 'backgroundcolor',[1 1 1]);
    end
    if denied3(2)
    	set(handles.Edit_FLmin_DOF2, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF2, 'backgroundcolor',[1 1 1]);
    end
    if denied3(3)
    	set(handles.Edit_FLmin_DOF3, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF3, 'backgroundcolor',[1 1 1]);
    end
    if denied3(4)
    	set(handles.Edit_FLmin_DOF4, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF4, 'backgroundcolor',[1 1 1]);
    end
    if denied3(5)
    	set(handles.Edit_FLmin_DOF5, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF5, 'backgroundcolor',[1 1 1]);
    end
    if denied3(6)
    	set(handles.Edit_FLmin_DOF6, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF6, 'backgroundcolor',[1 1 1]);
    end

    if denied4(1)
    	set(handles.Edit_FLmax_DOF1, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF1, 'backgroundcolor',[1 1 1]);
    end
    if denied4(2)
    	set(handles.Edit_FLmax_DOF2, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF2, 'backgroundcolor',[1 1 1]);
    end
    if denied4(3)
    	set(handles.Edit_FLmax_DOF3, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF3, 'backgroundcolor',[1 1 1]);
    end
    if denied4(4)
    	set(handles.Edit_FLmax_DOF4, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF4, 'backgroundcolor',[1 1 1]);
    end
    if denied4(5)
    	set(handles.Edit_FLmax_DOF5, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF5, 'backgroundcolor',[1 1 1]);
    end
    if denied4(6)
    	set(handles.Edit_FLmax_DOF6, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF6, 'backgroundcolor',[1 1 1]);
    end
end


if any([denied1;denied2;denied3;denied4;denied5])
	accepted = 0;
	set(handles.PauseBut, 'value', 1);
	load Resources;
	wavplay(warn_wav,8000);
else
	accepted =1;
end
