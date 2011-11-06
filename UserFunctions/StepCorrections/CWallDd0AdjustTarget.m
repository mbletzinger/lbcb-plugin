function CWallDd0AdjustTarget(me,step)
my = me.getArch('ProposedMy');
step.lbcbCps{1}.command.setForceDof(5,my);
me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));
sfz = true;
if me.existsCfg('setAxialForce')
    spfz = me.getCfg('setAxialForce');
    sfz = spfz == 1;
end
if sfz
    fz = me.getCfg('AxialForce');
    step.lbcbCps{1}.command.setForceDof(3,fz);
else
    me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
end

end