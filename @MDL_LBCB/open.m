function obj = open(obj)

LPLogger('Connecting LBCB1 & LBCB2',3,1);
%if obj.Initialized
	LPLogger(sprintf('Connecting LBCBs'),3,2);
	fopen(obj.Comm_obj_1);
	fopen(obj.Comm_obj_2);
	Sendvar_LabView(obj,sprintf('open-session\tdummyOpenSession'),sprintf('open-session\tdummyOpenSession'));
	Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
	Sendvar_LabView(obj,sprintf('set-parameter\tdummySetParam\tnstep\t%d',obj.totStep),sprintf('set-parameter\tdummySetParam\tnstep\t%d',obj.totStep));
	Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
%end
LPLogger(sprintf('Connected\n'),3,3);
