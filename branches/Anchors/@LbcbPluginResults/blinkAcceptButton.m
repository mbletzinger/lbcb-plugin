function blinkAcceptButton(me,on)
if isempty(me.handles) || me.shuttingDown
    me.log.info(dbstack,sprintf('Blink=%d',on));
    return;
end
hndl = me.handles.Accept;
 if on
     set(hndl,'BackgroundColor','m');
 else
     set(hndl,'BackgroundColor','w');
 end
end