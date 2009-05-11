function close(obj,varargin)
% =====================================================================================================================
% This method sends finalize commands to remote site and closes connection.
%
% Written by    7/21/2006 2:31AM O. Kwon
% Last updated  7/21/2006 2:31AM O. Kwon
% =====================================================================================================================
if length(obj) > 0
	LPLogger('Connecting remote sites',3,1);
end

for i=1:length(obj)
	if varargin{1}(i)==1
		try,
	        LPLogger(sprintf('Disconnecting %s',obj(i).name),3,2);
			if strcmp(obj(i).Comm_obj(i).Status,'open')                    % if connected
				Sendvar_LabView(obj,sprintf('close-session\tdummy'));
				fclose(obj(i).Comm_obj);
			elseif strcmp(obj(i).Comm_obj(i).Status,'close')                % if already lost connection
		    end
		    LPLogger(sprintf('Disconnected\n'),3,3);
		catch,
	    	errstr = sprintf('Error closing connection.\nUnable to close remote site, %s', obj(i).name);
	    	errmsg(errstr);
		end
	end
end
	
