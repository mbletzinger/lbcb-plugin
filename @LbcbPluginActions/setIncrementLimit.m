function setIncrementLimit(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to %s',dof,lbcb,str));
if strcmp(str,'')
    if lbcb == 1
        me.il.limits.used1(dof) = 0;
    else
        me.il.limits.used2(dof) = 0;
    end
else
    if lbcb == 1
        me.il.limits.used1(dof) = 1;
        me.il.limits.window1(dof) = sscanf(str,'%f');
    else
        me.il.limits.used2(dof) = 1;
        me.il.limits.window2(dof) = sscanf(str,'%f');
    end
    
end

end