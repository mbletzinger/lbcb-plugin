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
        function readControlPoint(me)
        end
    end
end