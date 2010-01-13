classdef OpenCloseUiSimCor < UiSimCorState
    properties
        simCorActions = StateEnum({...
            'CONNECTING',...
            'DISCONNECTING',...
            'WAIT FOR OPEN SESSION',...
            'WAIT FOR SET PARAMETER',...
            'DONE',...
            });
         connectionStatus = StateEnum({'CONNECTED','DISCONNECTED','ERRORED'});
        closeIt = 0;
        log = Logger('OpenCloseUiSimCor');
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

            if me.mdlUiSimCor.state.isState('ERRORS EXIST')
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
                case 'WAIT FOR OPEN SESSION'
                    me.openingSession();
                case 'WAIT FOR SET PARAMETER'
                    me.setParameter();
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
                        me.simCorActions.setState('DONE');            
            me.log.error(dbstack,...
                sprintf('UI-SimCor link has been disconnected due to errors')); 
        end
    end
    methods (Access=private)
        function openingSession(me)
            address = me.cdp.getAddress();
            jmsg = me.mdlUiSimCor.createResponse(address,[],'LBCB Plugin initialized');
            me.mdlUiSimCor.respond(jmsg);
            me.simCorActions.setState('WAIT FOR SET PARAMETER');
        end
        function setParameter(me)
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
            me.mdlUiSimCor.respond(jmsg);
            me.simCorActions.setState('WAIT FOR OPEN SESSION');
        end
        function disconnect(me)
            me.connectionStatus.setState('DISCONNECTED');
            me.simCorActions.setState('DONE');            
        end
    end
end