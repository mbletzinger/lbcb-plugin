%------------------------------------------------------------------------%
%       C Wall 7 Dd0 Adjust Target Function
%       Andrew Mock
%       Created May 2012
%       Last edit - June 5, 2012 by amock
%------------------------------------------------------------------------%
function SSW_Dd1AdjustTarget(me,step)
me.log.debug(dbstack,'Running force adjustment fcn');
measured = zeros(2,4);
target = zeros(2,4);
dofs = [1,2,4,5];
dlabels = {'Fx', 'Fy', 'Mx', 'My'};

measured(1,1) = me.getArch('MeasL1Fx');
measured(2,1) = me.getArch('MeasL2Fx');
measured(1,2) = me.getArch('MeasL1Fy');
measured(2,2) = me.getArch('MeasL2Fy');
measured(1,3) = me.getArch('MeasL1Mx');
measured(2,3) = me.getArch('MeasL2Mx');
measured(1,4) = me.getArch('MeasL1My');
measured(2,4) = me.getArch('MeasL2My');

target(1,1) = me.getOrDefault('TgtL1Fx',0,1);
target(2,1) = me.getOrDefault('TgtL2Fx',0,1);
target(1,2) = me.getOrDefault('TgtL1Fy',0,1);
target(2,2) = me.getOrDefault('TgtL2Fy',0,1);
target(1,3) = me.getOrDefault('TgtL1Mx',0,1);
target(2,3) = me.getOrDefault('TgtL2Mx',0,1);
target(1,4) = me.getOrDefault('TgtL1My',0,1);
target(2,4) = me.getOrDefault('TgtL2My',0,1);
tol = zeros(2,4);
tol(1,1) = me.getOrDefault('TolL1Fx',0,1);
tol(2,1) = me.getOrDefault('TolL2Fx',0,1);
tol(1,2) = me.getOrDefault('TolL1Fy',0,1);
tol(2,2) = me.getOrDefault('TolL2Fy',0,1);
tol(1,3) = me.getOrDefault('TolL1Mx',0,1);
tol(2,3) = me.getOrDefault('TolL2Mx',0,1);
tol(1,4) = me.getOrDefault('TolL1My',0,1);
tol(2,4) = me.getOrDefault('TolL2My',0,1);

for lbcb = 1:2
for d = 1:4
    if tol(lbcb,d) == 0
        continue;
    end
    if abs(measured(lbcb,d)) < tol(lbcb,d)
        continue;
    end
    step.lbcbCps{lbcb}.command.setForceDof(dofs(d),target(lbcb,d));
    me.log.info(dbstack,sprintf('Correcting LBCB %d %s',lbcb, dlabels{d}));
end

str = sprintf('%sAdjusted Cmd: %s\n',step.lbcbCps{1}.command.toString());
str = sprintf('%sAdjustedCmd: %s\n',str,step.lbcbCps{1}.command.toString());
me.log.debug(dbstack,str);

end