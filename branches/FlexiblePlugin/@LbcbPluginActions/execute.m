
function execute(obj, event,me) %#ok<INUSL>
% if me.running == 0  % in a hold state
%     return;
% end
a = me.currentAction.getState();

% me.log.debug(dbstack,sprintf('Executing action %s',a));

if me.previousAction.isState(a) == 0
    me.log.debug(dbstack,sprintf('Executing action %s',a));
    me.previousAction.setState(a);
end
switch a
    case 'OPEN CLOSE CONNECTION'
        done = me.hfact.cnEx.isDone();
        if done
            me.currentAction.setState('READY');
            stop(me.simTimer);
        end
    case 'RUN SIMULATION'
        done = me.hfact.tgtEx.isDone();
        if done
            me.currentAction.setState('READY');
            stop(me.simTimer);
        end
        
    case 'READY'
        me.log.error(dbstack,'Someone forgot to stop the simulation timer');
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
LbcbPluginActions.updateGui(me);
% me.log.debug(dbstack,'execute is done');
end

