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
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    address = me.getAddress();
                    jmsg = me.mdlLbcb.createCommand('close-session',address,[],[]);
                    me.mdlLbcb.start(jmsg,[],0);
                    me.omActions.setState('CLOSING_SESSION');
                else
                    me.mdlLbcb.close();
                    me.omActions.setState('DISCONNECTING');
                end
            else
                me.mdlLbcb.open();
                me.omActions.setState('CONNECTING');
            end
        end
        function done = isDone(me)
            done = 0;
            mlDone = me.mdlLbcb.isDone();
            if mlDone == 0
                return;
            end
            me.state.setState(me.mdlLbcb.state.getState());
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
            me.mdlLbcb.close();
            me.omActions.setState('DISCONNECTING');            
        end
        function connect(me)
            address = me.getAddress();
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
            me.omActions.setState('DONE');            
        end
    end
end