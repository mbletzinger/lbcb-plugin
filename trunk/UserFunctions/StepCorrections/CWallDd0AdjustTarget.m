function CWallDd0AdjustTarget(me,step)
msr = me.getCfg('MomentShearRatio');
is = me.getCfg('InitialShear');
im = me.getCfg('InitialMoment');
my = (step.lbcbCps{1}.response.force(1) - is)* msr - im;
step.lbcbCps{1}.command.setForceDof(5,my);
me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));
end