function UpdateUserCMD (varargin)
%-----------------------------------------------------
% varargin{1} = {handles.User_Cmd_DOF1, handles.ED_UserCMD_Increment_DOF1, handles.MDL.LBCB_FrcCtrlDOF(1)}
% varargin{2} = Incr_Decr;
%---------------------------------------------------

UpdateDOF_val=str2num(get(varargin{1}{1}, 'string'));

Increment=abs(str2num(get(varargin{1}{2}, 'string')));

if varargin{1}{3}==0  % Displacement
	format_str = '%+12.7f';
else  % force
	format_str = '%+12.3f';
end

if varargin{2}==-1  % to decrease value
	Increment=-Increment;
end

UpdateDOF_val=UpdateDOF_val+Increment;

set(varargin{1}{1}, 'string' ,sprintf (format_str,UpdateDOF_val));

