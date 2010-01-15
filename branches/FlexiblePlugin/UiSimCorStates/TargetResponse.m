classdef TargetResponse < UiSimCorState
    properties
        action = StateEnum({ ...
            'DONE'...
            'WAIT_FOR_TARGET',...
            'SEND_RESPONSE', ...
            'CLOSE_SESSION_RECEIVED',...
            });
        id = {}
        target
        log = Logger('TargetResponse');
        abort
    end
    methods
        function me = TargetResponse()
            me.abort = false;
        end
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
                    command = me.mdlUiSimCor.command;
                    if strcmp(command.getCommand(),'close-session')
                        me.action.setState('CLOSE_SESSION_RECEIVED');
                        address = me.cdp.getAddress();
                        jmsg = me.mdlUiSimCor.createResponse(address,[],'GoodBye');
                        me.mdlUiSimCor.respond(jmsg);
                        me.abort = true;
                        return;
                    end
                    me.target = me.sdf.uisimcorMsg2Step(command);
                    me.action.setState('DONE');
                case {'SEND_RESPONSE', 'CLOSE_SESSION_RECEIVED' }
                    me.action.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end