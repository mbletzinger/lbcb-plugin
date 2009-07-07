function updateCommandLimits(me)
faults1 = me.cl.faults1;
faults2 = me.cl.faults2;
commands1 = me.cl.commands1;
commands2 = me.cl.commands2;
ifaults1 = me.il.faults1;
ifaults2 = me.il.faults2;
inc1 = me.il.increments1;
inc2 = me.il.increments2;

for f = 1:12
    set(me.commandCurrentValueHandles1{f},'String',sprintf('%f',commands1(f)));
    set(me.commandCurrentValueHandles2{f},'String',sprintf('%f',commands2(f)));
    set(me.incrementCurrentValueHandles1{f},'String',sprintf('%f',inc1(f)));
    set(me.incrementCurrentValueHandles2{f},'String',sprintf('%f',inc2(f)));
    for l = 1:2
        LbcbPluginActions.colorText(me.commandLimitsHandles1{f,l},faults1(f,l));
        LbcbPluginActions.colorText(me.commandLimitsHandles2{f,l},faults2(f,l));
    end
    LbcbPluginActions.colorText(me.incrementLimitsHandles1{f},ifaults1(f));
    LbcbPluginActions.colorText(me.incrementLimitsHandles2{f},ifaults2(f));
end
end