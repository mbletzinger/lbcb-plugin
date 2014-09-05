function SSW_DdPrelimAdjust(me,step)
me.log.debug(dbstack,'Running preliminary adjustment fcn');

%Look up Dz and Rx targets from previous step, if exists
prevL1CmdDz = me.getArch('L1PrevCmdDz');
prevL2CmdDz = me.getArch('L2PrevCmdDz');

prevEdDz = me.getArch('EdDz');
correctL1= prevL1CmdDz - prevEdDz;
correctL2 = prevL2CmdDz - prevEdDz;

%Read dx and dy target for current step
[disp , ~, ~, ~] = step.lbcbCps{1}.cmdData();
targetL1Dz = disp(3);        
[disp, ~, ~, ~] = step.lbcbCps{2}.cmdData();
targetL2Dz = disp(3);        
avgDz = (targetL1Dz + targetL2Dz)/2;
me.putArch('CorrectDz',avgDz);

cf = me.getOrDefault('PrelimEdCorrectionFactor',1,1);

newL1Dz = targetL1Dz + correctL1 * cf;
newL2Dz = targetL2Dz + correctL2 * cf;
str = sprintf('Cmd: %s\n',step.lbcbCps{1}.command.toString());
str = sprintf('%sCmd: %s\n',str,step.lbcbCps{1}.command.toString());
str = sprintf('%sPrelimCorrectionFactor: %f\n',str,cf);

step.lbcbCps{1}.command.setDispDof(3,newL1Dz);
step.lbcbCps{2}.command.setDispDof(3,newL2Dz);
str = sprintf('%sAdjusted Cmd: %s\n',step.lbcbCps{1}.command.toString());
str = sprintf('%sAdjustedCmd: %s\n',str,step.lbcbCps{1}.command.toString());
me.log.debug(dbstack,str);

end