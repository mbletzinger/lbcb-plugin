function obj = execute(obj)
% =====================================================================================================================
% This method sends execute commands.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  7/21/2006 2:38AM OSK
% =====================================================================================================================
for i=1:length(obj)
    try,
        switch lower(obj(i).protocol)
		    case {'ntcp'}                                   % protocol tcpip and labview2 cannot check relaxation 
			    execute(obj(i).Comm_obj(i),obj(i).TransID,-1);
            case {'labview1'}
                send_str = sprintf('execute\t%s',obj(i).TransID);
         	    Sendvar_LabView(obj(i),send_str);
			    Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
        end
        
    catch,
        switch lower(obj(i).protocol)
		    case {'ntcp'}
               	try,        % in case ntcp protocol, cancel the proposal.
                   		cancel(obj(i).Comm_obj(i),obj(i).TransID);
               	end
            case {'labview1'}
        end
        errstr = sprintf('Error sending Execute command.\nUnable to send to remote site, %s', obj(i).name);
        errmsg(errstr);
    end;
end