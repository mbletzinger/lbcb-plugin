function CWallDdPrelimAdjust(me,step)
sfz = true;
if me.existsCfg('setPrelimAxialForce')
    spfz = me.getCfg('setPrelimAxialForce');
    sfz = spfz == 1;
end
if sfz
    fz = me.getCfg('AxialForce');
    step.lbcbCps{1}.command.setForceDof(3,fz);
else
    me.log.debug(dbstack,'Not setting Axial Force in initial command');
end
smy = true;
if me.existsCfg('setPrelimMomentY')
    spfz = me.getCfg('setPrelimMomentY');
    smy = spfz == 1;
end
if smy
    my = me.getArch('MeasuredMy');
    step.lbcbCps{1}.command.setForceDof(5,my);
else
    me.log.debug(dbstack,'Not setting Moment in initial command');
end
me.log.debug(dbstack,sprintf('Prelim Adjusted step: %s',step.toString()));
end