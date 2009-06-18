function setCommandLimit(me,dof,lbcb,isLower,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d/isLower=%d to %s',dof,lbcb,isLower,str));
    if strcmp(str,'')
        if lbcb == 1
            me.cl.limits.used1(dof) = 0;
        else
            me.cl.limits.used2(dof) = 0;
        end
    else
        if lbcb == 1
            me.cl.limits.used1(dof) = 1;
            if isLower
                me.cl.limits.lower1(dof) = sscanf(str,'%f');
            else
                me.cl.limits.upper1(dof) = sscanf(str,'%f');
            end
        else
             me.cl.limits.used2(dof) = 1;
           if isLower
                me.cl.limits.lower2(dof) = sscanf(str,'%f');
            else
                me.cl.limits.upper2(dof) = sscanf(str,'%f');
            end
        end
        
    end
        
end