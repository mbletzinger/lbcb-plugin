classdef commandMsgFactory < handle
    properties
        simState = {};
    end
    methods
        function me = commandMsgFactory(simState)
            me.simState = simState;
        end
        function cmd = createCommand(me,command,content)
           cmd = commandMsg(me.simState);
           cmd.msg.setCommand(command);
           cmd.msg.setContent(content);
           cmd.generateTransId();
           cmd.setSteps();
        end
        function cmd = parseCommand(me,jmsg)
            cmd = commandMsg(me.simState,jmsg);
        end
    end
end