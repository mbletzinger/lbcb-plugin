classdef commandMsg < handle
    properties
        msg = org.nees.uiuc.simcor.data.SimCorMsgDao;
        type = stateEnum({'OK', 'NOT_OK', 'COMMAND'});
        simState = {};
    end
    methods
        function me = commandMsg(simState, command,content)
            if nargin > 0
                if(isobject(simState))
                    me.simState = simState;
                end

                if(strcmp(command,'') ~= 0)
                    me.msg.setCommand(command);
                end
                if(strcmp(content,'') ~= 0)
                    me.msg.setContent(content);
                end
            end
        end
        function setSimState(me, simState)
            me.simState = simState;
        end
        function generateTransId(me)
            me.msg.createTransId();
        end
        function msg = getMsg(me)
            me.msg.setStep(simState.step);
            me.msg.setSubStep(simState.subStep);
            msg = me.msg;
        end
    end
end


