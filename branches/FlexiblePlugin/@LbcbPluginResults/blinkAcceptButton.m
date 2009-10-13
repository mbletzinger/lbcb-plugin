function blinkAcceptButton(me,on)
hndl = me.handles.Accept;
 if on
     set(hndl,'BackgroundColor','m');
 else
     set(hndl,'BackgroundColor','w');
 end
end