function CWallDd0AdjustTarget(me,step)
msr = me.getCfg('MomentShearRatio');
my = step.lbcbCps{1}.response.force(1) * msr;
step.lbcbCps{1}.command.setForceDof(5,my);
me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));
end