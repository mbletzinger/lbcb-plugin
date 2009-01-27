function close(obj)
% =====================================================================================================================
% This method sends finalize commands to remote site and closes connection.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  1/17/2007 11:42PM OSK, KSP
% Last updated  1/22/2007 KSP for NHCP protocol
% =====================================================================================================================
%LPLogger('Disconnecting remote sites',3,1);
%for i=1:length(obj)
%      try,
%        if obj.Initialized
%            SCLogger(sprintf('Disconnecting %s',obj.name),3,2);
%            updateGUI_Txt(obj,sprintf('Disconnecting %s ...',obj.name));
%            switch lower(obj.protocol)
%                case {'ntcp'}
%                    close(obj.Comm_obj);
%    
%                case {'tcpip'}
%                    if strcmp(obj.Comm_obj.Status,'open')                    % if connected
%                        Sendvar_TCPIP(obj,obj.CMD.RQST_TEST_COMPLETE);
%                        fclose(obj.Comm_obj);
%                    elseif strcmp(obj.Comm_obj.Status,'close')                % if already lost connection
%    
%                    end
%    
%                case {'labview1'}
                    if strcmp(obj.Comm_obj.Status,'open')                    % if connected
                        Sendvar_LabView(obj,sprintf('close-session\tdummy'));
                        %Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
                        fclose(obj.Comm_obj);
                    elseif strcmp(obj.Comm_obj.Status,'close')                % if already lost connection
    
                    end
    
%                case {'labview2'}
%                    if strcmp(obj.Comm_obj.Status,'open')                    % if connected
%                        Sendvar_LabView(obj,sprintf('close-session\tdummy'));
%                        Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
%                        fclose(obj.Comm_obj);
%                    elseif strcmp(obj.Comm_obj.Status,'close')                % if already lost connection
%    
%                    end
%                case {'openfresco1d'}
%                    dataSize = 2;
%                    sData = zeros(1,dataSize);
%                    sData(1) = 99;
%                    TCPSocket('sendData',obj.Comm_obj,sData,dataSize);
%                    TCPSocket('closeConnection',obj.Comm_obj);
%                    send_str = sprintf('send to %13s \tOpenFresco Module disconnected',obj.name);
%                    SCLogger(send_str,2);
%
%                case {'nhcp'}
%              			switch lower(obj.NHCPMode)
%              				case {'sim1d'}
%                    		NHCP(obj.NHCPMode,'close');
%                    		send_str = sprintf('send to %13s \tNHCP Simulation Module disconnected',obj.name);
%                    	case {'mm1'}
%                    	  NHCP(obj.NHCPMode,'close');
%                    		send_str = sprintf('send to %13s \tNHCP Mini MOST 1 Module disconnected',obj.name);
%                     	case {'mm2'}
%                    	  NHCP(obj.NHCPMode,'close');
%                    		send_str = sprintf('send to %13s \tNHCP Mini MOST 2 Module disconnected',obj.name);
%										end                     	
%                    SCLogger(send_str,2);
%
%            end
%      end
%      obj.curState = 1;  
%      updateGUI_Txt(obj,'Disconnected');
%    catch,
%        errstr = sprintf('Error closing connection.\nUnable to close remote site, %s', obj.name);
%        errmsg(errstr);
%    end
%end
LPLogger(sprintf('Disconnected\n'),3,3);