classdef linkStateMachine < handle
    properties
        link = {};
        connected = 0;
        state = stateEnum({...
            'READY',...
            'PENDING',...
            'DONE',...
            'ERROR'...
            });
        action = stateEnum({...
            'CONNECT',...
            'DISCONNECT',...
            'SEND',...
            'RECEIVE'...
            });
    end
    methods
        function me = linkStateMachine(link)
            me.link = link;
            me.state.setState('READY');
        end
        function done = execute(me,action,msg)
            me.action.setState(action);
            done = 1;
            switch action
                case 'CONNECT'
                    done = me.link.open();
                case 'DISCONNECT'
                    me.link.close();
                case 'SEND'
                    me.link.send(msg);
                case'RECEIVE'
                    me.link.read();
            end
            me.state.setState('PENDING');
        end
        function isDone = check(me)
            isDone = me.link.isDone();
            if isDone
                status = me.link.getResponse();
                if status.isStatus('NONE')
                    me.state.setState('DONE');
                else
                    me.state.setState('ERROR');
                end
            end
        end
        function reset(me)
            me.state.setState('READY');
        end
    end
end