classdef StepExecute < SimExecute
    properties
        nxtStep = [];
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = Archiver;
        dd = DataDisplay;
        
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
                            me.updateSteps();
                            me.currentAction.setState('CHECK LIMITS');
                        end
                    end
                case 'OM PROPOSE EXECUTE'
                    if me.isFake() == 0
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
                    if me.isFake()
                        me.fakeGcp.generateControlPoints(me.nxtStep.nextStepData);
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    else
                        done = me.gcpOm.isDone();
                        if done
                            if me.peOm.state.isState('ERRORS EXIST')
                                me.ocOm.connectionError();
                            end
                            me.pResp.start();
                        end
                    me.currentAction.setState('PROCESS OM RESPONSE');
                    end
                case 'PROCESS OM RESPONSE'
                    me.dat.shiftSubSteps();
                    done = me.pResp.isDone();
                    me.arch.archive(me.dat.curStepData);
                    me.dd.update(me.dat.curStepData);
                    me.currentAction.setState('BROADCAST TRIGGER');
                case 'BROADCAST TRIGGER'
                    me.currentAction.setState('NEXT STEP');
                    
                case 'CHECK LIMITS'
                    %        me.nxtStep
                    done = me.nxtStep.withinLimits();
                    me.updateCommandLimits();
                    me.updateStepTolerances();
                    if done
                        me.currentAction.setState('OM PROPOSE EXECUTE');
                        if me.isFake() == 0
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
        function yes = isFake(me)
           ocfg = OmConfigDao(me.cfg);
           yes = ocfg.useFakeOm;
        end
    end
end