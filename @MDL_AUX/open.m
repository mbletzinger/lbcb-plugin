function obj = open(obj)

% =====================================================================================================================
% This method opens connection to remote site and send initialization commands.
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  5/10/2009 Sung Jig Kim
% =====================================================================================================================

for i=1:length(obj)

	if obj(i).NetworkConnectionState==0 & obj(i).Initialized==1
        disp('David');
	    tmp_bool=1; 
	    t_0=clock;  % current time
	    LPLogger(sprintf('Connecting %s',obj(i).name),3,2);

	    while tmp_bool
        	try,
                fopen(obj(i).Comm_obj);

                obj(i).NetworkConnectionState=1;
                [obj(i).NetworkConnectionState] = Sendvar_LabView(obj(i),sprintf('open-session\tdummyOpenSession'));
                if obj(i).NetworkConnectionState
                    [obj(i).NetworkConnectionState] = Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
                end
                LPLogger(sprintf('Connected\n'),3,3);
            	tmp_bool=0;
        	catch,
	            pause (0.5);
	            if etime(clock, t_0) > obj(i).NetworkWaitTime
	                Qst_Str1=sprintf ('The network %s seems not to be ready.',obj(i).name); 
	                Quest_string = {Qst_Str1;
	                                'Please, check network.';
	                                'Do you want to try again?'};
	                QuestResult = questdlg(Quest_string, 'Network Warning','Yes','No','Yes');
	                if strcmp(QuestResult,'Yes')
	                    t_0=clock;    % initialize current time
	                    LPLogger(sprintf('Connecting %s again', obj(i).name),3,2);
	                else 
	                    errstr = sprintf('       Error opening connection. Unable to connect to remote site, %s.', obj(i).name);
	            		disp(errstr);
	                    obj(i).NetworkConnectionState=0;
	                    tmp_bool=0;
	                end
	            end
			end
        end
    end
end
