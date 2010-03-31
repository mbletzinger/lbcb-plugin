classdef BroadcastResponses < BroadcasterState
    properties
        action = StateEnum({ ...
            'DONE'...
            'COLLECTING_RESPONSES',...
            'BROADCASTING', ...
            'CLOSE_SESSION_RECEIVED',...
            });
        id = {}
        target
        log = Logger('BroadcastResponses');
        abort
    end
    methods
        function me = BroadcastResponses()
            me.abort = false;
        end
        function start(me)
            me.mdlBroadcast.start(me.dat.curStepData.stepNum);
            me.statusBusy();
            me.action.setState('BROADCASTING');
        end
        function done = isDone(me)
            done = 0;
            if me.mdlBroadcast.isDone() == 0
                return;
            end
            if me.mdlBroadcast.state.isState('ERRORS EXIST')
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
                case 'COLLECTING_RESPONSES'
                    command = me.mdlBroadcast.command;
                    if strcmp(command.getCommand(),'close-session')
                        me.action.setState('CLOSE_SESSION_RECEIVED');
                        address = me.cdp.getAddress();
                        jmsg = me.mdlBroadcast.createResponse(address,[],'GoodBye');
                        me.mdlBroadcast.respond(jmsg);
                        me.abort = true;
                        return;
                    end
                    me.target = me.sdf.uisimcorMsg2Step(command);
                    me.target.needsCorrection = true;
                    me.action.setState('DONE');
                case {'BROADCASTING', 'CLOSE_SESSION_RECEIVED' }
                    me.action.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end