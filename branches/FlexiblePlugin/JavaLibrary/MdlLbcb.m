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
        log = Logger('MdlLbcb');
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        prevState;
        action = StateEnum({ ... 
            'OPEN CONNECTION', ...
            'CLOSE CONNECTION', ...
            'EXECUTING TRANSACTION',...
            'NONE'...
            });
        prevAction;
        cfg
        dbgWin
    end
    methods
        function me = MdlLbcb(cfg)
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
                case { 'OPEN CONNECTION' 'CLOSE CONNECTION' }
                    me.connectionAction();
                case 'EXECUTING TRANSACTION'
                    me.executeTransactionAction();
                case 'NONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('State %s not recognized',s));
            end
            ss = me.state.getState();
            if me.prevState.isState(ss) == 0
                me.log.debug(dbstack,sprintf('mdlbcb state is %s',ss));
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
            me.params.setRemoteHost(ncfg.omHost);
            me.params.setRemotePort(sscanf(ncfg.omPort,'%d'));
            me.params.setTcpTimeout(sscanf(ncfg.timeout,'%d'));
            me.simcorTcp = org.nees.uiuc.simcor.UiSimCorTcp('SEND_COMMAND',me.params);
            stamp = datestr(now,'_yyyy_mm_dd_HH_MM_SS');
            me.simcorTcp.setArchiveFilename(fullfile(pwd,'Logs',sprintf('OmNetworkLog%s.txt',stamp)));
            me.simcorTcp.startup();
            me.action.setState('OPEN CONNECTION');
            me.state.setState('BUSY');
        end
        
        % Start to close the connection to the operations manager
        function close(me)
            me.simcorTcp.shutdown();
            me.action.setState('CLOSE CONNECTION');
            me.state.setState('BUSY');
            me.simcorTcp = [];
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
        function start(me,jmsg, stepNums,createId)
            tf = me.simcorTcp.getTransactionFactory();
            if createId
                id = tf.createTransactionId(stepNums.step, stepNums.subStep, stepNums.correctionStep);
                tf.setId(id);
            end
            transaction = tf.createTransaction(jmsg);
            me.simcorTcp.startTransaction(transaction);
            me.dbgWin.addMsg(char(jmsg.toString));
            me.action.setState('EXECUTING TRANSACTION');
            me.state.setState('BUSY');
        end
    end
    
    methods (Access=private)
        % process transaction
        function executeTransactionAction(me)
            is = InitStates();
            ts = StateEnum(is.transactionStates);
            ts.setState(me.simcorTcp.isReady());
            csS = ts.getState();
%            me.log.debug(dbstack,sprintf('Transaction state is %s',csS));
            switch csS
                case 'ERRORS_EXIST'
                    me.state.setState('ERRORS EXIST');
                    me.action.setState('NONE');
                    me.log.error(dbstack(),char(me.simcorTcp.getTransaction().getError().getText()));
                    me.simcorTcp.isReady();
                    me.simcorTcp.shutdown();
                case 'RESPONSE_AVAILABLE'
%                    me.state.setState('READY');
                    transaction = me.simcorTcp.pickupTransaction();
                    jresponse = transaction.getResponse();
                    me.dbgWin.addMsg(char(jresponse.toString));
                    me.response = ResponseMessage(jresponse);
                case 'TRANSACTION_DONE'
                    me.state.setState('READY');
                    me.action.setState('NONE');
                    me.simcorTcp.isReady();
                case { 'READ_RESPONSE', 'WAIT_FOR_RESPONSE' 'SENDING_COMMAND'}
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
                case {'CLOSING_CONNECTION' 'OPENING_CONNECTION' }
                otherwise
                    me.log.error(dbstack,sprintf('"%s" not recognized',csS));
            end
        end
    end
end