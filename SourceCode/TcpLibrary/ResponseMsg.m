classdef responseMsg < handle
    properties
        msg = org.nees.uiuc.simcor.data.SimCorMsg;
        type = stateEnum({'OK', 'NOT_OK', 'COMMAND'});
    end
    methods
        function me = responseMsg(jmsg)
            if nargin > 0
                if(isobject(msg))
                    me.msg = org.nees.uiuc.simcor.data.SimCorMsg(jmsg);
                    me.msg.setResponse('OK');
                    me.msg.setCommand([]);
                end
            end
        end
    end
end


