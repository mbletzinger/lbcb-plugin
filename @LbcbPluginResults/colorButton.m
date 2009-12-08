function  colorButton(me,buttonName,bs)
if isempty(me.handles)
    me.log.info(dbstack,sprintf('Button=%s is %s',buttonName,bs));
    return;
end

switch buttonName
    case 'CONNECT OM'
        hndl = me.handles.Connect2Om;
    case 'CONNECT SIMCOR'
        hndl = me.handles.StartSimCor;
    case 'TRIGGER'
        hndl = me.handles.StartTriggering;
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',buttonName));
end
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
        set(hndl,'BackgroundColor','r');
        set(hndl,'FontWeight','normal');
        set(hndl,'Value',0);
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',bs));
end
end