function [accepted] = LimitCheck(handles)

denied1 = zeros(12,1);
denied2 = zeros(12,1);
denied3 = zeros(12,1);
denied4 = zeros(12,1);
denied5 = zeros(12,1);
%
%% Displacement limit ---------------------------------------------------------------------------------------
    
    

if get(handles.CB_Disp_Limit1, 'value')    
    denied1(1:6,1) = handles.MDL.T_Disp(1:6,1) < handles.MDL.CAP_D_min(1:6,1);               % Check absolute displacement  
    denied2(1:6,1) = handles.MDL.T_Disp(1:6,1) > handles.MDL.CAP_D_max(1:6,1);               % Check absolute displacement      if denied1(1)
    
    if denied1(1)  
    	set(handles.Edit_DLmin_DOF11, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF11, 'backgroundcolor',[1 1 1]);
    end
    if denied1(2)
    	set(handles.Edit_DLmin_DOF12, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF12, 'backgroundcolor',[1 1 1]);
    end
    if denied1(3)
    	set(handles.Edit_DLmin_DOF13, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF13, 'backgroundcolor',[1 1 1]);
    end
    if denied1(4)
    	set(handles.Edit_DLmin_DOF14, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF14, 'backgroundcolor',[1 1 1]);
    end
    if denied1(5)
    	set(handles.Edit_DLmin_DOF15, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF15, 'backgroundcolor',[1 1 1]);
    end
    if denied1(6)
    	set(handles.Edit_DLmin_DOF16, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF16, 'backgroundcolor',[1 1 1]);
    end
    
    if denied2(1)
    	set(handles.Edit_DLmax_DOF11, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF11, 'backgroundcolor',[1 1 1]);
    end
    if denied2(2)
    	set(handles.Edit_DLmax_DOF12, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF12, 'backgroundcolor',[1 1 1]);
    end
    if denied2(3)
    	set(handles.Edit_DLmax_DOF13, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF13, 'backgroundcolor',[1 1 1]);
    end
    if denied2(4)
    	set(handles.Edit_DLmax_DOF14, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF14, 'backgroundcolor',[1 1 1]);
    end
    if denied2(5)
    	set(handles.Edit_DLmax_DOF15, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF15, 'backgroundcolor',[1 1 1]);
    end
    if denied2(6)
    	set(handles.Edit_DLmax_DOF16, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF16, 'backgroundcolor',[1 1 1]);
    end
end

if get(handles.CB_Disp_Limit2, 'value')    
    denied1(7:12,1) = handles.MDL.T_Disp(7:12,1) < handles.MDL.CAP_D_min(7:12,1);               % Check absolute displacement  
    denied2(7:12,1) = handles.MDL.T_Disp(7:12,1) > handles.MDL.CAP_D_max(7:12,1);               % Check absolute displacement      if denied1(1)

    if denied1(7)
    	set(handles.Edit_DLmin_DOF21, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF21, 'backgroundcolor',[1 1 1]);
    end
    if denied1(8)
    	set(handles.Edit_DLmin_DOF22, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF22, 'backgroundcolor',[1 1 1]);
    end
    if denied1(9)
    	set(handles.Edit_DLmin_DOF23, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF23, 'backgroundcolor',[1 1 1]);
    end
    if denied1(10)
    	set(handles.Edit_DLmin_DOF24, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF24, 'backgroundcolor',[1 1 1]);
    end
    if denied1(11)
    	set(handles.Edit_DLmin_DOF25, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF25, 'backgroundcolor',[1 1 1]);
    end
    if denied1(12)
    	set(handles.Edit_DLmin_DOF26, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmin_DOF26, 'backgroundcolor',[1 1 1]);
    end
    if denied2(7)
    	set(handles.Edit_DLmax_DOF21, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF21, 'backgroundcolor',[1 1 1]);
    end
    if denied2(8)
    	set(handles.Edit_DLmax_DOF22, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF22, 'backgroundcolor',[1 1 1]);
    end
    if denied2(9)
    	set(handles.Edit_DLmax_DOF23, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF23, 'backgroundcolor',[1 1 1]);
    end
    if denied2(10)
    	set(handles.Edit_DLmax_DOF24, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF24, 'backgroundcolor',[1 1 1]);
    end
    if denied2(11)
    	set(handles.Edit_DLmax_DOF25, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF25, 'backgroundcolor',[1 1 1]);
    end
    if denied2(12)
    	set(handles.Edit_DLmax_DOF26, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLmax_DOF26, 'backgroundcolor',[1 1 1]);
    end
end


% Displacement increment ---------------------------------------------------------------------------------------
if get(handles.CB_Disp_Inc1, 'value')
    denied5(1:6) = abs(handles.MDL.T_Disp(1:6)-handles.MDL.T_Disp_0(1:6)) > handles.MDL.TGT_D_inc(1:6);              % Check absolute displacement increment    
    if denied5(1)
    	set(handles.Edit_DLinc_DOF11, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF11, 'backgroundcolor',[1 1 1]);
    end
    if denied5(2)
    	set(handles.Edit_DLinc_DOF12, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF12, 'backgroundcolor',[1 1 1]);
    end
    if denied5(3)
    	set(handles.Edit_DLinc_DOF13, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF13, 'backgroundcolor',[1 1 1]);
    end
    if denied5(4)
    	set(handles.Edit_DLinc_DOF14, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF14, 'backgroundcolor',[1 1 1]);
    end
    if denied5(5)
    	set(handles.Edit_DLinc_DOF15, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF15, 'backgroundcolor',[1 1 1]);
    end
    if denied5(6)
    	set(handles.Edit_DLinc_DOF16, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF16, 'backgroundcolor',[1 1 1]);
    end
end

if get(handles.CB_Disp_Inc2, 'value')
    denied5(7:12) = abs(handles.MDL.T_Disp(7:12)-handles.MDL.T_Disp_0(7:12)) > handles.MDL.TGT_D_inc(7:12);              % Check absolute displacement increment    
    if denied5(7)
    	set(handles.Edit_DLinc_DOF21, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF21, 'backgroundcolor',[1 1 1]);
    end
    if denied5(8)
    	set(handles.Edit_DLinc_DOF22, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF22, 'backgroundcolor',[1 1 1]);
    end
    if denied5(9)
    	set(handles.Edit_DLinc_DOF23, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF23, 'backgroundcolor',[1 1 1]);
    end
    if denied5(10)
    	set(handles.Edit_DLinc_DOF24, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF24, 'backgroundcolor',[1 1 1]);
    end
    if denied5(11)
    	set(handles.Edit_DLinc_DOF25, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF25, 'backgroundcolor',[1 1 1]);
    end
    if denied5(12)
    	set(handles.Edit_DLinc_DOF26, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_DLinc_DOF26, 'backgroundcolor',[1 1 1]);
    end
end



% Force limit ---------------------------------------------------------------------------------------
if get(handles.CB_Forc_Limit1, 'value')		% measured force
    denied3(1:6) = handles.MDL.M_Forc(1:6) < handles.MDL.CAP_F_min(1:6);               % Check absolute displacement
    denied4(1:6) = handles.MDL.M_Forc(1:6) > handles.MDL.CAP_F_max(1:6);               % Check absolute displacement
    
    if denied3(1)
    	set(handles.Edit_FLmin_DOF11, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF11, 'backgroundcolor',[1 1 1]);
    end
    if denied3(2)
    	set(handles.Edit_FLmin_DOF12, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF12, 'backgroundcolor',[1 1 1]);
    end
    if denied3(3)
    	set(handles.Edit_FLmin_DOF13, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF13, 'backgroundcolor',[1 1 1]);
    end
    if denied3(4)
    	set(handles.Edit_FLmin_DOF14, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF14, 'backgroundcolor',[1 1 1]);
    end
    if denied3(5)
    	set(handles.Edit_FLmin_DOF15, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF15, 'backgroundcolor',[1 1 1]);
    end
    if denied3(6)
    	set(handles.Edit_FLmin_DOF16, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF16, 'backgroundcolor',[1 1 1]);
    end

    if denied4(1)
    	set(handles.Edit_FLmax_DOF11, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF11, 'backgroundcolor',[1 1 1]);
    end
    if denied4(2)
    	set(handles.Edit_FLmax_DOF12, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF12, 'backgroundcolor',[1 1 1]);
    end
    if denied4(3)
    	set(handles.Edit_FLmax_DOF13, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF13, 'backgroundcolor',[1 1 1]);
    end
    if denied4(4)
    	set(handles.Edit_FLmax_DOF14, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF14, 'backgroundcolor',[1 1 1]);
    end
    if denied4(5)
    	set(handles.Edit_FLmax_DOF15, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF15, 'backgroundcolor',[1 1 1]);
    end
    if denied4(6)
    	set(handles.Edit_FLmax_DOF16, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF16, 'backgroundcolor',[1 1 1]);
    end
end

if get(handles.CB_Forc_Limit2, 'value')		% measured force
    denied3(7:12) = handles.MDL.M_Forc(7:12) < handles.MDL.CAP_F_min(7:12);               % Check absolute displacement
    denied4(7:12) = handles.MDL.M_Forc(7:12) > handles.MDL.CAP_F_max(7:12);               % Check absolute displacement
    
    if denied3(7)
    	set(handles.Edit_FLmin_DOF21, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF21, 'backgroundcolor',[1 1 1]);
    end
    if denied3(8)
    	set(handles.Edit_FLmin_DOF22, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF22, 'backgroundcolor',[1 1 1]);
    end
    if denied3(9)
    	set(handles.Edit_FLmin_DOF23, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF23, 'backgroundcolor',[1 1 1]);
    end
    if denied3(10)
    	set(handles.Edit_FLmin_DOF24, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF24, 'backgroundcolor',[1 1 1]);
    end
    if denied3(11)
    	set(handles.Edit_FLmin_DOF25, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF25, 'backgroundcolor',[1 1 1]);
    end
    if denied3(12)
    	set(handles.Edit_FLmin_DOF26, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmin_DOF26, 'backgroundcolor',[1 1 1]);
    end

    if denied4(7)
    	set(handles.Edit_FLmax_DOF21, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF21, 'backgroundcolor',[1 1 1]);
    end
    if denied4(8)
    	set(handles.Edit_FLmax_DOF22, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF22, 'backgroundcolor',[1 1 1]);
    end
    if denied4(9)
    	set(handles.Edit_FLmax_DOF23, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF23, 'backgroundcolor',[1 1 1]);
    end
    if denied4(10)
    	set(handles.Edit_FLmax_DOF24, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF24, 'backgroundcolor',[1 1 1]);
    end
    if denied4(11)
    	set(handles.Edit_FLmax_DOF25, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF25, 'backgroundcolor',[1 1 1]);
    end
    if denied4(12)
    	set(handles.Edit_FLmax_DOF26, 'backgroundcolor',[1 0.5 0.5]);
    else
    	set(handles.Edit_FLmax_DOF26, 'backgroundcolor',[1 1 1]);
    end
end


if any([denied1;denied2;denied3;denied4;denied5])
	accepted = 0;
	set(handles.PB_Pause, 'value', 0);
	load Resources;
	wavplay(warn_wav,8000);
else
	accepted =1;
end
