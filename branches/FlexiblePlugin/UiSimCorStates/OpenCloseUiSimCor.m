classdef OpenCloseUiSimCor < UiSimCorState
    properties
        simCorActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'WAIT FOR_OPEN_SESSION',...
            'DONE',...
            });
         connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
   end
    methods
        function me = OpenCloseUiSimCor()
            me.connectionStatus.setState('DISCONNECTED');
        end
        function start(me, closeIt)
            me.closeIt = closeIt;
            if closeIt && me.connectionStatus.isState('DISCONNECTED')
                me.log.error(dbstack,'SIMCOR Connection already disconnected');
                return;
            end
            if closeIt == 0 && me.connectionStatus.isState('CONNECTED')
                me.log.error(dbstack,'SIMCOR Connection already connected');
                return;
            end
            if me.closeIt
                if me.connectionStatus.isState('CONNECTED')  % There are no errors
                    me.mdlUiSimCor.close();
                    me.simCorActions.setState('DISCONNECTING');
                end
            else
                me.mdlUiSimCor.open();
                me.simCorActions.setState('CONNECTING');
                me.connectionStatus.setState('CONNECTED');
            end
        end
        function done = isDone(me)
            done = 0;
            mlDone = me.mdlUiSimCor.isDone();
            if mlDone == 0
                return;
            end
            me.state.setState(me.mdlUiSimCor.state.getState());
            me.log.debug(dbstack,sprintf('OpenClose state is %s',me.state.getState()));

            if me.state.isState('ERRORS EXIST')
                done = 1;
                me.connectionError();
                return;
            end
            a = me.simCorActions.getState();
            me.log.debug(dbstack,sprintf('OpenCloseOm action is %s',a));
            switch a
                case 'CONNECTING'
                    me.connect();
                case 'DISCONNECTING'
                    me.disconnect();
                case 'WAIT FOR_OPEN_SESSION'
                    me.openingSession();
                case 'DONE'
                    done = 1;
                otherwise
                    done = 1;
                    me.log.error(dbstack(),sprintf('%s not recognized',a));
            end
        end
        function connectionError(me)
            me.connectionStatus.setState('ERRORED');
            me.gui.colorRunButton('BROKEN'); % Pause the simulation
            me.gui.colorButton('CONNECT SIMCOR','BROKEN');
                        me.omActions.setState('DONE');            
            me.log.error(dbstack, sprintf('%s link has been disconnected due to errors',...
                me.connectionType.getState())); 
        end
    end
    methods (Access=private)
        function openingSession(me)
            me.simCorActions.setState('DONE');            
        end
        function connect(me)
            address = me.cdp.getAddress();
            if isempty(address)
                me.log.error(dbstack,'SimCor Address is not set in the SIMCOR Configuration');
                me.connectionStatus.setState('ERRORED');
                me.simCorActions.setState('DONE');
                return;
            end
            jmsg = me.mdlUiSimCor.createResponse(address,[],'Open Session Succeeded');
            me.mdlUiSimCor.respond(jmsg,[],0);
            me.simCorActions.setState('WAIT FOR_OPEN_SESSION');
        end
        function disconnect(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.simCorActions.setState('DONE');            
        end
    end
end