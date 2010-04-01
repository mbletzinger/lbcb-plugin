classdef OpenCloseOm < OmState
    properties
        omActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'DONE',...
            });
        prevAction
        connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        log = Logger('OpenCloseOm');
    end
    methods
        function me = OpenCloseOm()
            me.connectionStatus.setState('DISCONNECTED');
            me.prevAction = 0;
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
                    me.omActions.setState('DISCONNECTING');
            else
                me.mdlLbcb.open();
                me.statusBusy();
                me.omActions.setState('CONNECTING');
            end
        end
        function done = isDone(me)
            done = 0;
            a = me.omActions.getState();
            if me.omActions.idx ~= me.prevAction
                me.log.debug(dbstack,sprintf('Executing action %s',a));
                me.prevAction = me.omActions.idx;
            end
            mlDone = me.mdlLbcb.isDone();
            if mlDone == 0
                return;
            end
            
            if me.mdlLbcb.state.isState('ERRORS EXIST') && me.omActions.isState('CLOSING_SESSION') == false
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
            me.gui.colorRunButton('BROKEN'); % Pause the simulation
            me.gui.colorButton('CONNECT OM','BROKEN');
            me.omActions.setState('DONE');
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
                me.connectionStatus.setState('ERRORED');
                me.omActions.setState('DONE');
                return;
            end
            me.connectionStatus.setState('CONNECTED');
            me.omActions.setState('DONE');
        end
        function disconnect(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.gui.colorButton('CONNECT OM','OFF');
            me.omActions.setState('DONE');
        end
    end
end