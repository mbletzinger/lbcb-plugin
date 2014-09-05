function SSW_Dd0AdjustTarget(me,step)
me.log.debug(dbstack,'Running displacement adjustment fcn');
% Three corrections Dz, Rx, and Ry
tol = zeros(1,3);
ed = zeros(1,3);
dofs = [3,4,5];
target = zeros(1,3);

tol(1) = me.getOrDefault('TolDz',1,1);
tol(2) = me.getOrDefault('TolRx',1,1);
tol(3)= me.getOrDefault('TolRy',1,1);
ed(1) = me.getOrDefault('EdDz',0,3);
ed(2) = me.getOrDefault('EdRx',0,3);
ed(3) = me.getOrDefault('EdRy',0,3);

commandArm = me.getCfg('RyCmdArm');

target(1) = me.getArch('CorrectDz');
prev = zeros(2,3);
prev(1,1) = me.getArch('L1PrevCmdDz');
prev(2,1) = me.getArch('L2PrevCmdDz');
cf = me.getOrDefault('EdCorrectionFactor',1,1);

str = sprintf('Cmd: %s\n',curStep.lbcbCps{1}.command.toString());
str = sprintf('%sCmd: %s\n',str,curStep.lbcbCps{1}.command.toString());
str = sprintf('%sCorrectionFactor: %f\n',str,cf);

dz = prev(1:2,1);

for d = 1:3
    commands = zeros(2,1);
    correct = target(d) - ed(d);
    if abs(correct) < tol(d)
        continue;
    end
    switch d
        case 1
            commands(1) = prev(1,d) + correct * cf;
            commands(2) = prev(2,d) + correct * cf;
            dz = commands;
        case 2
            commands(1) = prev(1,d) + correct * cf;
            commands(2) = prev(2,d) + correct * cf;
        case 3
            commands(1) = dz(1) - (commandArm/2) * correct * cf;
            commands(2) = dz(2) + (commandArm/2) * correct * cf;
    end
    step.lbcbCps{1}.command.setDispDof(dofs(d),commands(1));
    step.lbcbCps{2}.command.setDispDof(dofs(d),commands(2));
end
end

str = sprintf('%sAdjusted Cmd: %s\n',curStep.lbcbCps{1}.command.toString());
str = sprintf('%sAdjustedCmd: %s\n',str,curStep.lbcbCps{1}.command.toString());
me.log.debug(dbstack,str);

end