%------------------------------------------------------------------------%
%       C Wall 8 Dd0 Needs Correction Function
%       Andrew Mock
%       Created May 2012
%       Last edit - Feb 24, 2013 by amock
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
%  movement.  
%
%  Check if Fz needs correction for all steps
%------------------------------------------------------------------------%
if dispy == 1
    ermx = me.getCfg('MxError');
    pmx = me.getArch('ProposedMx');
    mmx = me.getArch('MeasuredMx');
    yesx = abs(mmx - pmx) > ermx;
    
    erfz = me.getCfg('FzError');
    pfz = me.getArch('ProposedFz');
    mfz = me.getArch('MeasuredFz');
    yesFz = abs(mfz - pfz) > erfz;
else
    yesx = 0;
    
    yesFz = 0;
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
yes = (yesy + yesx + yesFz) > 0;

end