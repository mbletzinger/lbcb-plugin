classdef commandSender < handle
    properties
        sender= org.nees.uiuc.simcor.CommandSender;
        params = org.nees.uiuc.simcor.tcp.TcpParameters;
        status = stateEnum({'NONE',...
            'IO_ERROR',...
            'TIMEOUT',...
            'UNKNOWN_REMOTE_HOST'});
        dto = {};
    end
    methods
        function me = commandSender(remoteHost, remotePort)
            if  nargin > 0
                me.params.setRemoteHost(remoteHost);
                me.params.setRemotePort(remotePort);
                me.params.setTcpReadTimeout(30);
                me.sender.setParams(me.params);
                me.dto = sender.getDto;
            end
            
        end
        function status = open(me)
            me.sender.openConnection();
            me.status.setState(me.dto.getError());
            status = me.status;
        end
        function status = send(me,msg)
            me.sender.openConnection();
            me.status.setState(me.dto.getError());
            status = me.status;
        end
    end
end