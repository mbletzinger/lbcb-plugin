function obj = execute(obj)
% =====================================================================================================================
% This method sends execute commands.
%
% Written by    7/21/2006 2:31AM OSK
% Last updated  1/17/2007 11:35PM OSK, KSP
% Last updated  1/20/2007 KSP for NHCPSim1D
% =====================================================================================================================

% cd('..');
% cd('Output Files');
send_str = sprintf('execute\t%s',obj.TransID);
Sendvar_LabView(obj,send_str);
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);
% cd('..');
% cd('Support Files');

obj.curState = 2;
      
