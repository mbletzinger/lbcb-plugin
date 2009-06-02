classdef ExecuteTarget < handle
    properties
        mdlLbcb = {};
        targets = {};
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        action = StateEnum({ ...
            'DONE'...
            'PROPOSE', ...
            'EXECUTE', ...
            'GET CONTROL POINTS',...
            });        
    end
    methods
        function me = ExecuteTarget(mdlLbcb)
            me.mdlLbcb = mdlLbcb;
        end
        function execute(me,targets)
            me.targets = targets;
            me.startPropose(targets);
        end
        function result = isDone(me)
            result = 0;
            if me.mdlLbcb.isDone()
            end
        end
    end
    methods (Access='private')
        function startPropose(me,targets)
            lgth = length(targets);
            mdl = cell(lgth,1);
            cps = cell(lgth,1);
            contents = cell(lgth,1);
            for t = 1:lgth
                mdl(t) = targets(t).node;
                cps(t) = targets(t).cps;
                contents(t) = targets(t).createMsg();
            end
            jmsg = me.mdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
            me.mdlLbcb.start(jmsg);
            me.state.setState('BUSY');
            me.action.setState('PROPOSE');
        end
        function startExecute(me)
            jmsg = me.mdlLbcb.createCommand('execute',me.targets(1).node,[],[]);
            me.mdlLbcb.start(jmsg);
            me.state.setState('BUSY');
            me.action.setState('EXECUTE');
        end
    end
end