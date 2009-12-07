classdef TargetStates < SimStates
    properties
        currentAction = StateEnum({...
            'INITIAL POSITION',...
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
        startStep
    end
    methods
        start(me,stepNumber)
        done = isDone(me)
    end
    methods (Access='private')
        initialPosition(me)
        waitForTarget(me)
        processTarget(me)
        steps = splitTarget(me)
        executeSubsteps(me)
        sendTargetResponses(me)
        setCorrectionFlag(me,step)
    end
end