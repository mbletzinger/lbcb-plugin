function CWallDd0AdjustTarget(me,step)
my = me.getArch('ProposedMy');
step.lbcbCps{1}.command.setForceDof(5,my);
me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));
end