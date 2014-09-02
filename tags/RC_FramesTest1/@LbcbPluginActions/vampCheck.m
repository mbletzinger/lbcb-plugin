
function vampCheck(obj, event,me) %#ok<INUSL>
if rem(me.vampTimerCnt,500) == 0
    me.log.debug(dbstack,'Vamp Check Executing')
end
me.vampTimerCnt = me.vampTimerCnt + 1;
if me.hfact.vmpChk.isDone()
        stop(me.vampTimer);
end
if me.shuttingDown == false
    me.hfact.gui.updateGui();
end

end

