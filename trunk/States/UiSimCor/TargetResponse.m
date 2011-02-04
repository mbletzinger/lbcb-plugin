classdef TargetResponse < UiSimCorState
    properties
        id = {}
        target
        log = Logger('TargetResponse');
        abort
        gotFirstStep
    end
    methods
        function me = TargetResponse()
            me = me@UiSimCorState();
            me.abort = false;
            me.currentAction = StateEnum({ ...
                'DONE'...
                'WAIT_FOR_TARGET',...
                'SEND_RESPONSE', ...
                'CLOSE_SESSION_RECEIVED',...
                });
            me.gotFirstStep = false;
        end
        function start(me)
            me.mdlUiSimCor.start();
            me.statusBusy();
            me.currentAction.setState('WAIT_FOR_TARGET');
        end
        function respond(me)
            jmsg = me.dat.curStepTgt.generateSimCorResponseMsg();
            me.log.debug(dbstack,sprintf('Sending %s',char(jmsg)));
            me.mdlUiSimCor.respond(jmsg);
            me.statusBusy();
            me.currentAction.setState('SEND_RESPONSE');
        end
        function done = isDone(me)
            done = 0;
            me.stateChanged();
            if me.mdlUiSimCor.isDone() == 0
                return;
            end
            if me.mdlUiSimCor.state.isState('ERRORS EXIST')
                me.statusErrored();
                me.log.error(dbstack,'UI-SimCor Link has errored out');
                done = 1;
                return;
            end
            a = me.currentAction.getState();
            me.log.debug(dbstack,sprintf('action is %s',a));
            switch a
                case 'DONE'
                    done = 1;
                    me.statusReady();
                case 'WAIT_FOR_TARGET'
                    command = me.mdlUiSimCor.command;
                    if strcmp(command.getCommand(),'close-session')
                        me.currentAction.setState('CLOSE_SESSION_RECEIVED');
                        address = me.cdp.getAddress();
                        jmsg = me.mdlUiSimCor.createResponse(address,[],'GoodBye');
                        me.mdlUiSimCor.respond(jmsg);
                        me.abort = true;
                        return;
                    end
                    me.target = me.sdf.uisimcorMsg2Step(command);
                    me.target.needsCorrection = true;
                    if(me.gotFirstStep == false) 
                        me.target.isFirstStep = true;
                        me.gotFirstStep = true;
                    end
                    me.currentAction.setState('DONE');
                case {'SEND_RESPONSE', 'CLOSE_SESSION_RECEIVED' }
                    me.currentAction.setState('DONE');
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
end