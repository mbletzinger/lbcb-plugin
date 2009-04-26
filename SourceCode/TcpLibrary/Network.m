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
            'DISCONNECTING'...
            });
        simcorState = StateEnum({...
            'CLOSED',...
            'CONNECTED',...
            'WAITING FOR SESSION',...
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
            
        end
        function setup(me)
            me.cmdListener= CommandListener(me.simcorPort, me.timeout);
            me.cmdSender = CommandSender(me.lbcbHost,me.lbcbPort,me.timeout);
            me.simcorLink = LinkStateMachine(me.cmdListener);
            me.lbcbLink = LinkStateMachine(me.cmdSender);
        end
        function [errorsExist errorMsg] = checkForErrors(me)
            errorMsg = {};
            errorsExist = 0;
            i = 1;
            if(me.cmdSender.status.isState('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                i = i + 1;
                errorsExist = 1;
                me.lbcbState.setState('CLOSED');
            end
            if(me.cmdListener.status.isState('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                errorsExist = 1;
            end
        end
        
        function done = closeConnection(me,cn)
            done = 0;
            switch cn
                case 'UI-SIMCOR'
                    me.closeUiSimCor();
                case 'LBCB'
                    me.closeLbcb();
                case 'DAQ DEVICES'
                case 'ALL'
                    me.closeUiSimCor();
                    me.closeLbcb();
            end
        end
        function done = closeLbcb(me)
            done = 0;
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
                case  {'SESSION  OPENED','CONNECTED', 'OPEN SENT'}
                    me.cmdSender.close();
                    me.lbcbState.setState('DISCONNECTING');
            end
        end
        
        function done = closeUiSimCor(me)
            done = 0;
            switch me.simcorStates.getState()
                case  'CLOSED'
                    done = 1;
                case  'DISCONNECTING'
                    if(me.cmdListener.isDone())
                        status = me.cmdListener.getResponse();
                        if status.isState('NONE')
                            me.simcorStates.setState('CLOSED');
                        end
                    end
                case {'SESSION  OPENED','CONNECTED','WAITING FOR SESSION'}
                    me.cmdListener.close()
                    me.simcorStates.setState('DISCONNECTING');
            end
        end

        function done = isConnected(me,cn)
            done = 0;
            switch cn
                case 'UI-SIMCOR'
                    me.connectUiSimCor();
                case 'LBCB'
                    me.connectLbcb();
                case 'DAQ DEVICES'
                case 'ALL'
                    me.connectUiSimCor();
                    me.connectLbcb();
            end
        end
        
        function done = connectLbcb(me)
            done = 0;
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
            end
        end
            
       function done = connectUiSimCor(me)
            done = 0;
            switch me.simcorStates.getState()
                case  'CLOSED'
                    if me.cmdListener.open()
                        me.simcorStates.setState('CONNECTED');
                    end
                case 'CONNECTED'
                    me.cmdListener.read();
                    me.simcorStates.setState('WAITING FOR SESSION');
                case 'WAITING FOR SESSION'
                    if(me.cmdListener.isDone())
                        status = me.cmdListener.getResponse();
                        if status.isState('NONE') && strcmp(me.cmdListener.command,'open-session')
                            me.simcorStates.setState('SESSION  OPENED');
                        end
                    end
                case 'SESSION  OPENED'
                    done = 1;
            end
       end
    end
end