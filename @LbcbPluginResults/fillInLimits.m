function fillInLimits(me)
cl = me.hfact.cl;
    cl.getLimits();
    
    for i = 1:12
        if cl.limits.used1(i)
            set(me.commandLimitsHandles1{i,1},'String', sprintf('%f',cl.limits.lower1(i)));
            set(me.commandLimitsHandles1{i,2},'String', sprintf('%f',cl.limits.upper1(i)));
        else
            set(me.commandLimitsHandles1{i,1},'String', '');
            set(me.commandLimitsHandles1{i,2},'String', '');
        end
        if cl.limits.used2(i)
            set(me.commandLimitsHandles2{i,1},'String', sprintf('%f',cl.limits.lower2(i)));
            set(me.commandLimitsHandles2{i,2},'String', sprintf('%f',cl.limits.upper2(i)));
        else
            set(me.commandLimitsHandles2{i,1},'String', '');
            set(me.commandLimitsHandles2{i,2},'String', '');
        end
    end
    st = me.hfact.st;
    st{1}.getWindow();
    st{2}.getWindow();
    
    for i = 1:12
        if st{1}.used(i)
            set(me.commandTolerancesHandles1{i},'String', sprintf('%f',st{1}.window(i)));
        else
            set(me.commandTolerancesHandles1{i},'String', '');
        end
        if st{2}.used(i)
            set(me.commandTolerancesHandles2{i},'String', sprintf('%f',st{2}.window(i)));
        else
            set(me.commandTolerancesHandles2{i},'String', '');
        end
    end
     il = me.hfact.il;
    il.getLimits();

    for i = 1:12
        if il.limits.used1(i)
            set(me.incrementLimitsHandles1{i},'String', sprintf('%f',il.limits.window1(i)));
        else
            set(me.incrementLimitsHandles1{i},'String', '');
        end
        if il.limits.used2(i)
            set(me.incrementLimitsHandles2{i},'String', sprintf('%f',il.limits.window2(i)));
        else
            set(me.incrementLimitsHandles2{i},'String', '');
        end
    end
end