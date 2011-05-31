classdef StepStates < SimStates
    properties
        peOm = [];
        pResp = [];
        gcpOm = [];
        arch = [];
        brdcstRsp = [];
        acceptStp = [];
        gettingInitialPosition;
        log = Logger('StepStates');
        st
        started
        corrections
    end
    methods
        function me = StepStates()
            me = me@SimStates();
            me.currentAction = StateEnum({...
                'NEXT STEP',...
                'ACCEPT STEP',...
                'OM PROPOSE EXECUTE',...
                'OM GET CONTROL POINTS',...
                'PROCESS OM RESPONSE',...
                'BROADCAST TRIGGER',...
                'DONE'
                });
            me.started = false;
        end
        start(me,steps)
        getInitialPosition(me)
        done = isDone(me)
        resetOmStates(me)
    end
    methods (Access='private')
        isNextStep(me)
        needsTriggering = needsTriggering(me)
        shouldBeCorrected = shouldBeCorrected(me)
    end
end