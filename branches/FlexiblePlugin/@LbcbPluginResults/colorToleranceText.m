function colorToleranceText(hndl,within)
if within
    set(hndl,'BackgroundColor','w');
    set(hndl,'FontWeight','normal');
else
    set(hndl,'BackgroundColor','y');
    set(hndl,'FontWeight','bold');
end
end
