function setLimit(hndl,dof,used,limit)
if used(dof)
    set(hndl,'String',limit(dof));
else
    set(hndl,'String','');
end
end