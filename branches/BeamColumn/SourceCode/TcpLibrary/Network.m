classdef Network < handle
    properties
        simcorPort = 0;
        triggerPort = 0;
        lbcbPort = 0;
        lbcbHost='';
        timeout=0;
        simState = {};
        simcorLink = {};
        lbcbLink={};
        triggerLink={};
        factory = {};
        cmdSender = {};
        cmdListener = {};
        lbcbState = StateEnum({...
            'CLOSED',...
            'CONNECTING',...
            'CONNECTED',...
            'OPEN SENT',...
            'SESSION  OPENED',...
            'CLOSE SENT',...
            'SESSION  CLOSED',...
            'DISCONNECTING'...
            });
        simcorState = StateEnum({...
            'CLOSED',...
            'LISTENING FOR UI-SIMCOR CONNECTION',...
            'CONNECTED',...
            'WAITING FOR SESSION',...
            'SESSION OPENING',...
            'SESSION  OPENED',...
            'DISCONNECTING'...
            });
        connection = StateEnum({...
            'UI-SIMCOR',...
            'LBCB',...
            'DAQ DEVICES',...
            'ALL'...
            });
    end
    methods
        function me = Network(simState)
            me.simState = simState;
            config = ConfigNetworkSettings();
            me.factory = MsgFactory(simState,config.controlPointNodes{1});
            me.simcorPort = config.simcorPort;
            me.triggerPort = config.triggerPort;
            me.lbcbPort = config.lbcbPort;
            me.lbcbHost = config.lbcbHost;
            me.timeout = config.timeout;
            
            
        end
        function setup(me)
            me.cmdListener= CommandListener(me.simcorPort, me.timeout);
            me.cmdSender = CommandSender(me.lbcbHost,me.lbcbPort,me.timeout);
            me.simcorLink = LinkStateMachine(me.cmdListener);
            me.lbcbLink = LinkStateMachine(me.cmdSender);
            me.simcorState.setState('LISTENING FOR UI-SIMCOR CONNECTION');
        end
        function [errorsExist errorMsg] = checkForErrors(me)
            errorMsg = {};
            errorsExist = 0;
            i = 1;
            status = me.cmdSender.getResponse();
            if(status.isState('NONE') == 0 && me.lbcbState.isState('CLOSED') == 0)
                errorMsg{i} = sprintf('Command Sender: %s',char(me.cmdSender.errorMsg));
                i = i + 1;
                errorsExist = 1;
                me.lbcbState.setState('CLOSED');
            end
            status = me.cmdListener.getCommand();
            if(status.isState('NONE') == 0&& me.simcorState.isState('CLOSED') == 0)
                errorMsg{i} = sprintf('Command Listener: %s',char(me.cmdListener.errorMsg));
                errorsExist = 1;
            end
        end
        
        function done = closeConnection(me,cn)
            done = 0;
            switch cn
                case 'UI-SIMCOR'
                    done = me.closeUiSimCor();
                case 'LBCB'
                    done = me.closeLbcb();
                case 'DAQ DEVICES'
                case 'ALL'
                    ud = me.closeUiSimCor();
                    ld = me.closeLbcb();
                    done = ud && ld;
            end
        end
        function done = closeLbcb(me)
            done = 0;
            me.lbcbState.getState()
            switch me.lbcbState.getState()
                case 'CLOSED'
                    done = 1;
                case  'DISCONNECTING'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.lbcbState.setState('CLOSED');
                        end
                    end
                case  'SESSION  OPENED'
                    msg = me.factory.createCommand('close-session','dummySession',[],0);
                    me.cmdSender.send(msg.jmsg);
                    me.lbcbState.setState('CLOSE SENT');
                case  'CLOSE SENT'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.lbcbState.setState('SESSION  CLOSED');
                        end
                    end
                case  {'SESSION  CLOSED','CONNECTED', 'OPEN SENT'}
                    me.cmdSender.close();
                    me.lbcbState.setState('DISCONNECTING');
                 otherwise
                    error = sprintf('%s not recognized',me.lbcbState.getState())
           end
        end
        
        function done = closeUiSimCor(me)
            done = 0;
            state = me.simcorState.getState()
            switch me.simcorState.getState()
                case  'CLOSED'
                    done = 1;
                case  'DISCONNECTING'
                    if(me.cmdListener.isDone())
                        status = me.cmdListener.getResponse();
                        if status.isState('NONE')
                            me.simcorState.setState('CLOSED');
                        end
                    end
                case {'SESSION  OPENED','CONNECTED',...
                        'WAITING FOR SESSION','LISTENING FOR UI-SIMCOR CONNECTION'}
                    me.cmdListener.close()
                    me.simcorState.setState('DISCONNECTING');
                otherwise
                    error = sprintf('%s not recognized',me.simcorState.getState())
            end
        end

        function done = isConnected(me,cn)
            done = 0;
            switch cn
                case 'UI-SIMCOR'
                    done = me.connectUiSimCor();
                case 'LBCB'
                    done = me.connectLbcb();
                case 'DAQ DEVICES'
                case 'ALL'
                    ud = me.connectUiSimCor();
                    ld = me.connectLbcb();
                    done = ud && ld;
                otherwise
                    error = sprintf('%s not recognized',cn)
            end
        end
        
        function done = connectLbcb(me)
            done = 0;
%            me.lbcbState.getState()
            switch me.lbcbState.getState()
                case 'CLOSED'
                    me.cmdSender.open();
                    me.lbcbState.setState('CONNECTING');
                case  'CONNECTING'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.lbcbState.setState('CONNECTED');
                        end
                    end
                case  'CONNECTED'
                    msg = me.factory.createCommand('open-session','dummySession',[],0);
                    me.cmdSender.send(msg.jmsg);
                    me.lbcbState.setState('OPEN SENT');
                case  'OPEN SENT'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.lbcbState.setState('SESSION  OPENED');
                        end
                    end
                case  'SESSION  OPENED'
                    done = 1;
                otherwise
                    error = sprintf('%s not recognized',me.lbcbState.getState())
            end
        end
            
       function done = connectUiSimCor(me)
            done = 0;
            state = me.simcorState.getState()
            switch me.simcorState.getState()
                case  {'CLOSED','LISTENING FOR UI-SIMCOR CONNECTION'}
                    if me.cmdListener.open()
                        me.simcorState.setState('CONNECTED');
                    end
                case 'CONNECTED'
                    me.cmdListener.read();
                    me.simcorState.setState('WAITING FOR SESSION');
                case 'WAITING FOR SESSION'
                    if(me.cmdListener.isDone())
                        status = me.cmdListener.getCommand();
                        if status.isState('NONE') && strcmp(char(me.cmdListener.command.getCommand()),'open-session')
                            rsp = me.factory.createResponse('Open accepted',me.cmdListener.command);
                            me.cmdListener.send(rsp.jmsg);
                            me.simcorState.setState('SESSION OPENING');
                        end
                    end
                case 'SESSION OPENING'
                    if me.cmdListener.isDone()
                        done = me.cmdListener.isDone()
                        me.simcorState.setState('SESSION  OPENED');
                    end
                case 'SESSION  OPENED'
                    done = 1;
                otherwise
                    error = sprintf('%s not recognized',me.simcorState.getState())

            end
       end
    end
end