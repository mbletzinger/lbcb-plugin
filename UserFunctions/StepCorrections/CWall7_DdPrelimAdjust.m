%------------------------------------------------------------------------%
%       C Wall 7 Dd Preliminary Adjustment Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 5, 2012 by amock
%------------------------------------------------------------------------%
function CWall7_DdPrelimAdjust(me,step)
me.log.debug(dbstack,'Running preliminary adjustment fcn');
%------------------------------------------------------------------------%
%  Determine direction of movement
%       NOTE: The direction determination exists in the preliminary adjust
%       function so that the determination occurs only once per step.  
%       Therefore, correction steps will use the direction of the overall 
%       step.  Finally, the determination looks only at the target from
%       the input file, so changes in Dx and Dy due to ED correction will
%       not throw off the values.
%------------------------------------------------------------------------%

%Look up dx and dy targets from previous step, if exists
if me.existsArch('PrevDx')
    prevdx = me.getArch('PrevDx');
    prevdy = me.getArch('PrevDy');
else
    prevdx = 100;  	%If archived dx and dy do not exist, it must be
    prevdy = 100;   %the first step in the disp record.  Dx and Dy will
end                 %never be equal to 100, so this causes the first step
                    %to correct both Mx and My.
                    
%Read dx and dy target for current step
[disp dDofs force fDofs] = step.lbcbCps{1}.cmdData();
newdx = disp(1);        
newdy = disp(2);        

%Compare dx and dy values between current step and previous step to
%determine if the direction is being applied.
if abs(newdx) ~= abs(prevdx)
    dispx = 1;
else
    dispx = 0;
end

if abs(newdy) ~= abs(prevdy)
    dispy = 1;
else
    dispy = 0;
end

%Check config variables to see if always correct Mx or My is turned on
if me.existsCfg('AlwaysCorrectMx')
    forcemx = me.getCfg('AlwaysCorrectMx');
    if forcemx == 1
        dispy = 1;
    end
end

if me.existsCfg('AlwaysCorrectMy')
    forcemy = me.getCfg('AlwaysCorrectMy');
    if forcemy == 1
        dispx = 1;
    end
end

%archive values 
me.putArch('PrevDx',newdx);
me.putArch('PrevDy',newdy);
me.putArch('DirectionX',dispx);
me.putArch('DirectionY',dispy);

%------------------------------------------------------------------------%
%  Preliminary Axial Force
%------------------------------------------------------------------------%
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

%------------------------------------------------------------------------%
%  Moments, Mx and My
%------------------------------------------------------------------------%
if dispy == 1
    smx = true;
    if me.existsCfg('setPrelimMomentX')
        spfz = me.getCfg('setPrelimMomentX');
        smx = spfz == 1;
    end
    if smx
        mx = me.getArch('MeasuredMx');
        step.lbcbCps{1}.command.setForceDof(4,mx);
    else
        me.log.debug(dbstack,'Not setting Mx Moment in initial command');
    end
end

if dispx == 1
    smy = true;
    if me.existsCfg('setPrelimMomentY')
        spfz = me.getCfg('setPrelimMomentY');
        smy = spfz == 1;
    end
    if smy
        my = me.getArch('MeasuredMy');
        step.lbcbCps{1}.command.setForceDof(5,my);
    else
        me.log.debug(dbstack,'Not setting My Moment in initial command');
    end
    me.log.debug(dbstack,sprintf('Prelim Adjusted step: %s',step.toString()));
end

end