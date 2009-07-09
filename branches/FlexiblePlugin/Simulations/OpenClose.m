classdef OpenClose < SimulationState
    properties
        connectionType = StateEnum({
            'OperationsManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
        connectionStatus = zeros(3,1);
        closeIt
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
                        ml.close();
                    else
                        ml.open();
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
                    done = ml.isDone();
                    if done && me.closeIt
                        delete(ml)
                        SimulationState.setMdlLbcb({});
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
end