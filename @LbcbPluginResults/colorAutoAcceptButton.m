function colorAutoAcceptButton(me,on)
hndl = me.handles.AutoAccept;
if on
    set(hndl,'String','Auto');
    set(hndl,'BackgroundColor','g');
    set(hndl,'FontWeight','bold');
    set(hndl,'Value',1); 
else
    set(hndl,'String','Manual');
    set(hndl,'BackgroundColor','w');
    set(hndl,'FontWeight','bold');
    set(hndl,'Value',0); 
end
end