classdef commandMsg < handle
    properties
        msg = org.nees.uiuc.simcor.data.SimCorMsgDao;
        type = stateEnum({'OK', 'NOT_OK', 'COMMAND'});
        simState = {};
    end
    methods
        function me = commandMsg(simState, msg)
            if nargin > 0
                if(isobject(simState))
                    me.simState = simState;
                end
                if(isobject(msg))
                    me.msg = msg;
                end
            end
        end
        function setSimState(me, simState)
            me.simState = simState;
        end
        function generateTransId(me)
            me.msg.createTransId();
        end
        function setSteps(me)
            me.msg.setStep(simState.step);
            me.msg.setSubStep(simState.subStep);
        end
    end
end


