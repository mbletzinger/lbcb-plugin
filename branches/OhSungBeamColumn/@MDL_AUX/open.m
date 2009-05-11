function obj = open(obj)

% =====================================================================================================================
% This method opens connection to remote site and send initialization commands.
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  5/10/2009 Sung Jig Kim
% =====================================================================================================================
if length(obj) > 0
	SCLogger('Connecting remote sites',3,1);
end

for i=1:length(obj)
    try,
    	if obj(i).NetworkConnectionState==0 & obj(i).Initialized==1
	        SCLogger(sprintf('Connecting %s',obj(i).name),3,2);
	        updateGUI_Txt(obj(i),sprintf('Connecting %s ...',obj(i).name));
	        
	        fopen(obj(i).Comm_obj);
	        
	        obj(i).NetworkConnectionState=1;
	        [obj(i).NetworkConnectionState] = Sendvar_LabView(obj(i),sprintf('open-session\tdummyOpenSession'));
	        if obj(i).NetworkConnectionState
	        	[obj(i).NetworkConnectionState] = Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
	        end
		end
    catch,
    	pause (0.5);
	    obj(i).NetworkConnectionState=0;
        errstr = sprintf('Error opening connection.\nUnable to connect to remote site, %s.', obj(i).name);
        errmsg(errstr);
    end;
end

if length(obj) > 0
		SCLogger(sprintf('Connected\n'),3,3);
end
