%------------------------------------------------------------------------%
%       C Wall 8 Dd0 Needs Correction Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 11, 2012 by amock
%------------------------------------------------------------------------%
function yes = CWall8_Dd0NeedsCorrection(me)
me.log.debug(dbstack,'Running needs correction fcn');
%------------------------------------------------------------------------%
%  Determine direction of movement
%------------------------------------------------------------------------%
if me.existsArch('DirectionX')
    dispx = me.getArch('DirectionX');
    dispy = me.getArch('DirectionY');
else
    dispx = 1;
    dispy = 1;
end

%------------------------------------------------------------------------%
%  Determine if correction for mx and my needed based on direction of
%  movement.  NOTE: Fz is not included because the axial force target is
%  already commanded in the *DdPrelimAdjust.m
%------------------------------------------------------------------------%
if dispy == 1
    ermx = me.getCfg('MxError');
    pmx = me.getArch('ProposedMx');
    mmx = me.getArch('MeasuredMx');
    yesx = abs(mmx - pmx) > ermx;
else
    yesx = 0;
end

if dispx == 1
ermy = me.getCfg('MyError');
pmy = me.getArch('ProposedMy');
mmy = me.getArch('MeasuredMy');
yesy = abs(mmy - pmy) > ermy;
else
    yesy = 0;
end

%------------------------------------------------------------------------%
%  Sum yes values to determine if correction step needed
%------------------------------------------------------------------------%
yes = (yesy + yesx) > 0;

end