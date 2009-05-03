function ConnectionState = Sendvar_LabView(obj,varargin)
% =====================================================================================================================
% Send data to remote site using LABVIEW protocol
%
%   obj     : A MDL_RF objects representing remote sites
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 8:40PM OSK
% =====================================================================================================================


send_str1 = [varargin{1} 10];                                   % add new line character at the end
bufferSize = 512;                                           % send data

ErrBool = 1; 
t_0=clock;  % current time
ConnectionState=1; 
 % Modified by Sung Jig Kim, 05/02/2009
while ErrBool == 1
	try
		for i=1:floor(length(send_str1)/bufferSize)
		    fwrite(obj.Comm_obj_1,send_str1((i-1)*bufferSize+1:i*bufferSize));
		end
		tmp = floor(length(send_str1)/bufferSize);
		fwrite(obj.Comm_obj_1,send_str1(tmp*bufferSize+1:end));
		ErrBool=0; 
		
	catch
		pause (0.5);
        if etime(clock, t_0) > obj.NetworkWaitTime
        	Quest_string = {'The connection to LBCB OM seems to be failed.';
							'Please, check network.';
							'Do you want to try again?';
							'Select ''No'' if you want to disconnect the current network and reconnect LBCB OM'};
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

if ConnectionState==1
	stmp = sprintf('send to OperationManager');           % Initialize network log
	stmp = sprintf('%s  %s',stmp, send_str1(1:end-1));
else
	stmp = sprintf('send to OperationManager');           % Initialize network log
	stmp = sprintf('%s  Connection failure',stmp);
end
LPLogger(stmp,2);
