classdef OpenCloseOm < OpenClose
    properties
        omActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'CLOSING_SESSION',...
            'OPENING_SESSION',...
            'DONE',...
            });
    end
    methods
        function me = OpenCloseOm()
            me.connectionType.setState('OperationsManager');
        end
        function start(me, closeIt)
            me.closeIt = closeIt;
            if closeIt && me.connectionStatus.isState('DISCONNECTED')
                me.log.error(dbstack,'OM Connection already disconnected');
                return;
            end
            if closeIt == 0 && me.connectionStatus.isState('CONNECTED')
                me.log.error(dbstack,'OM Connection already connected');
                return;
            end
            if me.closeIt
                ml = SimulationState.getMdlLbcb();
            else
                ml = MdlLbcb(me.cfg);
                SimulationState.setMdlLbcb(ml);
            end
            if me.closeIt
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    address = StepData.getAddress();
                    jmsg = ml.createCommand('close-session',address,[],[]);
                    ml.start(jmsg,[],0);
                    me.omActions.setState('CLOSING_SESSION');
                else
                    ml.close();
                    me.omActions.setState('DISCONNECTING');
                end
            else
                ml.open();
                me.omActions.setState('CONNECTING');
            end
        end
        function done = isDone(me)
            done = 0;
            ml = SimulationState.getMdlLbcb();
            if isempty(ml)
                if me.omActions.isState('DONE')
                    done = 1;
                else
                    me.log.error(dbstack,fprintf('Empty mdlbcb at action %s state %s',a,me.state.getState()));
                end
                return;
            end
            mlDone = ml.isDone();
            if mlDone == 0
                return;
            end
            me.state.setState(ml.state.getState());
            me.log.debug(dbstack,sprintf('OpenClose state is %s',me.state.getState()));

            if me.state.isState('ERRORS EXIST')
                done = 1;
                me.omActions.setState('DONE');            
                me.connectionStatus.setState('ERRORED');
                return;
            end
            a = me.omActions.getState();
            me.log.debug(dbstack,sprintf('OpenCloseOm action is %s',a));
            switch a
                case 'CONNECTING'
                    me.connect();
                case 'DISCONNECTING'
                    me.disconnect();
                case 'CLOSING_SESSION'
                    me.closingSession();
                case 'OPENING_SESSION'
                    me.openingSession();
                case 'DONE'
                    done = 1;
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',a));
            end
        end
    end
    methods (Access=private)
        function openingSession(me)
            me.connectionStatus.setState('CONNECTED');
            me.omActions.setState('DONE');            
        end
        function closingSession(me)
            ml = SimulationState.getMdlLbcb();
            ml.close();
            me.omActions.setState('DISCONNECTING');            
        end
        function connect(me)
            ml = SimulationState.getMdlLbcb();
            address = StepData.getAddress();
            if isempty(address)
                me.log.error(dbstack,'SimCor Address is not set in the OM Configuration');
                me.connectionStatus.setState('ERRORED');
                me.omActions.setState('DONE');
                return;
            end
            jmsg = ml.createCommand('open-session',address,[],[]);
            ml.start(jmsg,[],0);
            me.omActions.setState('OPENING_SESSION');
        end
        function disconnect(me)
            ml = SimulationState.getMdlLbcb();
            delete(ml);
%            omActions = me.omActions
            SimulationState.setMdlLbcb({});
            me.connectionStatus.setState('DISCONNECTED');
            me.omActions.setState('DONE');            
        end
    end
end