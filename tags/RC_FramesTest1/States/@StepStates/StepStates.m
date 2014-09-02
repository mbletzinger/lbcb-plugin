classdef StepStates < SimStates
    properties
        peOm = [];
        pResp = [];
        gcpOm = [];
        gipOm = [];
        brdcstRsp = [];
        acceptStp = [];
        gettingInitialPosition;
        log = Logger('StepStates');
        st
        started
        corrections
        stats
        
    end
    methods
        function me = StepStates()
            me = me@SimStates();
            me.currentAction = StateEnum({...
                'OM GET INITIAL POSITION',...
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
    end
end
