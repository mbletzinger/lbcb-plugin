
function executeSim(obj, event,me) %#ok<INUSL>
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

