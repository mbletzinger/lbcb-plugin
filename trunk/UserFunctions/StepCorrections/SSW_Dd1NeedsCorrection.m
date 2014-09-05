function yes = SSW_Dd1NeedsCorrection(me)
me.log.debug(dbstack,'Running needs force correction fcn');
measured = zeros(2,4);
measured(1,1) = me.getArch('MeasL1Fx');
measured(2,1) = me.getArch('MeasL2Fx');
measured(1,2) = me.getArch('MeasL1Fy');
measured(2,2) = me.getArch('MeasL2Fy');
measured(1,3) = me.getArch('MeasL1Mx');
measured(2,3) = me.getArch('MeasL2Mx');
measured(1,4) = me.getArch('MeasL1My');
measured(2,4) = me.getArch('MeasL2My');
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
    if abs(measured(lbcb,d)) > tol(lbcb,d)
        yes = true;
        return;
    end
end
yes = false;

end