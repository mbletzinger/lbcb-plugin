function  colorButton(me,buttonName,bs)
    switch buttonName
        case 'RUN'
        case 'CONNECT OM'
        case 'CONNECT SIMCOR'
        case 'TRIGGER'
        otherwise
            me.log.error(dbstack,sprintf('%s not recognized',buttonName));
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
        otherwise
            me.log.error(dbstack,sprintf('%s not recognized',bs));
    end
end