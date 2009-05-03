function varargout = SendandGetvar_LabView(obj, send_str, varargin)
% =====================================================================================================================
% This method sends command and recevie data
%
% Written by    3/22/2008 Sung Jig Kim
% Updated by    5/02/2009 Sung Jig Kim
% =====================================================================================================================

[ConnectionState]=Sendvar_LabView(obj,send_str);

if ConnectionState==1
	switch varargin{1}
		case 1  % open, propose, execute
			[ConnectionState]=Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
			varargout{1}=ConnectionState;
	
		case 2  % query 
			[ConnectionState, recv_str] = Getvar_LabView(obj,obj.CMD.RPLY_PUT_DATA);  		% Receive data for control point j
			varargout{1} = ConnectionState;
	    	varargout{2} = recv_str;
	
		case 3  % close 
				% do nothing
	end
else % if connection is failed 
	switch varargin{1}
		case 1 % open, propose, execute
			varargout{1} = ConnectionState;
		case 2  % query 
			varargout{1} = ConnectionState;
	    	varargout{2} = '';
		case 3  % close 
				% do nothing	
	end
end