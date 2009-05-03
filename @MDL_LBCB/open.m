function obj = open(obj)

LPLogger('Connecting LBCB1 & LBCB2',3,1);
LPLogger(sprintf('Connecting LBCBs'),3,2);

% Modified by Sung Jig Kim, 05/03/2009
tmp_bool=1; 
t_0=clock;  % current time
while tmp_bool
	try
		fopen(obj.Comm_obj_1);
		tmp_bool=0;
	catch
		pause (0.5);
        if etime(clock, t_0) > obj.NetworkWaitTime
        	Quest_string = {'The network LBCB OM seems not to be ready.';
							'Please, check network.';
							'Do you want to try again?'};
			QuestResult = questdlg(Quest_string, 'Network Warning','Yes','No','Yes');
			if strcmp(QuestResult,'Yes')
				t_0=clock;    % initialize current time
				LPLogger(sprintf('Connecting LBCBs again'),3,2);
			else 
				disp(sprintf(' No connection to the LBCB OM presents...'));  
	            obj.NetworkConnectionState=0;
	            tmp_bool=0;
			end
        end
     end
end	

%% by Sung Jig Kim, 05/02/2009
if obj.NetworkConnectionState
	send_str = sprintf('open-session\tdummyOpenSession');
	[obj.NetworkConnectionState]=SendandGetvar_LabView(obj, send_str, 1);
end

if obj.NetworkConnectionState
	LPLogger(sprintf('Connected\n'),3,3);
else
	LPLogger(sprintf('No connection present\n'),3,3);
end
