function  setRunButton(me,value)
    me.running = value;
    hndl = me.handles.RunHold;
    set(hndl,'Value',value);
    if value
        set(hndl,'BackgroundColor','g');
        set(hndl,'FontWeight','bold');
        me.startSimulation(0);
    else
        set(hndl,'BackgroundColor','w');
        set(hndl,'FontWeight','normal');
        stop(me.simTimer);
    end
end