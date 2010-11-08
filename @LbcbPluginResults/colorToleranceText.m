function colorToleranceText(me,hndl,within,isLbcb1,f)
if isempty(hndl) || me.shuttingDown
    if within == 0
        me.log.info(dbstack,sprintf('%s dof %s is out of tolerance',...
            me.lLabel{1 + (isLbcb1 == 0)},me.dofLabel{f}));
    end
    return;
end
if within
    set(hndl,'BackgroundColor','w');
    set(hndl,'FontWeight','normal');
else
    set(hndl,'BackgroundColor','y');
    set(hndl,'FontWeight','bold');
end
end
