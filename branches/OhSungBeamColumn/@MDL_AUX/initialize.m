function obj = initialize(obj)
% =====================================================================================================================
% Initialize the MDL_RF object
%
% Last updated on 05/10/2009, Sung Jig Kim
% =====================================================================================================================

for objInd = 1:length(obj)
    % Create network communication objects
    obj(objInd).Initialized = 1;
    obj(objInd).NetworkConnectionState = 0;                            % Initialize connection state
    switch lower(obj(objInd).protocol)
        case {'labview1'}
            tmp = max(find(obj(objInd).URL == ':'))+1;              	% find position of port number
            IP  = obj(objInd).URL(1:tmp-2);                         	% copy IP address
            tmp = obj(objInd).URL(tmp:end);                         	% copy port number
            tmp(find(tmp=='/')) = ' ';                     		        % replace end backslash
            Port = str2num(tmp);
            obj(objInd).Comm_obj = tcpip(IP,Port);                  	% create TCPIP obj(objInd)ect
            set(obj(objInd).Comm_obj,'InputBufferSize', 1024*100);      % set buffer size

        otherwise
            dispmsg(sprintf('Unknown communication protocol, %s.',obj(objInd).protocol));
            obj(objInd).Initialized = 0;
    end
end
obj(objInd).curStep = 0;