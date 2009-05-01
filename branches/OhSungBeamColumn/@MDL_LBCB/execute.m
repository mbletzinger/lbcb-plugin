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
send_str2 ='DummyExecute';
Sendvar_LabView(obj,send_str1,send_str2);
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE, 2);


obj.curState = 2;
