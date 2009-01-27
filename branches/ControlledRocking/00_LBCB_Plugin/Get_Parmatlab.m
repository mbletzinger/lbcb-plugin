function varargout = Get_Parmatlab(tcp_handle, varargin)
% =====================================================================================================================
% Receive data from remote site using LabView protocol
%
%   obj     : A MDL_RF objects representing remote sites
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================

EOL = 0;                                                    % reached end of line?
recv_str = '';

bytes = 1024;	% read 1024 byte
while EOL == 0;
		tmp_recv = tcpip_readln(tcp_handle,bytes );
		received_bytes = length(tmp_recv);
        	recv_str = [recv_str tmp_recv];
		
		if received_bytes > 0 
        	if tmp_recv(end) ==10
            	EOL = 1;
        	end
        end
    pause(0.001);
end

if nargin > 1
	if varargin{1} == 1						% if asking for data
    	varargout{1} = recv_str;
	end
end

stmp = sprintf('%s  ',recv_str(1:end-1));
DataLogger(stmp,2);
