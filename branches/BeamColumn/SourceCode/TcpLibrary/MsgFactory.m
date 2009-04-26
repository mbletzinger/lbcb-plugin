classdef MsgFactory < handle
    properties
        simState = {};
        node = '';
    end
    methods
        function me = MsgFactory(simState,node)
            me.simState = simState;
            me.node = node;
        end
        function cmd = createCommand(me,command,content,cps,needTransId)
            cmd = CommandMsg(me.simState);
            cmd.jmsg.setCommand(command);
            cmd.jmsg.setContent(content);
            if(ischar(cps))
                cmd.jmsg.setNode(sprintf('%s:%s',me.node,cps));
            end
            if(needTransId)
                cmd.generateTransId();
                cmd.setSteps();
            end
        end
        function rsp = createResponse(me,content,jcommand)
            rsp = ResponseMsg(jcommand);
            rsp.jmsg.setContent(content);
        end
        function cmd = parseCommand(me,jmsg)
            cmd = CommandMsg(me.simState,jmsg);
        end
    end
end