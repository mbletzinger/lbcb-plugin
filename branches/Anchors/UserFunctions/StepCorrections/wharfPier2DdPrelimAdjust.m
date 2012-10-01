function wharfPier2DdPrelimAdjust(me,step)
fz = me.getCfg('AxialForce');
step.lbcbCps{1}.command.setForceDof(3,fz);
step.lbcbCps{1}.command.setForceDof(5,0.0);
me.log.debug(dbstack,sprintf('Adjusted WP step: %s',step.toString()));
end