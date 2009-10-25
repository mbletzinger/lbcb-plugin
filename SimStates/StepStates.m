classdef StepStates < SimStates
    properties
        nxtStep = [];
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = [];
        dd = DataDisplay;
        
        currentAction = StateEnum({...
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
    end
    methods
        function start(me,steps)
            me.nxtStep.steps = steps;
            me.currentAction.setState('NEXT STEP');
            me.state.setState('BUSY');
        end
        function done = isDone(me)
            done = 0;
            me.log.debug(dbstack,sprintf('Executing %s',me.currentAction.getState()));
            switch me.currentAction.getState()
                case'NEXT STEP'
                    odone = me.nxtStep.isDone();
                    if odone % Next target is ready
                        if me.nxtStep.simCompleted  %  No more targets
                            me.log.info(dbstack,'Steps are done');
                            me.state.setState('COMPLETED');
                            me.currentAction.setState('DONE');
                            done = 1;
                        else % Execute next step
                            me.log.debug(dbstack,sprintf('Next Step is %s',me.dat.nextStepData.toString()));
                            me.currentAction.setState('CHECK LIMITS');
                        end
                    end
                case 'OM PROPOSE EXECUTE'
                    if me.isFake() == 0
                        odone = me.peOm.isDone();
                        if odone % execute response has been received from OM
                            if me.peOm.state.isState('ERRORS EXIST')
                                me.ocOm.connectionError();
                                me.state.setState('ERRORS EXIST');
                                me.currentAction.setState('DONE');
                                done = 1;
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
                        me.fakeGcp.generateControlPoints(me.dat.nextStepData);
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    else
                        odone = me.gcpOm.isDone();
                        if odone
                            if me.peOm.state.isState('ERRORS EXIST')
                                me.ocOm.connectionError();
                                me.state.setState('ERRORS EXIST');
                                me.currentAction.setState('DONE');
                                done = 1;
                            end
                            me.pResp.start();
                        end
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    end
                case 'PROCESS OM RESPONSE'
                    me.dat.stepShift();
                    me.pResp.start();
                    me.arch.archive(me.dat.curStepData);
                    me.dd.update(me.dat.curStepData);
                    me.currentAction.setState('BROADCAST TRIGGER');
                case 'BROADCAST TRIGGER'
                    me.currentAction.setState('NEXT STEP');
                    
                case 'CHECK LIMITS'
                    %        me.nxtStep
                    odone = me.nxtStep.withinLimits();
                    me.gui.updateCommandLimits(me.nxtStep.lc);
                    me.gui.updateStepTolerances(me.nxtStep.st);
                    if odone
                        me.currentAction.setState('OM PROPOSE EXECUTE');
                        if me.isFake() == 0
                            me.peOm.start();
                        end
                    else
                        me.state.setState('ERRORS EXIST');
                        done = 1;
                    end
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
        function yes = isFake(me)
            ocfg = OmConfigDao(me.cdp.cfg);
            yes = ocfg.useFakeOm;
        end
    end
end