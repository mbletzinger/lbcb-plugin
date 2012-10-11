%------------------------------------------------------------------------%
%       C Wall 8 Dd0 Adjust Target Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 12, 2012 by amock
%------------------------------------------------------------------------%
function CWall8_Dd0AdjustTarget(me,step)
me.log.debug(dbstack,'Running adjustment fcn');
%------------------------------------------------------------------------%
%  Determine direction of movement
%------------------------------------------------------------------------%
dispx = me.getArch('DirectionX');
dispy = me.getArch('DirectionY');

%------------------------------------------------------------------------%
%  Set force DOFs
%------------------------------------------------------------------------%
sfz = true;
if me.existsCfg('setAxialForce')
    spfz = me.getCfg('setAxialForce');
    sfz = spfz == 1;
end

if dispy == 1 %y movement
    mx = me.getArch('ProposedMx');
    step.lbcbCps{1}.command.setForceDof(4,mx);
    if sfz
        fz = me.getArch('ProposedFz');
        step.lbcbCps{1}.command.setForceDof(3,fz);
    else
        me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
    end
end

if dispx == 1 %x movement
    my = me.getArch('ProposedMy');
    step.lbcbCps{1}.command.setForceDof(5,my);
    if sfz
        fz = me.getCfg('AxialForce');
        step.lbcbCps{1}.command.setForceDof(3,fz);
    else
        me.log.debug(dbstack,'Not setting Axial Force in DD0 command');
    end
end
    
me.log.debug(dbstack,sprintf('Dd0 Adjusted step: %s',step.toString()));

end