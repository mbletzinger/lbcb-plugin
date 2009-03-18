function obj = execute(obj,transId)
% =====================================================================================================================
% This method sends execute commands.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  1/17/2007 11:35PM OSK, KSP
% Last updated  1/20/2007 KSP for NHCPSim1D
% =====================================================================================================================

send_str = sprintf('execute\t%s',transId);
Sendvar_LabView(obj,send_str);
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);

obj.curState = 2;