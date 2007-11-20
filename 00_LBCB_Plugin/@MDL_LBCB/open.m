function obj = open(obj)

LPLogger('Connecting remote sites',3,1);
%if obj.Initialized
	LPLogger(sprintf('Connecting %s',obj.name),3,2);
	fopen(obj.Comm_obj);
	Sendvar_LabView(obj,sprintf('open-session\tdummyOpenSession'));
	Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
	Sendvar_LabView(obj,sprintf('set-parameter\tdummySetParam\tnstep\t%d',obj.totStep));
	Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
%end
LPLogger(sprintf('Connected\n'),3,3);