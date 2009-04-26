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
        end
        function send(me,jmsg)
            me.response = jmsg;
            me.listener.sendResponse(jmsg);
        end
        function done = isDone(me)
            done = me.listener.isDone();
        end
        function status = getResponse(me)
            action = me.listener.getResponse();
            me.status.setState(action.getError());
            me.errorMsg = action.getErrorMsg();
            status = me.status;
            me.command = action.getMsg();
        end
        function read(me)
            me.listener.readCommand()
        end
        function close(me)
            me.listener.closeConnection()
        end
    end
end