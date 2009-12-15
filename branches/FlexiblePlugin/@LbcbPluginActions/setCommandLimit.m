function setCommandLimit(me,dof,lbcb,isLower,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d/isLower=%d to [%s]',dof,lbcb,isLower,str));
if strcmp(str,'') || isempty(str)
    if lbcb == 1
        me.hfact.cl.limits.used1(dof) = 0;
    else
        me.hfact.cl.limits.used2(dof) = 0;
    end
    return;
end

n = sscanf(str,'%f');
if isempty(n)
    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
    if lbcb == 1
        if isLower
            LbcbPluginActions.setLimit(me.commandLimitsHandles1{dof,1},dof,me.hfact.cl.limits.used1,me.hfact.cl.limits.lower1);
        else
            LbcbPluginActions.setLimit(me.commandLimitsHandles1{dof,2},dof,me.hfact.cl.limits.used1,me.hfact.cl.limits.upper1);
        end
    else
        if isLower
            LbcbPluginActions.setLimit(me.commandLimitsHandles2{dof,1},dof,me.hfact.cl.limits.used2,me.hfact.cl.limits.lower2);
        else
            LbcbPluginActions.setLimit(me.commandLimitsHandles2{dof,2},dof,me.hfact.cl.limits.used2,me.hfact.cl.limits.upper2);
        end
    end
    return;
end

if lbcb == 1
    me.hfact.cl.limits.used1(dof) = 1;
    if isLower
        me.hfact.cl.limits.lower1(dof) = n;
    else
        me.hfact.cl.limits.upper1(dof) = n;
    end
else
    me.hfact.cl.limits.used2(dof) = 1;
    if isLower
        me.hfact.cl.limits.lower2(dof) = n;
    else
        me.hfact.cl.limits.upper2(dof) = n;
    end
end
me.hfact.prcsTgt.edited();
end