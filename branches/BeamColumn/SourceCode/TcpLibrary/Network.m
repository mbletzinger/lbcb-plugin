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
        msgFactory = {};
        cmdSender = {};
        cmdListener = {};
        senderState = stateEnum({...
            'CLOSED',...
            'CONNECTING',...
            'CONNECTED',...
            'OPEN SENT',...
            'SESSION  OPENED'...
            });
        listenerState = stateEnum({...
            'CLOSED',...
            'CONNECTED',...
            'WAITING FOR SESSION',...
            'SESSION  OPENED'...
            });
    end
    methods
        function me = Network()
            config = ConfigNetworkSettings();
            me.msgFactory = MsgFactory(me.simState,config.controlPointNodes{1});
            
        end
        function setup(me)
            me.cmdListener= CommandListener(me.simcorPort, me.timeout);
            me.cmdSender = CommandSender(me.lbcbHost,me.lbcbPort,me.timeout);
            me.simcorLink = SimCorLink(me.msgFactory,LinkStateMachine(me.cmdListener));
            me.lbcbLink = SimCorLink(me.msgFactory,LinkStateMachine(me.cmdSender));
        end
        function [errorsExist errorMsg] = checkForErrors(me)
            errorMsg = {};
            errorsExist = 0;
            i = 1;
            if(me.cmdSender.status.isStatus('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                i = i + 1;
                errorsExist = 1;
                me.senderState.setState('CLOSED');
            end
            if(me.cmdListener.status.isStatus('NONE') == 0)
                errorMsg{i} = me.cmdSender.errorMsg;
                errorsExist = 1;
            end
        end
        function done = isConnected(me)
            senderDone = 0;
            switch me.senderStates.getState()
                case 'CLOSED'
                    me.cmdSender.open();
                    me.senderStates.setState('CONNECTING');
                case  'CONNECTING'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.senderStates.setState('CONNECTED');
                        end
                    end
                case  'CONNECTED'
                    msg = me.msgFactory.createCommand('open-session','dummySession',[],0);
                    me.cmdSender.send(msg);
                    me.senderStates.setState('OPEN SENT');
                case  'OPEN SENT'
                    if(me.cmdSender.isDone())
                        status = me.cmdSender.getResponse();
                        if status.isState('NONE')
                            me.senderStates.setState('SESSION  OPENED');
                        end
                    end
                case  'SESSION  OPENED'
                    senderDone = 1;
            end
            
            listenerDone = 0;
            switch me.listenerStates.getState()
                case  'CLOSED'
                    if me.cmdListener.open()
                        me.listenerStates.setState('CONNECTED');
                    end
                case 'CONNECTED'
                    me.cmdListener.read();
                    me.listenerStates.setState('WAITING FOR SESSION');
                case 'WAITING FOR SESSION'
                    if(me.cmdListener.isDone())
                        status = me.cmdListener.getResponse();
                        if status.isState('NONE') && strcmp(me.cmdListener.command,'open-session')
                            me.listenerStates.setState('SESSION  OPENED');
                        end
                    end
                case 'SESSION  OPENED'
                    listenerDone = 1;
            end
            done = listenerDone && senderDone;
        end
    end
end