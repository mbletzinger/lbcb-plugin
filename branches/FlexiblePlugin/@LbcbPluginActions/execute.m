
function execute(obj, event,me) %#ok<INUSL>
% if me.running == 0  % in a hold state
%     return;
% end
a = me.currentExecute.getState();

me.log.debug(dbstack,sprintf('Executing action %s',a));

if me.currentExecute.idx ~= me.prevExecute
    me.log.debug(dbstack,sprintf('Executing action %s',a));
    me.prevExecute = me.currentExecute.idx;
end
switch a
    case 'OPEN CLOSE CONNECTION'
        done = me.hfact.cnEx.isDone();
        if done
            me.currentExecute.setState('READY');
            stop(me.simTimer);
        end
    case 'RUN SIMULATION'
        done = me.hfact.tgtEx.isDone();
        if done
            me.currentExecute.setState('READY');
            stop(me.simTimer);
        end
        
    case 'READY'
        me.log.error(dbstack,'Someone forgot to stop the simulation timer');
    otherwise
        me.log.error(dbstack,sprintf('%s not recognized',a));
end
me.hfact.gui.updateGui();
% me.log.debug(dbstack,'execute is done');
end
