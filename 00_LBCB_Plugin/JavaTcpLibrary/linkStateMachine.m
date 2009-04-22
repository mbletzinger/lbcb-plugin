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
        function execute(me,action,msg)
            me.action.setState(action);
            switch action
                case 'CONNECT'
                    me.link.open();
                case 'DISCONNECT'
                    me.link.close();
                case 'SEND'
                    me.link.send(msg);
                case'RECEIVE'
                    me.link.read(msg);
            end
            me.state.setState('PENDING');
        end
        function state = check(me)
            isDone = me.link.isDone();
            if isDone
                status = me.link.getResponse();
                if status.isStatus('NONE')
                    me.state.setState('DONE');
                else
                    me.state.setState('ERROR');
                end
            end
            state = me.state;
        end
        function reset(me)
            me.state.setState('READY');
        end
    end
end