function varargout = Getvar_LabView(obj, varargin)
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

while EOL == 0;
    bytes = get(obj.Comm_obj, 'BytesAvailable');
    if bytes>0
        [tmp_recv received_bytes] = fread(obj.Comm_obj,bytes);
        recv_str = sprintf('%s%s',recv_str,char(tmp_recv));

        if tmp_recv(end) ==10
            EOL = 1;
        end
    end
    pause(0.001);
end

if varargin{1} == obj.CMD.RPLY_PUT_DATA
    varargout{1} = recv_str;
end

stmp = sprintf('recv from %11s ',obj.name);                 % Initialize network log
stmp = sprintf('%s  %s',stmp, recv_str(1:end-1));
LPLogger(stmp,2);