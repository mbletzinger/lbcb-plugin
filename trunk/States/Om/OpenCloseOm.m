classdef OpenCloseOm < OmState
    properties
        connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        log = Logger('OpenCloseOm');
    end
    methods
        function me = OpenCloseOm()
            me = me@OmState();
            me.connectionStatus.setState('DISCONNECTED');
            me.currentAction = StateEnum({...
                'CONNECTING',...
                'DISCONNECTING',...
                'DONE',...
                });
        end
        function aborted = start(me, closeIt)
            me.closeIt = closeIt;
            aborted = false;
            if closeIt && me.connectionStatus.isState('DISCONNECTED')
                me.log.error(dbstack,'OM Connection already disconnected');
                aborted = true;
                return;
            end
            if closeIt == 0 && me.connectionStatus.isState('CONNECTED')
                me.log.error(dbstack,'OM Connection already connected');
                aborted = true;
                return;
            end
            if me.closeIt
                me.mdlLbcb.close();
                me.currentAction.setState('DISCONNECTING');
            else
                me.mdlLbcb.open();
                me.statusBusy();
                me.currentAction.setState('CONNECTING');
            end
        end
        function done = isDone(me)
            done = 0;
            a = me.currentAction.getState();
            me.stateChanged();
            mlDone = me.mdlLbcb.isDone();
            if mlDone == 0
                return;
            end
            
            if me.mdlLbcb.state.isState('ERRORS EXIST') && me.currentAction.isState('CLOSING_SESSION') == false
                done = 1;
                me.connectionError();
                return;
            end
            switch a
                case 'CONNECTING'
                    me.connect();
                case 'DISCONNECTING'
                    me.disconnect();
                case 'DONE'
                    done = 1;
                    me.statusReady();
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',a));
            end
        end
        function connectionError(me)
            me.connectionStatus.setState('ERRORED');
            if isempty(me.gui) == false
                me.gui.colorRunButton('BROKEN'); % Pause the simulation
                me.gui.colorButton('CONNECT OM','BROKEN');
            end
            me.currentAction.setState('DONE');
            me.statusErrored();
            me.log.error(dbstack,...
                sprintf('OM link has been disconnected due to errors'));
        end
    end
    methods (Access=private)
        function connect(me)
            address = me.cdp.getAddress();
            if isempty(address)
                me.log.error(dbstack,'SimCor Address is not set in the OM Configuration');
                me.connectionError();
                return;
            end
            me.connectionStatus.setState('CONNECTED');
            me.currentAction.setState('DONE');
            if isempty(me.gui) == false
                me.gui.colorButton('CONNECT OM','ON');
                me.log.error('Cannot connect to the OM');
            end
        end
        function disconnect(me)
            me.connectionStatus.setState('DISCONNECTED');
            if isempty(me.gui) == false
                me.gui.colorButton('CONNECT OM','OFF');
            end
            me.currentAction.setState('DONE');
        end
    end
end