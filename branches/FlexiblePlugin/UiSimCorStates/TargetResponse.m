classdef TargetResponse < UiSimCorState
    properties
        action = StateEnum({ ...
            'DONE'...
            'WAIT_FOR_TARGET',...
            'SEND_RESPONSE', ...
            });
        id = {}
        target
        log = Logger('TargetResponse');
    end
    methods
        function start(me)
            me.mdlUiSimCor.start();
            me.statusBusy();
            me.action.setState('WAIT_FOR_TARGET');
        end
        function respond(me)
            jmsg = me.dat.curTarget.generateSimCorResponseMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlUiSimCor.respond(jmsg);
            me.statusBusy();
            me.action.setState('SEND_RESPONSE');
        end
        function done = isDone(me)
            done = 0;
            if me.mdlUiSimCor.isDone() == 0
                return;
            end
            if me.mdlUiSimCor.state.isState('ERRORS EXIST')
                me.statusErrored();
                me.log.error(dbstack,'UI-SimCor Link has errored out');
                done = 1;
                return;
            end
            a = me.action.getState();
            me.log.debug(dbstack,sprintf('action is %s',a));
            switch a
                case 'DONE'
                    done = 1;
                    me.statusReady();
                case 'WAIT_FOR_TARGET'
                    me.target = me.sdf.uisimcorMsg2Step(me.mdlUiSimCor.command);
                    me.action.setState('DONE');
                case 'SEND_RESPONSE'
                    me.action.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end