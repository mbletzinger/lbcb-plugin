function setStepTolerance(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to %s',dof,lbcb,str));
if strcmp(str,'')
    if lbcb == 1
        me.st.limits.used1(dof) = 0;
    else
        me.st.limits.used2(dof) = 0;
    end
else
    if lbcb == 1
        me.st.limits.used1(dof) = 1;
        me.st.limits.window1(dof) = sscanf(str,'%f');
    else
        me.st.limits.used2(dof) = 1;
        me.st.limits.window2(dof) = sscanf(str,'%f');
    end
    
end

end