function genFakeParameters(me,idx,needsConverge)
fcfg = FakeOmDao(me.cfg);
derived = StateEnum(fcfg.derivedOptions);
derived.idx = idx;
m = me.getMultiplier(idx);
% external sensors
for d = 1:6
    s = me.getMultiplier(d);
    fcfg.eDerived{d} = derived.getState();
    fcfg.eScale(d) = s / m;
end
if needsConverge
    fcfg.convergeSteps = 5;
    fcfg.convergeInc = me.maxW * (m + .5);
    for d = 1:12
        s = me.getMultiplier(d);
        fcfg.derived1{d} = derived.getState();
        fcfg.derived2{d} = derived.getState();
        fcfg.scale1(d) = s / m;
        fcfg.scale2(d) = s / m;
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
ocfg = OmConfigDao(me.cfg);
ocfg.useFakeOm = 1;
end
