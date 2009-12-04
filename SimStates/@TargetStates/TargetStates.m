classdef TargetStates < SimStates
    properties
        currentAction = StateEnum({...
            'WAIT FOR TARGET',...
            'PROCESS TARGET',...
            'EXECUTE SUBSTEPS',...
            'SEND TARGET RESPONSE',...
            'DONE'
            });
        targetSource = StateEnum({...
            'INPUT FILE',...
            'UI SIMCOR',...
            });
        stpEx = [];
        prcsTgt = [];
        inF = [];
    end
    methods
        start(me)
        done = isDone(me)
    end
    methods (Access='private')
        waitForTarget(me)
        processTarget(me)
        steps = splitTarget(me)
        executeSubsteps(me)
        sendTargetResponses(me)
        setCorrectionFlag(me,step)
    end
end