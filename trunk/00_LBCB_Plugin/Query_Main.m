function handles = Query_Main(handles, varargin)

if varargin{1} == 1 
	% When module is connected
	handles.MDL = query_mean(handles.MDL,1);
elseif varargin{1} == 2 
	% Without Substep
	handles.MDL = query_mean(handles.MDL,2);
elseif varargin{1} == 3 
	% With Substep
	handles.MDL = query_mean(handles.MDL,3);	
end

% Update Monitor Panel
% For Model Coordinate
UpdateMonitorPanel (handles, 3);
% For LBCB Coordinate
UpdateMonitorPanel (handles, 4);
