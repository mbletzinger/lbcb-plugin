% =====================================================================================================================
% Class controling the communications to the Operations Manager.
%
% Members:
%   params - Java object containing network parameters.
%   simcorTcp - Java object which enacts transactions with the Operations Manager.
%   connection - Java object containing the TCP connection.
%   state - StateEnum object storing the current state.
%   action - StateEnum object storing the current action
%   response - ResponseMessage containing the response contents
%
% $LastChangedDate: 2010-03-28 05:38:28 -0500 (Sun, 28 Mar 2010) $
% $Author: mbletzin $
% =====================================================================================================================
classdef MdlBroadcast < handle
    properties
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        simcorTcp = {};
        connection = {};
        response = {};
        log = Logger('MdlBroadcast');
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        prevState;
        action = StateEnum({ ...
            'START LISTENER', ...
            'STOP LISTENER', ...
            'BROADCASTING',...
            'NONE'...
            });
        prevAction;
        cfg
        dbgWin
    end
    methods
        function me = MdlBroadcast(cfg)
            me.cfg = cfg;
            me.state.setState('READY');
            me.prevState = StateEnum(me.state.states);
            me.prevAction = StateEnum(me.action.states);
        end
        
        % Continue executing the current action
        function done = isDone(me)
            a = me.action.getState();
            if me.prevAction.isState(a) == 0
                me.log.debug(dbstack,sprintf('mdlbcb action is %s',a));
                me.prevAction.setState(a);
            end
            done = 0;
            switch a
                case { 'START LISTENER' 'STOP LISTENER' }
                    me.connectionAction();
                case 'BROADCASTING'
                    me.broadcastAction();
                case 'NONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('State %s not recognized',s));
            end
            ss = me.state.getState();
            if me.prevState.isState(ss) == 0
                me.log.debug(dbstack,sprintf('mdlbroadcast state is %s',ss));
                me.prevState.setState(ss);
            end
            switch ss
                case {'READY','ERRORS EXIST'}
                    done = 1;
                case 'BUSY'
                    done = 0;
                otherwise
                    me.log.error(dbstack,sprintf('State %s not recognized',ss));
                    
            end
        end
        
        % Start the broadcaster
        function startup(me)
            ncfg = NetworkConfigDao(me.cfg);
            me.params.setLocalPort(ncfg.triggerPort);
            me.params.setTcpTimeout(ncfg.connectionTimeout);
            me.simcorTcp = org.nees.uiuc.simcor.UiSimCorTriggerBroadcast(...
                ncfg.address, ncfg.systemDescription);
            stamp = datestr(now,'_yyyy_mm_dd_HH_MM_SS');
            me.simcorTcp.setArchiveFilename(fullfile(pwd,'Logs',sprintf('TriggerBroadcastNetworkLog%s.txt',stamp)));
            me.simcorTcp.getTf().setTransactionTimeout(ncfg.msgTimeout);
            me.simcorTcp.startup(me.params);
            me.action.setState('START LISTENER');
            me.state.setState('BUSY');
        end
        
        % Start to shut down the broadcast service
        function shutdown(me)
            me.simcorTcp.shutdown();
            me.action.setState('STOP LISTENER');
            me.state.setState('BUSY');
        end
        
        % Start a broadcast
        function start(me, stepNum)
            ncfg = NetworkConfigDao(me.cfg);
            tf = me.simcorTcp.getTf();
            timeout = ncfg.msgTimeout;
            jmsg = tf.createBroadcastTransaction(stepNum.step, stepNum.subStep, stepNum.correctionStep, timeout);
            me.simcorTcp.startTransaction(jmsg);
            me.dbgWin.addMsg(char(jmsg.toString));
            me.action.setState('BROADCASTING');
            me.state.setState('BUSY');
        end
    end
    
    methods (Access=private)
        % process transaction
        function broadcastAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(me.simcorTcp.isReady());
            csS = ts.getState();
            csS = me.errorsExist(csS);
            %            me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case 'ERRORS_EXIST'
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.isReady();
                    me.simcorTcp.shutdown();
                case 'READY'
                    me.state.setState('READY');
                    me.action.setState('NONE');
                    me.simcorTcp.isReady();
                case { 'SETUP_TRIGGER_READ_RESPONSES' 'WAIT_FOR_TRIGGER_RESPONSES' ...
                        'TRANSACTION_DONE'}
                    % still busy
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',ts.getState()));
            end
        end
        function connectionAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(char(me.simcorTcp.isReady()));
            csS = ts.getState();
            csS = me.errorsExist(csS);
            me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case {'READY' }
                    me.state.setState('READY');
                    me.action.setState('NONE');
                case 'ERRORS_EXIST'
                    me.simcorTcp.isReady();
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.shutdown();
                case {'TRANSACTION_DONE' 'BROADCAST_CLOSE_COMMAND' 'CLOSE_TRIGGER_CONNECTIONS' 'STOP_LISTENER'}
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',csS));
            end
        end
        function result = errorsExist(me,state)
            jerror = me.simcorTcp.getTransaction().getError();
            if jerror.errorsExist()
                me.log.error(dbstack,char(jerror.getText()));
                if jerror.isClientsAddedMsg()
                    result = state;
                else
                    result = 'ERRORS_EXIST';
                end
            else
                result = state;
            end
        end     
    end
end