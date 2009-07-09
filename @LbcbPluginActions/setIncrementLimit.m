function setIncrementLimit(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to [%s]',dof,lbcb,str));
if strcmp(str,'') || isempty(str)
    if lbcb == 1
        me.il.limits.used1(dof) = 0;
    else
        me.il.limits.used2(dof) = 0;
    end
    return;
end
n = sscanf(str,'%f');
if isempty(n)
    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
    if lbcb == 1
        LbcbPluginActions.setLimit(me.incrementLimitsHandles1{dof},dof,me.il.limits.used1,me.il.limits.window1);
    else
        LbcbPluginActions.setLimit(me.incrementLimitsHandles2{dof},dof,me.il.limits.used2,me.il.limits.window2);
    end
    return;
end
if lbcb == 1
    me.il.limits.used1(dof) = 1;
    me.il.limits.window1(dof) = n;
else
    me.il.limits.used2(dof) = 1;
    me.il.limits.window2(dof) = n;
end

end

