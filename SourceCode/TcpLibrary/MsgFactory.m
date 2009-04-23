classdef msgFactory < handle
    properties
        simState = {};
        node = '';
    end
    methods
        function me = msgFactory(simState,node)
            me.simState = simState;
            me.node = node;
        end
        function cmd = createCommand(me,command,content,cps,needTransId)
            cmd = commandMsg(me.simState);
            cmd.msg.setCommand(command);
            cmd.msg.setContent(content);
            if(ischar(cps))
                cmd.msg.setNode(sprintf('%s:%s',me.node,cps));
            end
            if(needTransId)
                cmd.generateTransId();
                cmd.setSteps();
            end
        end
        function rsp = createResponse(me,content,cps,jcommand)
            rsp = responseMsg(command);
            rsp.msg.setContent(content);
        end
        function cmd = parseCommand(me,jmsg)
            cmd = commandMsg(me.simState,jmsg);
        end
    end
end