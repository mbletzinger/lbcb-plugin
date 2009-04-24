classdef CommandListener < handle
    properties
        listener= org.nees.uiuc.simcor.CommandListener;
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        status = stateEnum({'NONE',...
            'IO_ERROR',...
            'TIMEOUT',...
            'UNKNOWN_REMOTE_HOST'});
        command = {};
        response = {};
        errorMsg = '';
    end
    methods
        function me = CommandListener(localPort)
            if  nargin > 0
                me.params.setlocalPort(localPort);
                me.params.setTcpReadTimeout(30);
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
            me.listener.close()
        end
    end
end