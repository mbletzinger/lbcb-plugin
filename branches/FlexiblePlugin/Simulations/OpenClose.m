classdef OpenClose < SimulationState
    properties
        connectionType = StateEnum({
            'OperationsManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
        connectionStatus = zeros(3,1);
        omActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'CLOSING_SESSION',...
            'OPENING_SESSION',...
            'DONE',...
            });
        closeIt = 0;
    end
    methods
        function start(me, connection,cfg)
            me.connectionType.setState(connection);
            me.closeIt = me.connectionStatus(me.connectionType.idx);
            switch connection
                case 'OperationsManager'
                    if me.closeIt
                        ml = SimulationState.getMdlLbcb();
                    else
                        ml = MdlLbcb(cfg);
                        SimulationState.setMdlLbcb(ml);
                    end
                    if me.closeIt
                        if ml.state.isState('ERRORS EXIST') == 0  % There are no errors
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
                    %                 case 'TriggerBroadcasting'
                    %                 case 'SimCor'
                otherwise
                    me.log.error(dbstack(),sprintf('%s not recognized',connection));
            end
        end
        function done = isDone(me)
            c = me.connectionType.getState();
            done = 0;
            switch c
                case 'OperationsManager'
                    ml = SimulationState.getMdlLbcb();
                    mlDone = ml.isDone();
                    if mlDone == 0
                        return;
                    end
                    me.state.setState(ml.state.getState);
                    if me.state.isState('ERRORS EXIST')
                        done = 1;
                        me.connectionStatus(me.connectionType.idx) = 0;
                        return;
                    end
                    a = me.omActions.getState();
                    switch a
                        case 'CONNECTING'
                            me.connectOm();
                        case 'DISCONNECTING'
                            me.disconnectOm();
                        case 'CLOSING_SESSION'
                            me.closingOmSession();
                        case 'OPENING_SESSION'
                            me.openingOmSession();
                        case 'DONE'
                            done = 1;
                        otherwise
                            done = 1;
                            me.log.error(dbstack(),sprintf('%s not recognized',a));
                    end
                        
                    %                 case 'TriggerBroadcasting'
                    %                 case 'SimCor'
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',c));
            end
            if done
                me.connectionStatus(me.connectionType.idx) = ~ me.closeIt;
            end
        end
    end
    methods (Access=private)
        function openingOmSession(me)
            me.omActions.setState('DONE');            
        end
        function closingOmSession(me)
            ml = SimulationState.getMdlLbcb();
            ml.close();
            me.omActions.setState('DISCONNECTING');            
        end
        function connectOm(me)
            ml = SimulationState.getMdlLbcb();
            address = StepData.getAddress();
            jmsg = ml.createCommand('open-session',address,[],[]);
            ml.start(jmsg,[],0);
            me.omActions.setState('OPENING_SESSION');
        end
        function disconnectOm(me)
            ml = SimulationState.getMdlLbcb();
            delete(ml)
            SimulationState.setMdlLbcb({});
            me.omActions.setState('DONE');            
        end
    end
end