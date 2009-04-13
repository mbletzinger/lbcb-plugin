classdef simcorMsg < handle
    properties
        msg = org.nees.uiuc.simcor.data.SimCorMsgDao;
        type = stateEnum({'OK', 'NOT_OK', 'COMMAND'});
    end
    methods
        function me = simcorMsg(command,content)
            if nargin > 0
                if(strcmp(command,'') ~= 0)
                    me.msg.setCommand(command);
                end
                if(strcmp(content,'') ~= 0)
                    me.msg.setContent(content);
                end
            end
        end
        function generateTransId(me)
            me.msg.createTransId();
        end
    end
end

