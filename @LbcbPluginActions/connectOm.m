
function connectOm(obj, event,me) %#ok<INUSL>
a = me.connectOmAction.getState();
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
        done = me.ocOm.isDone();
        if done
            if me.hfact.ocOm.isReady()
                me.log.info(dbstack,'Operation Manager is no longer connected');
            end
            me.connectOmAction.setState('DONE');
        end
    case 'DONE'
        stop(me.simTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
me.hfact.gui.updateGui();
end

