function setLimit(hndl,dof,used,limit,isLbcb1)
if isempty(hndl)
    if used(dof)
        me.log.info(dbstack,sprintf('Setting limit of %s dof %s to %f',...
            me.lLabel{1 + (isLbcb1 == 0)},me.dofLabel{dof},limit(dof)));
    end
    return;
end
if used(dof)
    set(hndl,'String',limit(dof));
else
    set(hndl,'String','');
end
end