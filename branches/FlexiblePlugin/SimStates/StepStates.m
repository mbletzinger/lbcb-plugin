classdef StepStates < SimStates
    properties
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = [];
        dd = DataDisplay;
        gettingInitialPosition;
        currentAction = StateEnum({...
            'NEXT STEP',...
            'OM PROPOSE EXECUTE',...
            'OM GET CONTROL POINTS',...
            'PROCESS OM RESPONSE',...
            'BROADCAST TRIGGER',...
            'DONE'
            });
    end
    methods
        function start(me,steps)
            me.nxtStep.steps = steps;
            me.nxtStep.stepsCompleted = false;
            me.gettingInitialPosition = false;
            me.currentAction.setState('NEXT STEP');
            me.state.setState('BUSY');
        end
        function getInitialPosition(me)
            me.gettingInitialPosition = true;
            me.currentAction.setState('OM GET CONTROL POINTS');
            me.state.setState('BUSY');
        end
        function done = isDone(me)
            done = 0;
            me.log.debug(dbstack,sprintf('Executing %s',me.currentAction.getState()));
            switch me.currentAction.getState()
                case'NEXT STEP'
                    odone = me.nxtStep.isDone();
                    if odone % Next target is ready
                        if me.nxtStep.stepsCompleted  %  No more targets
                            me.log.info(dbstack,'Steps are done');
                            me.state.setState('COMPLETED');
                            me.currentAction.setState('DONE');
                            done = 1;
                        else % Execute next step
                            me.log.debug(dbstack,sprintf('Next Step is %s',me.dat.nextStepData.toString()));
                            me.currentAction.setState('OM PROPOSE EXECUTE');
                            me.gui.updateStepTolerances(me.nxtStep.st);
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
                            me.gcpOm.start();
                            me.currentAction.setState('OM GET CONTROL POINTS');
                        end
                    else
                        me.currentAction.setState('OM GET CONTROL POINTS');
                    end
                case 'OM GET CONTROL POINTS'
                    if me.gettingInitialPosition
                        if me.cdp.numLbcbs() == 2
                            tgts = { Target Target };
                        else
                            tgts = { Target };
                        end
                        me.dat.curStepData = me.sdf.target2StepData(tgts,0,0);
                    else
                        me.dat.stepShift();
                    end
                    
                    if me.isFake()
                        me.fakeGcp.generateControlPoints();
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
                    me.pResp.start();
                    me.arch.archive(me.dat.curStepData);
                    me.dd.update(me.dat.curStepData);
                    me.currentAction.setState('BROADCAST TRIGGER');
                    
                case 'BROADCAST TRIGGER'
                    if me.gettingInitialPosition
                        me.currentAction.setState('DONE');
                    else
                        me.currentAction.setState('NEXT STEP');
                    end
                case 'DONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
            end
        end
        function yes = isFake(me)
            ocfg = OmConfigDao(me.cdp.cfg);
            yes = ocfg.useFakeOm;
        end
    end
end