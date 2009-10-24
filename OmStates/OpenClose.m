classdef OpenClose < SimState
    properties
        connectionType = StateEnum({
            'OperationsManager',....
            'TriggerBroadcasting',...
            'SimCor'
            });
        connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        hndlfact = [];
    end
    methods
        function me = OpenClose()
            me.connectionStatus.setState('DISCONNECTED');
        end
        function connectionError(me)
            me.ocOm.connectionStatus.setState('ERRORED');
            me.gui.colorRunButton('BROKEN'); % Pause the simulation
            me.gui.colorColorButton('CONNECT OM','BROKEN');
            me.log.error(dbstack, sprintf('%s link has been disconnected due to errors',...
                me.connectionType.getState())); 
        end
        
    end
end