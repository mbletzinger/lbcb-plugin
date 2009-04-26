classdef CommandMsg < handle
    properties
        jmsg = org.nees.uiuc.simcor.msg.SimCorMsg;
        type = StateEnum({'OK', 'NOT_OK', 'COMMAND'});
        simState = {};
    end
    methods
        function me = CommandMsg(simState, jmsg)
            if nargin > 0
                if(isobject(simState))
                    me.simState = simState;
                end
            end
            if nargin > 1
                if(isobject(jmsg))
                    me.jmsg = jmsg;
                end
            end
        end
        function setSimState(me, simState)
            me.simState = simState;
        end
        function generateTransId(me)
            me.jmsg.createTransId();
        end
        function setSteps(me)
            me.jmsg.setStepNumber(me.simState.step);
            me.jmsg.setSubStepNumber(me.simState.subStep);
        end
    end
end


