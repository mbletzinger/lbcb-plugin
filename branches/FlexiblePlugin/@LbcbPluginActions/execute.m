
function execute(obj, event,me)
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
    case 'OPEN CONNECTION'
        done = me.ocOm.isDone();
%         oc = me.ocOm
%         state = me.ocOm.getState()
        if done
            if me.ocOm.state.isState('ERRORS EXIST') == 0
                me.log.debug(dbstack,'Open connection is done');
                me.colorConnectionButton(me.ocOm.connectionType.getState());
            end
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.ocOm.connectionType.getState());
            stop(me.simTimer);
        end
    case 'CLOSE CONNECTION'
%        ocOm = me.ocOm
        done = me.ocOm.isDone();
        if done
%            currentAction = me.currentAction
            me.currentAction.setState('READY');
            me.colorConnectionButton(me.ocOm.connectionType.getState());
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