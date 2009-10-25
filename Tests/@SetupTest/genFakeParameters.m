function genFakeParameters(me,needsConverge)
fcfg = FakeOmDao(me.cfg);
derived = StateEnum(fcfg.derivedOptions);
derived.idx = 1;
m = me.getMultiplier(10);
% external sensors
for d = 1:6
    s = me.getMultiplier(1);
    fcfg.eDerived{d} = derived.getState();
    fcfg.eScale(d) = s / m;
end
if needsConverge
    fcfg.convergeSteps = 5;
    fcfg.convergeInc = me.maxW * m;
    for d = 1:12
        derived.idx = d;
        fcfg.derived1{d} = derived.getState();
        fcfg.derived2{d} = derived.getState();
        fcfg.scale1(d) = 1;
        fcfg.scale2(d) = 1;
    end
else
    % regular dofs
    for d = 1:12
        s = me.getMultiplier(d);
        fcfg.derived1{d} = derived.getState();
        fcfg.derived2{d} = derived.getState();
        fcfg.scale1(d) = s / m;
        fcfg.scale2(d) = s / m;
    end
end
end
