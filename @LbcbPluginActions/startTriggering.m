
function startTriggering(obj, event,me) %#ok<INUSL>
a = me.startTriggeringAction.getState();
if rem(me.ctriggerTimerCnt,10) == 0
    me.log.debug(dbstack,'Trigger Timer Executing')
end
me.ctriggerTimerCnt = me.ctriggerTimerCnt + 1;

switch a
    case 'START TRIGGERING'
        done = me.hfact.ssBrdcst.isDone();
        if done
            if me.hfact.ssBrdcst.isReady()
                me.log.info(dbstack,'Triggering server has started');
            end
            me.startTriggeringAction.setState('DONE');
        end
    case 'STOP TRIGGERING'
        done = me.hfact.ssBrdcst.isDone();
        if done
            if me.hfact.ssBrdcst.isReady()
                me.log.info(dbstack,'Triggering server has stopped');
            end
            me.startTriggeringAction.setState('DONE');
        end
    case 'DONE'
        stop(me.ctriggerTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
if me.shuttingDown == false
    me.hfact.gui.updateGui();
end

end

