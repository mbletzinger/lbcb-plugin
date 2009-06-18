function updateCommandLimits(me)
faults1 = me.cl.faults1;
faults2 = me.cl.faults2;

for f = 1:12
    for l = 1:2
        LbcbPluginActions.colorText(me.commandLimitsHandles1(f,l),faults1(f,l));
        LbcbPluginActions.colorText(me.commandLimitsHandles2(f,l),faults2(f,l));
    end
end
end