function obj = open(obj)

LPLogger('Connecting LBCB1 & LBCB2',3,1);
LPLogger(sprintf('Connecting LBCBs'),3,2);
fopen(obj.Comm_obj_1);
send_str = sprintf('open-session\tdummyOpenSession');
%%%%
%% by Sung Jig Kim, 05/02/2009
[obj.NetworkConnectionState]=SendandGetvar_LabView(obj, send_str, 1);
%%%%
if obj.NetworkConnectionState==1
	LPLogger(sprintf('Connected\n'),3,3);
else
	LPLogger(sprintf('No connection present\n'),3,3);
end
