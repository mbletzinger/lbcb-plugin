function setStepTolerance(me,dof,lbcb,str)
me.log.debug(dbstack,sprintf('Setting /dof=%d/lbcb=%d to [%s]',dof,lbcb,str));
wlcfg = WindowLimitsDao('command.tolerances',me.hfact.cfg);
if strcmp(str,'') || isempty(str)
    if lbcb == 1
        wlcfg.used1(dof) = 0;
    else
        wlcfg.used2(dof) = 0;
    end
    return;
end
n = sscanf(str,'%f');
if isempty(n)
    me.log.error(dbstack,sprintf('"%s" is not a valid input',str));
    if lbcb == 1
        me.hfact.gui.setLimit(me.hfact.gui.commandTolerancesHandles1{dof},dof,me.hfact.st{1}.used,me.hfact.st{1}.window);
    else
        me.hfact.gui.setLimit(me.hfact.gui.commandTolerancesHandles2{dof},dof,me.hfact.st{2}.used,me.hfact.st{2}.window);
    end
    return;
end
if lbcb == 1
    wlcfg.used1(dof) = 1;
    wlcfg.window1(dof) = n;
else
    wlcfg.used2(dof) = 1;
    wlcfg.window2(dof) = n;
end
    
end

