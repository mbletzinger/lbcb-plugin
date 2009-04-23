classdef commandSender < handle
    properties
        sender= org.nees.uiuc.simcor.CommandSender;
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
        function me = commandSender(remoteHost, remotePort)
            if  nargin > 0
                me.params.setRemoteHost(remoteHost);
                me.params.setRemotePort(remotePort);
                me.params.setTcpReadTimeout(30);
                me.sender.setParams(me.params);
                me.sender.setupConnection();
            end
            
        end
        function open(me)
            me.sender.openConnection();
        end
        function send(me,jmsg)
            me.command = jmsg;
            me.sender.sendCommand(jmsg);
        end
        function done = isDone(me)
            done = me.sender.isDone();
        end
        function status = getResponse(me)
            action = me.sender.getResponse();
            me.status.setState(action.getError());
            me.errorMsg = action.getErrorMsg();
            status = me.status;
            me.response = action.getMsg();
        end
        function read(me)
            me.sender.readResponse()
        end
        function close(me)
            me.sender.closeConnection()
        end
    end
end