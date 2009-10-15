classdef StepExecute < SimExecute
    properties
        fakeOm = [];
        nxtStep = [];
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = [];
        dd = [];
        
        currentStepAction = StateEnum({...
            'NEXT STEP',...
            'CHECK LIMITS'...
            'OM PROPOSE EXECUTE',...
            'OM GET CONTROL POINTS',...
            'PROCESS OM RESPONSE',...
            'BROADCAST TRIGGER',...
            'DONE'
            });
        state = StateEnum({...
            'BUSY',...
            'COMPLETED',...
            'ERRORS EXIST'...
            });
        log = Logger;
    end
    methods
        function start(me,steps)
            me.nxtStep.steps = steps;
            me.currentAction.setState('NEXT STEP');                
        end
        function done = isDone(me)
            switch me.currentAction.getState()
    case'NEXT STEP'
        done = me.nxtStep.isDone();
        if done % Next target is ready
            if me.nxtStep.simCompleted  %  No more targets
                me.setRunButton(0); % Pause the simulation
                me.log.info(dbstack,'Simulation is Over');
                me.currentAction.setState('READY');
            else % Execute next step
                if me.fakeOm == 0
                    me.peOm.step = me.nxtStep.nextStepData;
                end
                me.updateSteps();
                me.currentAction.setState('CHECK LIMITS');
            end
        end
    case 'OM PROPOSE EXECUTE'
        if me.fakeOm == 0
            done = me.peOm.isDone();
            if done % execute response has been received from OM
                if me.peOm.state.isState('ERRORS EXIST')
                    me.ocOm.connectionError();
                end
                me.gcpOm.step = me.peOm.step;
                me.gcpOm.start();
                me.currentAction.setState('OM GET CONTROL POINTS');
            end
        else
            me.currentAction.setState('OM GET CONTROL POINTS');
        end
    case 'OM GET CONTROL POINTS'
        if me.fakeOm
            me.fakeGcp.generateControlPoints(me.nxtStep.nextStepData);
            me.nxtStep.curStepData = me.nxtStep.nextStepData;
            me.currentAction.setState('NEXT TARGET');
            me.arch.archive(me.nxtStep.curStepData);
            me.dd.update(me.nxtStep.curStepData);
        else
            done = me.gcpOm.isDone();
            if done
                if me.peOm.state.isState('ERRORS EXIST')
                    me.ocOm.connectionError();
                end
                me.nxtStep.curStepData = me.gcpOm.step;
                me.currentAction.setState('PROCESS OM RESPONSE');
                me.arch.archive(me.gcpOm.step);
                me.dd.update(me.gcpOm.step);
                me.pResp.start();
            end
        end
                case 'PROCESS OM RESPONSE'
                    done = me.pResp.isDone();
                    if done
                       me.currentAction.setState('NEXT STEP');                
                    end
                    
    case 'CHECK LIMITS'
        %        me.nxtStep
        done = me.nxtStep.withinLimits();
        me.updateCommandLimits();
        me.updateStepTolerances();
        if done
            me.currentAction.setState('OM PROPOSE EXECUTE');
            if me.fakeOm == 0
                me.peOm.step = me.nxtStep.nextStepData;
                me.peOm.start();
            end
        else
            me.setRunButton(0); % Pause the simulation
            stop(me.simTimer);
        end
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
    end
end