function [obj transId] = propose(obj)

%obj.curStep = obj.curStep +1;         % increase current step number
transId  = sprintf('trans%4d%02d%02d%02d%02d%5.3f',clock);       % Create transaction ID
send_str = assembleProposeMsg(obj,obj.SubTgt.Lbcb1,transId,'LBCB1');
Sendvar_LabView(obj,send_str);                                  % Send proposing command
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);                        % Receive acknowledgement
send_str = assembleProposeMsg(obj,obj.SubTgt.Lbcb2,transId,'LBCB2');
Sendvar_LabView(obj,send_str);                                  % Send proposing command
Getvar_LabView(obj,obj.CMD.ACKNOWLEDGE);                        % Receive acknowledgement


% obj.T_Disp_0 = obj.T_Disp;
% obj.T_Forc_0 = obj.T_Forc;
% % For Substep
% obj.LBCB_Target_0 = obj.LBCB_Target_1;
% 
% %obj.tDisp_history(obj.curStep,:)    = obj.T_Disp;
% obj.tDisp_history(obj.curStep,:)          = obj.LBCB_Target_1;
% obj.Model_tDisp_history(obj.StepNos,:)    = obj.LBCB_Target_1;
% 
% obj.tForc_history(obj.curStep,:)    = obj.T_Forc;
% 
% obj.curState = 1;  
% 
% % For UI-SimCor or Text input Step
% obj.tDisp_history_SC(obj.curStep,:) = obj.T_Disp_SC_his;
% obj.Model_tDisp_history_SC(obj.StepNos,:) = obj.T_Disp_SC_his;
% 
