
function executeSim(obj, event,me) %#ok<INUSL>
if rem(me.simTimerCnt,100) == 0
    me.log.debug(dbstack,'Simulation Timer Executing')
end
me.simTimerCnt = me.simTimerCnt + 1;
done = me.hfact.tgtEx.isDone();
if done
    me.currentExecute.setState('READY');
    me.hfact.gui.colorRunButton('OFF');
    stop(me.simTimer);
end
if me.hfact.tgtEx.hasErrors()
    me.hfact.gui.colorRunButton('BROKEN');
    stop(me.simTimer)
end

me.hfact.gui.updateGui();
% me.log.debug(dbstack,'execute is done');
end

