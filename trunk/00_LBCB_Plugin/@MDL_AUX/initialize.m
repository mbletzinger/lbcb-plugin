function obj = initialize(obj)
% =====================================================================================================================
% Initialize the MDL_RF object
%
% Last updated on 7/19/2006, OSK
% =====================================================================================================================

for objInd = 1:length(obj)
    %SCLogger(sprintf('Initializing module, %s', obj(objInd).name),3,2);

    % Create network communication objects
    obj(objInd).Initialized = 1;
    switch lower(obj(objInd).protocol)
        case {'ntcp'}			% will not be supported in later version. 
            myLogFile = 'NetwkLog.txt';
            LOGFILES = [{myLogFile};obj(objInd).NTCP_SCREENLOG];
            obj(objInd).Comm_obj = NTCP_Server(obj(objInd).URL,'',LOGFILES,'tag',obj(objInd).name,'secure',obj(objInd).NTCP_SECURE);

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