function colorFaultText(hndl,fault,isLbcb1,f)
if isempty(hndl)
    if fault
        me.log.info(dbstack,sprintf('%s dof %s is at fault',...
            me.lLabel{1 + (isLbcb1 == 0)},me.dofLabel{f}));
    end
    return;
end

if fault
    set(hndl,'BackgroundColor',[1.0 0.6 0.784]);
    set(hndl,'FontWeight','bold');
else
    set(hndl,'BackgroundColor','w');
    set(hndl,'FontWeight','normal');
end
end
