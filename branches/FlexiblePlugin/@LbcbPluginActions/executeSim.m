
function executeSim(obj, event,me) %#ok<INUSL>
if rem(me.simTimerCnt,100) == 0
    me.log.debug(dbstack,'Simulation Timer Executing')
end
me.simTimerCnt = me.simTimerCnt + 1;
done = me.hfact.tgtEx.isDone();
if done
    me.currentSimExecute.setState('DONE');
    me.hfact.gui.colorRunButton('OFF');
    if me.hfact.tgtEx.targetSource.isState('UI SIMCOR')
        me.processConnectSimCor(false);
    end
    stop(me.simTimer);
end
if me.hfact.tgtEx.hasErrors()
    me.hfact.gui.colorRunButton('BROKEN');
    stop(me.simTimer)
end

me.hfact.gui.updateGui();
% me.log.debug(dbstack,'execute is done');
end

