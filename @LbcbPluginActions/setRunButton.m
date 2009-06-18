function  setRunButton(me,value)
    me.running = value;
    hndl = me.handles.RunHold;
    set(hndl,'Value',value);
    if value
        set(hndl,'BackgroundColor','g');
        set(hndl,'FontWeight','bold');
    else
        set(hndl,'BackgroundColor','w');
        set(hndl,'FontWeight','normal');
    end
end