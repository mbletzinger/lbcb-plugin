classdef ResponseMsg < handle
    properties
        jmsg = org.nees.uiuc.simcor.msg.SimCorMsg;
        type = StateEnum({'OK', 'NOT_OK', 'COMMAND'});
    end
    methods
        function me = ResponseMsg(jmsg)
            if nargin > 0
                if(isobject(jmsg))
                    me.jmsg = org.nees.uiuc.simcor.data.SimCorMsg(jmsg);
                    me.jmsg.setResponse('OK');
                    me.jmsg.setCommand([]);
                end
            end
        end
    end
end


