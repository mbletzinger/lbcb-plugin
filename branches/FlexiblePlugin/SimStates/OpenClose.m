classdef OpenClose < SimState
    properties
        connectionType = StateEnum({
            'OperationsManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
        connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        cfg = [];
    end
    methods
        function me = OpenClose()
            me.connectionStatus.setState('DISCONNECTED');
        end
    end
end