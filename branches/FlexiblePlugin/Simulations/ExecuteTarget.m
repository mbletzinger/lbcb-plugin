% =====================================================================================================================
% Class which process the propose/execute/get-control-point sequence
%
% Members:
%   mdlLbcb - MdlLbcb module to communicate with the OM.
%   targets - Current targets.
%
% $LastChangedDate$ 
% $Author$
% =====================================================================================================================
classdef ExecuteTarget < handle
    properties
        mdlLbcb = {};
        targets = {};
        numLbcbs = 1;
        readings = [];
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
        cpsMsg = StateEnum({...
            'LBCB1',...
            'LBCB2',...
            'ExternalSensors',...
            'NONE',...
            });
    end
    methods
        function me = ExecuteTarget(mdlLbcb,numLbcbs)
            me.mdlLbcb = mdlLbcb;
            me.numLbcbs = numLbcbs;
        end
        % Start the propose/execute/get-control-point sequence
        function execute(me,targets)
            me.targets = targets;
            me.startPropose(targets);
        end
        % Continue the sequence return true if completed
        function result = isDone(me)
            result = 0;
            if me.mdlLbcb.isDone() == 0
                return;
            end
            a = me.action.getState();
            switch a
                case 'DONE'
                    result = 1;
                case 'PROPOSE'
                    me.startExecute();
                case 'EXECUTE'
                    me.startGetControlPoint();
                case 'GET CONTROL POINTS'
                    me.readControlPoint();
                    me.startGetControlPoint();
                otherwise
                    str = sprintf('%s not recognized',a);
                    disp(str);
            end
        end
    end
    methods (Access=private)
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
        function startGetControlPoint(me)
            c = me.cpsMsg.getState();
            switch c
                case 'LBCB1'
                    if me.numLbcbs == 2
                        me.cpsMsg.setState('LBCB2');
                    else
                        me.cpsMsg.setState('ExternalSensors');
                    end
                case 'LBCB2'
                    me.cpsMsg.setState('ExternalSensors');
                case 'ExternalSensors'
                    me.cpsMsg.setState('NONE');
                    me.state.setState('READY');
                    me.action.setState('DONE');
                    return;
                case 'NONE'
                    me.cpsMsg.setState('LBCB1');
                    me.readings = cell(me.numLbcbs,1);
            end
            jmsg = me.mdlLbcb.createCommand('execute',me.targets(1).node,a.cpsMsg,[]);
            me.mdlLbcb.start(jmsg);
            me.state.setState('BUSY');
            me.action.setState('GET_CONTROL_POINT');            
        end
        function readControlPoint(me)
           rsp =  me.mdlLbcb.response;
           lbcb = LbcbReading;
           [address contents] = rsp.getContent();
           lbcb.parse(contents,rsp.me.targets(1).node);
           me.readings{me.cpsMsg.idx} = lbcb;
        end
    end
end