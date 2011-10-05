function singleBoxPrelimAdjust(me,curStep, nextStep)

Fx = curStep.lbcbCps{1}.response.force(1);

kFactor = me.getCfg('kFactor');

Fz = curStep.lbcbCps{1}.response.force(3);

FzTarget = kFactor/198.6*40 + Fx;

forceCommand = [0;0;FzTarget;0;0;0];

nextStep.lbcbCps{1}.command.force = forceCommand;

% me.putArch(FzTarget,'FzTarget');

end