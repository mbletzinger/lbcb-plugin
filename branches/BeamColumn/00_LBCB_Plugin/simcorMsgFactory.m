classdef simcorMsgFactory < handle
    properties
        simState = {};
    end
    methods
        function me = simcorMsgFactory(simState)
            me.simState = simState;
        end
        function msg = createMsg(me,command,content)
           jmsg = simcorMsg(me.simState,command,content);
           msg = jmsg.getMsg();
        end
    end
end