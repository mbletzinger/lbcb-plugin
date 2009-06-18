function colorText(hndl,fault)
if fault
    set(hndl,'BackgroundColor',[1.0 0.6 0.784]);
    set(hndl,'FontWeight','bold');
else
    set(hndl,'BackgroundColor','w');
    set(hndl,'FontWeight','normal');
end
end
