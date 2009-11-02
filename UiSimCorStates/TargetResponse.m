classdef TargetResponse < UiSimCorState
    properties
        action = StateEnum({ ...
            'DONE'...
            'GET_TARGET', ...
            'SEND_RESPONSE', ...
            });
        id = {}
    end
    methods
        function start(me)
			me.mdlUiSimCor.start();	
        end
		function respond(me)
            jmsg = me.dat.curTarget.generateSimCorProposeMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlUiSimCor.respond(jmsg);
            me.state.setState('BUSY');
            me.action.setState('SEND_RESPONSE');
		end
		function done = isDone(me)
            done = 0;
            if me.mdlUiSimCor.isDone() == 0
                return;
            end
            me.state.setState(me.mdlUiSimCor.state.getState);
            if me.state.isState('ERRORS EXIST')
                done = 1;
                return;
            end
            a = me.action.getState();
            switch a
                case 'DONE'
                    done = 1;
                    me.state.setState('READY');
                case 'GET_TARGET'
                    me.dat.newTarget()
                    me.dat.curTarget.parseOmControlPointMsg(me.mdlUiSimCor.response)
                    me.action.setState('DONE');
                case 'SEND_RESPONSE'
                    me.action.setState('DONE');                    
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
    methods (Access=private)
        function startPropose(me)
        end
        function startExecute(me)
        end
    end
end