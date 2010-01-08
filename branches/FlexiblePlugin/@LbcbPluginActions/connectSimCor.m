
function connectSimCor(obj, event,me) %#ok<INUSL>
a = me.connectSimCorAction.getState();
switch a
    case 'OPEN SIMCOR CONNECTION'
        done = me.hfact.ocSimCor.isDone();
        if done
            if me.hfact.ocSimCor.isReady()
                me.log.info(dbstack,'UI-SimCor is connected');
                me.hfact.tgtEx.targetSource.setState('UI SIMCOR');
            end
            me.connectSimCorAction.setState('DONE');
        end
    case 'CLOSE SIMCOR CONNECTION'
        done = me.hfact.ocSimCor.isDone();
        if done
            if me.hfact.ocSimCor.isReady()
                me.log.info(dbstack,'UI-SimCor is no longer connected');
                me.hfact.tgtEx.targetSource.setState('NONE');
            end
            me.connectSimCorAction.setState('DONE');
        end
    case 'DONE'
        stop(me.csimcorTimer);
    otherwise
        me.log.error(dbstack,sprintf('%s action not recognized',action));
end
me.hfact.gui.updateGui();
end

