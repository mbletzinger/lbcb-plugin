function ConnectionState = Getvar_LabView(obj, varargin)
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

ConnectionState=1;
t_0=clock;  % current time

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
	
	% Modified by Sung Jig Kim, 05/02/2009
    if etime(clock, t_0) > obj.NetworkWaitTime
    	Q_Str1=sprintf('The connection to %s seems to be failed', obj.name);
    	 Quest_string = {Q_Str1;
							'Please, check network.';
							'Do you want to try again?';
							'Select ''No'' if you want to disconnect the current network and reconnect'};
		 QuestResult = questdlg(Quest_string, 'Network Warning','Yes','No','Yes');
		 if strcmp(QuestResult,'Yes')
		 	t_0=clock;    % initialize current time
		 else 
         	disp(sprintf(' * Connection failure. Check network. '));  
         	EOL = 1;
         	ConnectionState=0;
         end
    end     
end


stmp = sprintf('recv from %11s ',obj.name);                 % Initialize network log
if ConnectionState
	stmp = sprintf('%s  %s',stmp, recv_str(1:end-1));
else
	stmp = sprintf('%s  Connection failure',stmp);
end
LPLogger(stmp,2);

