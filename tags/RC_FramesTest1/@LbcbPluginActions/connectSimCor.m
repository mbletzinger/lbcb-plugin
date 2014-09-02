
function connectSimCor(obj, event,me) %#ok<INUSL>
a = me.connectSimCorAction.getState();
if rem(me.csimcorTimerCnt,100) == 0
    me.log.debug(dbstack,'Connect SimCor Timer Executing')
end
me.csimcorTimerCnt = me.csimcorTimerCnt + 1;

switch a
    case 'OPEN SIMCOR CONNECTION'
        done = me.hfact.ocSimCor.isDone();
        if done
            if me.hfact.ocSimCor.isReady()
                me.log.info(dbstack,'UI-SimCor is connected');
                me.hfact.tgtEx.targetSource.setState('UI SIMCOR');
                me.hfact.gui.updateSource(2);
            end
            me.alreadyStarted = false;
            me.connectSimCorAction.setState('DONE');
        end
    case 'CLOSE SIMCOR CONNECTION'
        done = me.hfact.ocSimCor.isDone();
        if done
            if me.hfact.ocSimCor.isReady()
                me.log.info(dbstack,'UI-SimCor is no longer connected');
                me.hfact.tgtEx.targetSource.setState('NONE');
                me.hfact.gui.updateSource(3);
            end
            me.connectSimCorAction.setState('DONE');
        end
    case 'DONE'
        stop(me.csimcorTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
if me.shuttingDown == false
    me.hfact.gui.updateGui();
end

end

