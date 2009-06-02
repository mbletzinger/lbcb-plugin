% =====================================================================================================================
% Class controling the communications to the Operations Manager.
%
% Members:
%   params - Java object containing network parameters.
%   simcorTcp - Java object which enacts transactions with the Operations Manager.
%   simstate -  contains the simulation state information.
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
        simstate = {};
        response = {};
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'RESPONSE AVAILABLE'...
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
        function me = MdlLbcb(omHost, omPort,timeout,simstate)
            me.simstate = simstate;
            me.params.setRemoteHost(omHost);
            me.params.setRemotePort(omPort);
            me.params.setTimeout(timeout);
            me.simcorTcp = org.nees.uiuc.simcor.UiSimCorTcp('SEND_COMMAND',me.params);
            me.state.setState('READY');
        end
        
        % Continue executing the current action
        function done = isDone(me)
            s = me.action.getState();
            done = 0;
            switch s
                case 'OPEN CONNECTION'
                    me.openConnectionAction();
                case 'CLOSE CONNECTION'
                    me.closeConnectionAction();
                case 'EXECUTING TRANSACTION'
                    me.executeTransactionAction();
                case 'NONE'
                    done = 1;
                otherwise
                    Str = sprintf('State %s not recognized',s);
                    disp(Str);
            end
            if me.state.isState('READY')
                done = 1;
            end
        end
        
        % Start to open a connection to the operations manager
        function open(me)
            cf = me.simcorTcp.getConnectionFactory();
            me.connection = cf.getConnection();
            me.action.setState('OPEN CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Start to close the connection to the operations manager
        function close(me)
            me.action.setState('CLOSE CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Create a compound command (command with multiple MDL addresses)
        % the mdl, cps, and content arguments have to be cell arrays.
        % The return is a Java object containing the message.
        function jmsg = createCompoundCommand(cmd, mdl, cps, content)
            tf = me.simcorTcp.getTransactionFactory();
            jmsg = tf.createCommand(cmd, mdl, cps, content);
        end
        
        % Create a simple command  all arguments are strings.  Any argument
        % that is not used should be passed in as an empty matrix [].
        % The return is a Java object containing the message.
        function jmsg = createCommand(cmd, mdl, cps, content)
            tf = me.simcorTcp.getTransactionFactory();
            jmsg = tf.createCommand(cmd, mdl, cps, content);
        end
        
        % Start a transaction with the operations manager.  A transaction
        % consists of a command sent to the OM and the response returned by
        % the OM.
        function start(me,jmsg)
            tf = me.simcorTcp.getTransactionFactory();
            id = TransactionIdentity;

            if me.simstate.step > 0
                id.setStep(me.simstate.step);
            end
            
            if me.simstate.subStep > 0
                id.setSubStep(me.simstate.subStep);
            end
            
            id.createTransId();
            tf.setId(id);
            transaction = tf.createTransaction(jmsg);
            me.simcorTcp.startTransaction(transaction);
            me.action.setState('EXECUTING TRANSACTION');
            me.state.setState('BUSY');
        end
    end
    
    methods (Access='private')
        %  Process open connection
        function openConnectionAction(me)
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
            end
            if ts.isState('RESPONSE_AVAILABLE')
                me.state.setState('RESPONSE AVAILABLE');
                transaction = simcor.pickupTransaction();
                jresponse = transaction.getResponse();
                me.response = ResponseMessage(jresponse);
            end
            if ts.isState('TRANSACTION_DONE')
                me.state.setState('READY');
                me.action.setState('NONE');
            end
        end
        function closeConnectionAction(me)
            cf = me.simcorTcp.getConnectionFactory();
            if cf.closeConnection()
                me.state.setState('READY');
                me.action.setState('NONE');                
            end
        end
    end
end