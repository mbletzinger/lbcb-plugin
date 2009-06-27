function updateCommandLimits(me)
faults1 = me.cl.faults1;
faults2 = me.cl.faults2;
commands1 = me.cl.commands1;
commands2 = me.cl.commands2;

for f = 1:12
    set(me.commandCurrentValueHandles1(f),'String',sprintf('%f',commands1(f)));
    set(me.commandCurrentValueHandles2(f),'String',sprintf('%f',commands2(f)));
    for l = 1:2
        LbcbPluginActions.colorText(me.commandLimitsHandles1(f,l),faults1(f,l));
        LbcbPluginActions.colorText(me.commandLimitsHandles2(f,l),faults2(f,l));
    end
end
end