classdef OpenClose < SimulationState
    properties
        connectionType = StateEnum({
            'OperationManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
    end
    methods
        function start(me, connection,closeIt)
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
        end
    end
end