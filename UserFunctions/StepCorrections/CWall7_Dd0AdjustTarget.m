%------------------------------------------------------------------------%
%       C Wall 7 Dd0 Adjust Target Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 5, 2012 by amock
%------------------------------------------------------------------------%
function CWall7_Dd0AdjustTarget(me,step)
me.log.debug(dbstack,'Running adjustment fcn');
%------------------------------------------------------------------------%
%  Determine direction of movement
%------------------------------------------------------------------------%
dispx = me.getArch('DirectionX');
dispy = me.getArch('DirectionY');

%------------------------------------------------------------------------%
%  Set force DOFs
%------------------------------------------------------------------------%
if dispy == 1 %y movement
    mx = me.getArch('ProposedMx');
    step.lbcbCps{1}.command.setForceDof(4,mx);
end
if dispx == 1 %x movement
    my = me.getArch('ProposedMy');
    step.lbcbCps{1}.command.setForceDof(5,my);
end
    
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

me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));

end