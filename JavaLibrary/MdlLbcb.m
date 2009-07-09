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
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef MdlLbcb < handle
    properties
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        simcorTcp = {};
        connection = {};
        response = {};
        log = Logger;
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        action = StateEnum({ ... 
            'OPEN CONNECTION', ...
            'CLOSE CONNECTION', ...
            'EXECUTING TRANSACTION',...
            'NONE'...
            });
    end
    methods
        function me = MdlLbcb(cfg)
            ncfg = NetworkConfigDao(cfg);
            me.params.setRemoteHost(ncfg.omHost);
            me.params.setRemotePort(sscanf(ncfg.omPort,'%d'));
            me.params.setTcpTimeout(sscanf(ncfg.timeout,'%d'));
            me.simcorTcp = org.nees.uiuc.simcor.UiSimCorTcp('SEND_COMMAND',me.params);
            me.state.setState('READY');
        end
        
        % Continue executing the current action
        function done = isDone(me)
            a = me.action.getState();
            done = 0;
            switch a
                case 'OPEN CONNECTION'
                    me.openConnectionAction();
                case 'CLOSE CONNECTION'
                    me.closeConnectionAction();
                case 'EXECUTING TRANSACTION'
                    me.executeTransactionAction();
                case 'NONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('State %s not recognized',s));
            end
            if me.state.isState('READY') || me.state.isState('ERRORS EXIST')
                done = 1;
            end
        end
        
        % Start to open a connection to the operations manager
        function open(me)
            cf = me.simcorTcp.getConnectionFactory();
            me.simcorTcp.setup();
            me.connection = cf.getConnection();
            me.action.setState('OPEN CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Start to close the connection to the operations manager
        function close(me)
            if me.state.isState('ERRORS EXIST')
                return
            end
            cf = me.simcorTcp.getConnectionFactory();
            cf.closeConnection(me.connection);
            me.action.setState('CLOSE CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Create a compound command (command with multiple MDL addresses)
        % the mdl, cps, and content arguments have to be cell arrays.
        % The return is a Java object containing the message.
        function jmsg = createCompoundCommand(me,cmd, mdl, cps, content)
            tf = me.simcorTcp.getTransactionFactory();
            jmsg = tf.createCompoundCommand(cmd, mdl, cps, content);
        end
        
        % Create a simple command  all arguments are strings.  Any argument
        % that is not used should be passed in as an empty matrix [].
        % The return is a Java object containing the message.
        function jmsg = createCommand(me,cmd, mdl, cps, content)
            tf = me.simcorTcp.getTransactionFactory();
            jmsg = tf.createCommand(cmd, mdl, cps, content);
        end
        
        % Start a transaction with the operations manager.  A transaction
        % consists of a command sent to the OM and the response returned by
        % the OM.
        function start(me,jmsg, simsteps,createId)
            tf = me.simcorTcp.getTransactionFactory();
            if createId
                id = tf.createTransactionId(simsteps.step, simsteps.subStep);
                tf.setId(id);
            end
            transaction = tf.createTransaction(jmsg);
            me.simcorTcp.startTransaction(transaction);
            me.action.setState('EXECUTING TRANSACTION');
            me.state.setState('BUSY');
        end
    end
    
    methods (Access=private)
        %  Process open connection
        function openConnectionAction(me)
            if isempty(me.connection)
                cf = me.simcorTcp.getConnectionFactory();
                me.connection = cf.getConnection();
                return;
            end
            s = InitStates();
            cs = StateEnum(s.connectionStates);
            cs.setState(me.connection.getConnectionState());
            if cs.isState('READY')
                me.state.setState('READY');
                me.action.setState('NONE');
            end
            if cs.isState('IN_ERROR')
                me.log.error(dbstack,char(me.connection.getFromRemoteMsg().getError().getText()));
%                me.close();
                me.state.setState('ERRORS EXIST');
                me.action.setState('NONE');
            end
        end
        % process transaction
        function executeTransactionAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(me.simcorTcp.isReady());
            if ts.isState('ERRORS_EXIST')
                me.state.setState('ERRORS EXIST');
                me.action.setState('NONE');
                me.log.error(dbstack(),char(me.connection.getFromRemoteMsg().getError().getText()));
            end
            if ts.isState('RESPONSE_AVAILABLE')
                me.state.setState('READY');
                transaction = me.simcorTcp.pickupTransaction();
                jresponse = transaction.getResponse();
                me.response = ResponseMessage(jresponse);
            end
            if ts.isState('TRANSACTION_DONE')
                me.state.setState('READY');
                me.action.setState('NONE');
            end
        end
        function closeConnectionAction(me)
            s = InitStates();
            cs = StateEnum(s.connectionStates);
            cs.setState(me.connection.getConnectionState());
            if cs.isState('READY')
                me.state.setState('READY');
                me.action.setState('NONE');
            end
            if cs.isState('IN_ERROR')
                me.state.setState('ERRORS EXIST');
                me.action.setState('NONE');
                me.log.error(dbstack(),char(me.connection.getFromRemoteMsg().getError().getText()));
            end
        end
    end
end