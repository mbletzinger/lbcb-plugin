function CWallDd0AdjustTarget(me,step)
my = me.getArch('ProposedMy');
step.lbcbCps{1}.command.setForceDof(5,my);
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

step.lbcbCps{1}.command.forceDofs([4 6]) = 0;
if me.getArch('DoMx') == 1
    mx = me.getCfg('MxTarget');
    step.lbcbCps{1}.command.setForceDof(4,mx);
else
    me.log.debug(dbstack,'Not setting Mx in DD0 command');
end

if me.getArch('DoMz') == 1
    mz = me.getCfg('MzTarget');
    step.lbcbCps{1}.command.setForceDof(6,mz);
else
    me.log.debug(dbstack,'Not setting Mz in DD0 command');
end

me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));

end