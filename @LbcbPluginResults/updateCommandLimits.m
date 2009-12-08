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
    h1 = cell(2,1);
    h2 = cell(2,1);
    i1 = [];
    i2 = [];
    if isempty(me.commandCurrentValueHandles1)
%         me.log.info(dbstack,sprintf('LBCB 1 %s command %f & increment %f',...
%             me.dofLabel{f},commands1(f),inc1(f)));
%         me.log.info(dbstack,sprintf('LBCB 2 %s command %f & increment %f',...
%             me.dofLabel{f},commands2(f),inc2(f)));
    else
        h1 = me.commandLimitsHandles1{f,:};
        h2 = me.commandLimitsHandles2{f,:};
        i1 = me.incrementLimitsHandles1{f};
        i2 = me.incrementLimitsHandles2{f};
        set(me.commandCurrentValueHandles1{f},'String',sprintf('%f',commands1(f)));
        set(me.commandCurrentValueHandles2{f},'String',sprintf('%f',commands2(f)));
        set(me.incrementCurrentValueHandles1{f},'String',sprintf('%f',inc1(f)));
        set(me.incrementCurrentValueHandles2{f},'String',sprintf('%f',inc2(f)));
    end
    for l = 1:2
        me.colorFaultText(h1{l},faults1(f,l));
        me.colorFaultText(h2{l},faults2(f,l));
    end
    me.colorFaultText(i1,ifaults1(f));
    me.colorFaultText(i2,ifaults2(f));
end
end