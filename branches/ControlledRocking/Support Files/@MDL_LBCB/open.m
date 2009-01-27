function obj = open(obj)

LPLogger('Connecting remote sites',3,1);

LPLogger(sprintf('Connecting %s',obj.name),3,2);
fopen(obj.Comm_obj);

cd('..');
cd('Output Files');
Sendvar_LabView(obj,sprintf('open-session\tdummyOpenSession'));
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
Sendvar_LabView(obj,sprintf('set-parameter\tdummySetParam\tnstep\t%d',obj.totStep));
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
cd('..');
cd('Support Files');

LPLogger(sprintf('Connected\n'),3,3);