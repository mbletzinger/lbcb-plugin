function setIncrementLimit(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to [%s]',dof,lbcb,str));
if strcmp(str,'') || isempty(str)
    if lbcb == 1
        me.hfact.il.limits.used1(dof) = 0;
    else
        me.hfact.il.limits.used2(dof) = 0;
    end
    return;
end
n = sscanf(str,'%f');
if isempty(n)
    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
    if lbcb == 1
        me.hfact.gui.setLimit(me.hfact.gui.incrementLimitsHandles1{dof},dof,me.hfact.il.limits.used1,me.hfact.il.limits.window1);
    else
        me.hfact.gui.setLimit(me.hfact.gui.incrementLimitsHandles2{dof},dof,me.hfact.il.limits.used2,me.hfact.il.limits.window2);
    end
    return;
end
if lbcb == 1
    me.hfact.il.limits.used1(dof) = 1;
    me.hfact.il.limits.window1(dof) = n;
else
    me.hfact.il.limits.used2(dof) = 1;
    me.hfact.il.limits.window2(dof) = n;
end
if me.currentExecute.isState('RUN SIMULATION')
    me.hfact.prcsTgt.edited();
end
end

