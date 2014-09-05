function yes = SSW_Dd0NeedsCorrection(me)
me.log.debug(dbstack,'Running needs displacement correction fcn');
tol = zeros(1,3);
ed = zeros(1,3);
target = zeros(1,3);

tol(1) = me.getOrDefault('TolDz',1,1);
tol(2) = me.getOrDefault('TolRx',1,1);
tol(3)= me.getOrDefault('TolRy',1,1);
ed(1) = me.getOrDefault('EdDz',0,3);
ed(2) = me.getOrDefault('EdRx',0,3);
ed(3) = me.getOrDefault('EdRy',0,3);
target(1) = me.getArch('CorrectDz');

for d = 1:3
    correct = target(d) - ed(d);
    if abs(correct) > tol(d)
        yes = true;
        return;
    end
end
yes = false;

end