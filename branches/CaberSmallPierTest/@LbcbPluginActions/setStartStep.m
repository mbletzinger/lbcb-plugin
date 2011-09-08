function setStartStep(me,str)
if strcmp(str,'') || isempty(str)
    me.log.error(dbstack,sprintf('"%s" is not a valid step',str));
    LbcbPluginActions.setLimit(me.handles.startStep,dof,me.startStep);
    return;
end
n = sscanf(str,'%d');
if isempty(n)
    me.log.error(dbstack,sprintf('"%s" is not a valid step',str));
    LbcbPluginActions.setLimit(me.handles.startStep,dof,me.startStep);
    return;
end
me.startStep = n;
end