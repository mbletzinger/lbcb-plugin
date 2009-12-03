classdef TargetStates < SimStates
    properties
        currentAction = StateEnum({...
            'WAIT FOR TARGET',...
            'GET TARGET',...
            'EXECUTE SUBSTEPS',...
            'SEND TARGET RESPONSE',...
            'DONE'
            });
        state = StateEnum({...
            'BUSY',...
            'COMPLETED',...
            'ERRORS EXIST'...
            });
        targetSource = StateEnum({...
            'INPUT FILE',...
            'UI SIMCOR',...
            });
        stpEx = [];
        inF = [];
    end
    methods
        start(me)
        done = isDone(me)
    end
    methods (Access='private')
        waitForTarget(me)
        getTarget(me)
        steps = splitTarget(me)
        executeSubsteps(me)
        sendTargetResponses(me)
        setCorrectionFlag(me,step)
    end
end