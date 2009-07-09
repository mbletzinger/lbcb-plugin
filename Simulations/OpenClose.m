classdef OpenClose < SimulationState
    properties
        connectionType = StateEnum({
            'OperationManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
        connectionStatus = zeros(3,1);
        closeIt
    end
    methods
        function start(me, connection,closeIt)
            me.closeIt = closeIt;
            switch connection
                case 'OperationManager'
                    ml = SimulationState.getMdlLbcb();
                    if closeIt
                        ml.close();
                    else
                        ml.open();
                    end
%                 case 'TriggerBroadcasting'
%                 case 'SimCor'
                otherwise
                    me.log.error(dbstack(),sprintf('%s not recognized',connection));
            end
            me.connectionType.setState(connection);
        end
        function done = isDone(me)
           c = me.connectionType.getState();
            switch c
                case 'OperationManager'
                    ml = SimulationState.getMdlLbcb();
                    done = ml.isDone();
                    %                 case 'TriggerBroadcasting'
                    %                 case 'SimCor'
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',c));
            end
            me.connectionStatus(me.connectionType.idx) = ~ me.closeIt;
        end
    end
end