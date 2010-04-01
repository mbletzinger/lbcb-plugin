
function startTriggering(obj, event,me) %#ok<INUSL>
a = me.startTriggeringAction.getState();
if rem(me.csimcorTimerCnt,100) == 0
    me.log.debug(dbstack,'Connect SimCor Timer Executing')
end
me.csimcorTimerCnt = me.csimcorTimerCnt + 1;

switch a
    case 'START TRIGGERING'
        done = me.hfact.ssBrdcst.isDone();
        if done
            if me.hfact.ssBrdcst.isReady()
                me.log.info(dbstack,'Triggering server has started');
                me.hfact.tgtEx.targetSource.setState('UI SIMCOR');
            end
            me.startTriggeringAction.setState('DONE');
        end
    case 'STOP TRIGGERING'
        done = me.hfact.ssBrdcst.isDone();
        if done
            if me.hfact.ssBrdcst.isReady()
                me.log.info(dbstack,'Triggering server has stopped');
                me.hfact.tgtEx.targetSource.setState('NONE');
            end
            me.startTriggeringAction.setState('DONE');
        end
    case 'DONE'
        stop(me.ctriggerTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
me.hfact.gui.updateGui();
end

