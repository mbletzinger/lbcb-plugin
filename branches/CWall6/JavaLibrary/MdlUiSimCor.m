
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
% $LastChangedDate: 2009-10-24 20:25:33 -0500 (Sat, 24 Oct 2009) $
% $Author: mbletzin $
% =====================================================================================================================
classdef MdlUiSimCor < handle
    properties
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        simcorTcp = {};
        connection = {};
        command = {};
        response = {};
        log = Logger('MdlUiSimCor');
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        prevState;
        action = StateEnum({ ...
            'OPEN CONNECTION', ...
            'CLOSE CONNECTION', ...
            'RECEIVING COMMAND',...
            'SENDING RESPONSE',...
            'NONE'...
            });
        prevAction;
        cfg;
    end
    methods
        function me = MdlUiSimCor(cfg)
            me.cfg = cfg;
            me.state.setState('READY');
            me.prevState = StateEnum(me.state.states);
            me.prevAction = StateEnum(me.action.states);
            me.action.setState('NONE');
        end
        
        % Continue executing the current action
        function done = isDone(me)
            a = me.action.getState();
            if me.prevAction.isState(a) == 0
                me.log.debug(dbstack,sprintf('mdluisimcor action is %s',a));
                me.prevAction.setState(a);
            end
            switch a
                case { 'OPEN CONNECTION' 'CLOSE CONNECTION' }
                    me.connectionAction();
                case 'RECEIVING COMMAND'
                    me.receivingCommandAction();
                case 'SENDING RESPONSE'
                    me.sendingResponseAction();
                case 'NONE'
                otherwise
                    me.log.error(dbstack,sprintf('State %s not recognized',s));
            end
            ss = me.state.getState();
            if me.prevState.isState(ss) == 0
                me.log.debug(dbstack,sprintf('mdluisimcor state is %s',ss));
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
        
        % Start to open a connection to the operations manager
        function open(me)
            ncfg = NetworkConfigDao(me.cfg);
            me.params.setLocalPort(ncfg.simcorPort);
            me.params.setTcpTimeout(ncfg.connectionTimeout);
            me.params.setLfcrSendEom(false);
            me.simcorTcp = org.nees.uiuc.simcor.UiSimCorTcp('P2P_RECEIVE_COMMAND',...
                ncfg.address, ncfg.systemDescription);
            stamp = datestr(now,'_yyyy_mm_dd_HH_MM_SS');
            me.simcorTcp.setArchiveFilename(fullfile(pwd,'Logs',sprintf('UiSimCorNetworkLog%s.txt',stamp)));
            me.simcorTcp.getTf().setTransactionTimeout(ncfg.msgTimeout);
            me.simcorTcp.startup(me.params);
            me.action.setState('OPEN CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Start to close the connection to the operations manager
        function close(me)
            if isempty(me.simcorTcp)
                return;
            end
            me.simcorTcp.shutdown();
            me.action.setState('CLOSE CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Create a compound command (command with multiple MDL addresses)
        % the mdl, cps, and content arguments have to be cell arrays.
        % The return is a Java object containing the message.
        function jmsg = createCompoundResponse(me,mdl, cps, content)
            tf = me.simcorTcp.getTf();
            jmsg = tf.createCompoundResponse(mdl, cps, content,0);
        end
        
        % Create a simple command  all arguments are strings.  Any argument
        % that is not used should be passed in as an empty matrix [].
        % The return is a Java object containing the message.
        function jmsg = createResponse(me,mdl, cps, content)
            tf = me.simcorTcp.getTf();
            jmsg = tf.createResponse(mdl, cps, content,0);
        end
        
        % Start a transaction with the operations manager.  A transaction
        % consists of a command sent to the OM and the response returned by
        % the OM.
        function respond(me,jmsg)
            me.simcorTcp.continueTransaction(jmsg);
            me.action.setState('SENDING RESPONSE');
            me.state.setState('BUSY');
        end
        function start(me)
            ncfg = NetworkConfigDao(me.cfg);
            timeout = ncfg.msgTimeout;
            me.simcorTcp.startTransaction(timeout);
            me.action.setState('RECEIVING COMMAND');
            me.state.setState('BUSY');
        end
    end
    
    methods (Access=private)
        % process transaction
        function receivingCommandAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(me.simcorTcp.isReady());
            csS = ts.getState();
%             me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case 'ERRORS_EXIST'
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.isReady();
                    me.simcorTcp.shutdown();
                case 'CLOSING_CONNECTION'
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                case 'COMMAND_AVAILABLE'
                    %                    me.state.setState('READY');
                    transaction = me.simcorTcp.pickupTransaction();
                    me.log.debug(dbstack, sprintf('Command Transaction %s',char(transaction.toString())));
                    jcommand = transaction.getCommand();
                    me.command = CommandMessage(jcommand);
                    me.state.setState('READY');
                    me.action.setState('NONE');
                    me.simcorTcp.isReady();
                case {'WAIT_FOR_COMMAND' 'READ_COMMAND'}
                    % still busy
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',csS));
            end
        end
        function sendingResponseAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(me.simcorTcp.isReady());
            csS = ts.getState();
%             me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case 'ERRORS_EXIST'
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.isReady();
                    me.simcorTcp.shutdown();
                case 'TRANSACTION_DONE'
                    me.state.setState('READY');
                    me.action.setState('NONE');
                    me.simcorTcp.isReady();
                case { 'SENDING_RESPONSE', 'WAIT_FOR_RESPONSE'}
                    % still busy
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',csS));
            end
        end
        function connectionAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(char(me.simcorTcp.isReady()));
            csS = ts.getState();
            %           me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case 'TRANSACTION_DONE'
                    me.state.setState('READY');
                    me.action.setState('NONE');
                    me.simcorTcp.isReady();
                case 'ERRORS_EXIST'
                    me.simcorTcp.isReady();
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.shutdown();
                case {'CLOSING_CONNECTION' 'SHUTDOWN_CONNECTION' 'CHECK_LISTENER_OPEN_CONNECTION' ,'STOP_LISTENER'}
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',csS));
            end
        end
    end
end