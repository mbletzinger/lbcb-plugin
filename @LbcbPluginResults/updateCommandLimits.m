function updateCommandLimits(me,lc)
faults1 = lc.cl.faults1;
faults2 = lc.cl.faults2;
commands1 = lc.cl.commands1;
commands2 = lc.cl.commands2;
ifaults1 = lc.il.faults1;
ifaults2 = lc.il.faults2;
inc1 = lc.il.increments1;
inc2 = lc.il.increments2;

for f = 1:12
    if isempty(me.commandCurrentValueHandles1{f})
        me.log.info(dbstack,sprintf('LBCB 1 %s command %f & increment %f',...
            me.dofLabel{f},commands1(f),inc1(f)));
        me.log.info(dbstack,sprintf('LBCB 2 %s command %f & increment %f',...
            me.dofLabel{f},commands2(f),inc2(f)));
        continue;
    end
    set(me.commandCurrentValueHandles1{f},'String',sprintf('%f',commands1(f)));
    set(me.commandCurrentValueHandles2{f},'String',sprintf('%f',commands2(f)));
    set(me.incrementCurrentValueHandles1{f},'String',sprintf('%f',inc1(f)));
    set(me.incrementCurrentValueHandles2{f},'String',sprintf('%f',inc2(f)));
    for l = 1:2
        LbcbPluginActions.colorFaultText(me.commandLimitsHandles1{f,l},faults1(f,l));
        LbcbPluginActions.colorFaultText(me.commandLimitsHandles2{f,l},faults2(f,l));
    end
    LbcbPluginActions.colorFaultText(me.incrementLimitsHandles1{f},ifaults1(f));
    LbcbPluginActions.colorFaultText(me.incrementLimitsHandles2{f},ifaults2(f));
end
end