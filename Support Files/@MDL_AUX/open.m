function obj = open(obj,varargin)

% =====================================================================================================================
% This method opens connection to remote site and send initialization commands.
%
% Written by    7/21/2006 2:20AM OSK
% Last updated  7/21/2006 2:20AM OSK
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
	LPLogger('Connecting remote sites',3,1);
end

for j=1:NumConnectModule
	i=Aux_index(j);
    try,
    	if obj(i).Initialized
	        LPLogger(sprintf('Connecting %s',obj(i).name),3,2);
	        %updateGUI_Txt(obj(i),sprintf('Connecting %s ...',obj(i).name));
	        
	        switch lower(obj(i).protocol)
	            case {'ntcp'}
	                modelProperty = {'part',obj(i).NTCP_MDL_Part,'role',obj(i).NTCP_MDL_Role};
	                open(obj(i).Comm_obj,'model',obj(i).MODEL,modelProperty{:},'simulation',obj(i).SIMULATION);
	                set(obj(i).Comm_obj,'nstep',obj(i).totStep);
	
	            case {'labview1'}
	                fopen(obj(i).Comm_obj);
	                Sendvar_LabView(obj(i),sprintf('open-session\tdummyOpenSession'));
	                Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
%	                Sendvar_LabView(obj(i),sprintf('set-parameter\tdummySetParam\tnstep\t%d',obj(i).totStep));
%	                Getvar_LabView(obj(i),obj(i).CMD.ACKNOWLEDGE);
	        end
	       % disp(sprintf('Connection is established with %s.',obj(i).name));
	        %updateGUI_Txt(obj(i),'Connected.');
		end
    catch,
        errstr = sprintf('Error opening connection.\nUnable to connect to remote site, %s.', obj(i).name);
        errmsg(errstr);
    end;
end

if length(obj) > 0
		LPLogger(sprintf('Connected\n'),3,3);
end

