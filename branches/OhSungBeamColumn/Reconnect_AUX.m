function handles = Reconnect_AUX(handles)
% =====================================================================================================================
% Reconnect remote site using LABVIEW protocol
%
% Written by    5/02/2009 Sung Jig KIM
% Last update   5/02/2009 Sung Jig KIM
% =====================================================================================================================
% Disconnect Modules
Disconnect_ID= abs(get(handles.PB_AuxModule_Connect, 'UserData')-1);
close(handles.AUX, Disconnect_ID);

% Connect...

handles.AUX = open(handles.AUX);    

for i=1:length(handles.AUX)
	AUX_Network_Bool(i)=handles.AUX(i).NetworkConnectionState;
end

set(handles.PB_AuxModule_Connect, 'UserData',AUX_Network_Bool);

if all (AUX_Network_Bool)
	disp ('Connection is established with AUX Modules.');
	set (handles.PB_AuxModule_Reconnect,  'enable', 'off');
else
	Help_String='Some of Connection do not present. Try it again';
	helpdlg(Help_String,'Warning');
	set (handles.PB_AuxModule_Reconnect,  'enable', 'on');
end
