classdef OpenCloseOm < OmState
    properties
        omActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'CLOSING_SESSION',...
            'OPENING_SESSION',...
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
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    address = me.cdp.getAddress();
                    jmsg = me.mdlLbcb.createCommand('close-session',address,[],[]);
                    me.mdlLbcb.start(jmsg,[],0);
                    me.omActions.setState('CLOSING_SESSION');
                else
                    me.mdlLbcb.close();
                    me.omActions.setState('DISCONNECTING');
                end
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
            
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                done = 1;
                me.connectionError();
                return;
            end
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
        function openingSession(me)
            me.connectionStatus.setState('CONNECTED');
            me.gui.colorButton('CONNECT OM','ON');
            me.omActions.setState('DONE');
        end
        function closingSession(me)
            me.mdlLbcb.close();
            me.omActions.setState('DISCONNECTING');
        end
        function connect(me)
            address = me.cdp.getAddress();
            if isempty(address)
                me.log.error(dbstack,'SimCor Address is not set in the OM Configuration');
                me.connectionStatus.setState('ERRORED');
                me.omActions.setState('DONE');
                return;
            end
            jmsg = me.mdlLbcb.createCommand('open-session',address,[],[]);
            me.mdlLbcb.start(jmsg,[],0);
            me.omActions.setState('OPENING_SESSION');
        end
        function disconnect(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.gui.colorButton('CONNECT OM','OFF');
            me.omActions.setState('DONE');
        end
    end
end