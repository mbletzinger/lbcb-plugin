function ConnectionState = Sendvar_LabView(obj, send_str)
% =====================================================================================================================
% Send data to remote site using LabView protocol
%
%   obj     : A MDL_RF objects representing remote sites
% 05/10/2009  Sung Jig Kim
% =====================================================================================================================


send_str = [send_str 10];                                   % add new line character at the end
bufferSize = 512;                                           % send data

ErrBool = 1; 
t_0=clock;  % current time
ConnectionState=1; 
 % Modified by Sung Jig Kim, 05/02/2009
while ErrBool == 1
	try
		for i=1:floor(length(send_str)/bufferSize)
		    fwrite(obj.Comm_obj,send_str((i-1)*bufferSize+1:i*bufferSize));
		end
		tmp = floor(length(send_str)/bufferSize);
		fwrite(obj.Comm_obj,send_str(tmp*bufferSize+1:end));
		ErrBool=0; 
		
	catch
		pause (0.5);
        if etime(clock, t_0) > obj.NetworkWaitTime
        	Q_Str1=sprintf('The connection to %s seems to be failed', obj.name);
        	Quest_string = {Q_Str1;
							'Please, check network.';
							'Do you want to try again?';
							'Select ''No'' if you want to disconnect the current network and reconnect it'};
			QuestResult = questdlg(Quest_string, 'Network Warning','Yes','No','Yes');
			if strcmp(QuestResult,'Yes')
				t_0=clock;    % initialize current time
			else 
				disp(sprintf(' * Connection failure. Check network.'));  
	            ErrBool=0;
	            ConnectionState=0;
			end
        end
     end
end	


stmp = sprintf('send to %13s ',obj.name);           % Initialize network log
if ConnectionState==1
	stmp = sprintf('%s  %s',stmp, send_str(1:end-1));
else
	stmp = sprintf('%s  Connection failure',stmp);
end
LPLogger(stmp,2);