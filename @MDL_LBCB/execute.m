function obj = execute(obj)
% =====================================================================================================================
% This method sends execute commands.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  1/17/2007 11:35PM OSK, KSP
% Last updated  1/20/2007 KSP for NHCPSim1D
% =====================================================================================================================
% By Sung Jig Kim, 04/30/2009
send_str1 = sprintf('execute\t%s:LBCB2',obj.TransID);

 % by Sung Jig Kim, 05/02/2009
[obj.NetworkConnectionState]=SendandGetvar_LabView(obj, send_str1, 1); 

obj.curState = 2;
