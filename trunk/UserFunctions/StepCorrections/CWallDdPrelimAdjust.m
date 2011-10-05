function CWallDdPrelimAdjust(me,step)
fz = me.getCfg('AxialForce');
step.lbcbCps{1}.command.setForceDof(3,fz);
me.log.debug(dbstack,sprintf('Adjusted step: %s',step.toString()));
end