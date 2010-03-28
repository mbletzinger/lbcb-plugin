classdef TargetStates < SimStates
    properties
        currentAction = StateEnum({...
            'INITIAL POSITION',...
            'WAIT FOR TARGET',...
            'PROCESS TARGET',...
            'EXECUTE SUBSTEPS',...
            'SEND TARGET RESPONSE',...
            'ABORT SIMULATION',...
            'DONE'
            });
        targetSource = StateEnum({...
            'INPUT FILE',...
            'UI SIMCOR',...
            'NONE',...
            });
        prevAction
        stpEx = [];
        prcsTgt = [];
        tgtRsp = [];
        ocSimCor = [];
        inF = [];
        startStep
        log = Logger('TargetStates');
    end
    methods
        function me = TargetStates()
            me.currentAction.setState('DONE');
            me.targetSource.setState('NONE');
        end
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
        abortSimulation(me)
    end
end