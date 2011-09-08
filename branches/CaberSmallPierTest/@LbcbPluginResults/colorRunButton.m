function  colorRunButton(me,bs)
if isempty(me.handles) || me.shuttingDown
    me.log.info(dbstack,sprintf('Run Hold Button is %s',bs));
    return;
end

    hndl = me.handles.RunHold;
    switch bs
        case 'ON'
            set(hndl,'BackgroundColor','g');
            set(hndl,'FontWeight','bold');
            set(hndl,'Value',1);
        case 'OFF'
            set(hndl,'BackgroundColor','w');
            set(hndl,'FontWeight','normal');
            set(hndl,'Value',0);
        case 'BROKEN'
            set(hndl,'BackgroundColor','y');
            set(hndl,'FontWeight','normal');
            set(hndl,'Value',0);
                me.hfact.acceptStp.autoAccept = false;
                me.colorAutoAcceptButton(false);
        otherwise
    end
end