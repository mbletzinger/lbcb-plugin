function close(obj,varargin)
% =====================================================================================================================
% This method sends finalize commands to remote site and closes connection.
%
% Written by    7/21/2006 2:31AM O. Kwon
% Last updated  7/21/2006 2:31AM O. Kwon
% =====================================================================================================================

if length(varargin) == 1 
	NumConnectModule = length(obj);	
	Aux_index=1:1:NumConnectModule;
else
	NumConnectModule=varargin{1};
	for i=1:NumConnectModule
		Aux_index(i)=varargin{2}(i);
	end
end

if length(obj) > 0
	LPLogger('Disconnecting remote sites',3,1);
end

for j=1:NumConnectModule
	i=Aux_index(j);
	try,
		if obj(i).Initialized
	        	LPLogger(sprintf('Disconnecting %s',obj(i).name),3,2);
	        	        
		        switch lower(obj(i).protocol)
				case {'ntcp'}
		                	close(obj(i).Comm_obj);
				case {'labview1'}
		                	if strcmp(obj(i).Comm_obj.Status,'open')                    % if connected
		                    		Sendvar_LabView(obj(i),sprintf('close-session\tdummy'));
		                    		%Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
		                    		fclose(obj(i).Comm_obj);
		                	elseif strcmp(obj(i).Comm_obj.Status,'close')                % if already lost connection
		                end
		        end
		end
	catch,
        	errstr = sprintf('Error closing connection.\nUnable to close remote site, %s', obj(i).name);
        	errmsg(errstr);
    	end
end
if length(obj) > 0
	LPLogger(sprintf('Disconnected\n'),3,3);
end
