classdef CommandListener < handle
    properties
        listener= org.nees.uiuc.simcor.CommandListener;
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        status = StateEnum({'NONE',...
            'IO_ERROR',...
            'TIMEOUT',...
            'UNKNOWN_REMOTE_HOST'});
        command = {};
        response = {};
        errorMsg = '';
        shuttingDown = 0;
    end
    methods
        function me = CommandListener(localPort,timeout)
            if  nargin > 0
                me.params.setLocalPort(localPort);
                me.params.setTcpTimeout(timeout);
                me.listener.setParams(me.params);
                me.listener.setupConnection();
            end
            
        end
        function isConnected = open(me)
            isConnected = me.listener.isConnected();
            me.shuttingDown = 0;
        end
        function send(me,jmsg)
            me.response = jmsg;
            me.listener.sendResponse(jmsg);
        end
        function done = isDone(me)
            if me.shuttingDown
                done = me.listener.closeConnection();
            else
                done = me.listener.isDone();
            end
        end
        function status = getResponse(me) % need this for the link state machine
            status = me.getCommand();
        end
        function status = getCommand(me)
            action = me.listener.getCommand();
            me.status.setState(action.getError());
            me.errorMsg = action.getErrorMsg();
            status = me.status;
            me.command = action.getMsg();
%            msg = action.dump()
        end
        function read(me)
            me.listener.readCommand()
        end
        function close(me)
            me.shuttingDown = 1;
            me.listener.closeConnection()
        end
    end
end