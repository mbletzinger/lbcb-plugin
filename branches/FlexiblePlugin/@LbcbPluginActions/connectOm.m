
function connectOm(obj, event,me) %#ok<INUSL>
a = me.connectOmAction.getState();
if rem(me.comTimerCnt,100) == 0
    me.log.debug(dbstack,'Connect OM Timer Executing')
end
me.comTimerCnt = me.comTimerCnt + 1;

me.log.debug(dbstack,sprintf('Executing Action %s',a));
switch a
    case 'OPEN OM CONNECTION'
        done = me.hfact.ocOm.isDone();
        if done
            if me.hfact.ocOm.isReady()
                me.log.info(dbstack,'Operation Manager is connected');
            end
            me.connectOmAction.setState('DONE');
        end
    case 'CLOSE OM CONNECTION'
        done = me.hfact.ocOm.isDone();
        if done
            if me.hfact.ocOm.isReady()
                me.log.info(dbstack,'Operation Manager is no longer connected');
            end
            me.connectOmAction.setState('DONE');
        end
    case 'DONE'
        stop(me.comTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
me.hfact.gui.updateGui();
end

