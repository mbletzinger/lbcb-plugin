classdef TargetStates < SimStates
    properties
        targetSource = StateEnum({...
            'INPUT FILE',...
            'UI SIMCOR',...
            'NONE',...
            });
        stpEx = [];
        tgtRsp = [];
        ocSimCor = [];
        inF = [];
        startStep
        log = Logger('TargetStates');
        stats
    end
    methods
        function me = TargetStates()
            me = me@SimStates();
            me.currentAction = StateEnum({...
                'INITIAL POSITION',...
                'WAIT FOR TARGET',...
                'PROCESS TARGET',...
                'EXECUTE SUBSTEPS',...
                'SEND TARGET RESPONSE',...
                'ABORT SIMULATION',...
                'DONE'
                });
            me.currentAction.setState('DONE');
            me.targetSource.setState('NONE');
        end
        start(me,stepNumber)
        done = isDone(me)
    end
    methods (Access='private')
        initialPosition(me)
        waitForTarget(me)
        steps = splitTarget(me)
        executeSubsteps(me)
        sendTargetResponses(me)
        abortSimulation(me)
        str = dof2s(me,a)
    end
end