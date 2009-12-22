classdef StepStates < SimStates
    properties
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = [];
        gettingInitialPosition;
        currentAction = StateEnum({...
            'NEXT STEP',...
            'OM PROPOSE EXECUTE',...
            'OM GET CONTROL POINTS',...
            'PROCESS OM RESPONSE',...
            'BROADCAST TRIGGER',...
            'DONE'
            });
        prevAction
        log = Logger('StepStates');
    end
    methods
        function me = StepStates()
            me.prevAction = 0;
        end
        function start(me,steps)
            me.nxtStep.steps = steps;
            me.nxtStep.stepsCompleted = false;
            me.gettingInitialPosition = false;
            me.currentAction.setState('NEXT STEP');
            me.statusBusy();
        end
        function getInitialPosition(me)
            me.gettingInitialPosition = true;
            if me.cdp.numLbcbs() == 2
                tgts = { Target Target };
            else
                tgts = { Target };
            end
            me.dat.curStepData = me.sdf.target2StepData(tgts,0,0);
            if me.isFake == false
                me.gcpOm.start();
            end
            me.currentAction.setState('OM GET CONTROL POINTS');
            me.statusBusy();
        end
        function done = isDone(me)
            done = 0;
            a = me.currentAction.getState();
            if me.currentAction.idx ~= me.prevAction
                me.log.debug(dbstack,sprintf('Executing action %s',a));
                me.prevAction = me.currentAction.idx;
                me.ddisp.dbgWin.setStepState(me.currentAction.idx);
            end
            switch me.currentAction.getState()
                case'NEXT STEP'
                    odone = me.nxtStep.isDone();
                    if odone % Next target is ready
                        if me.nxtStep.stepsCompleted  %  No more targets
                            me.log.info(dbstack,'Substeps are done');
                            me.statusReady();
                            me.currentAction.setState('DONE');
                            done = 1;
                        else % Execute next step
                            me.log.debug(dbstack,sprintf('Next Step is %s',me.dat.nextStepData.toString()));
                            me.currentAction.setState('OM PROPOSE EXECUTE');
                            if me.isFake() == false
                                me.peOm.start()
                            end
                            me.gui.updateStepTolerances(me.nxtStep.st);
                            me.gui.updateCommandTable();
                            me.gui.updateStepsDisplay(me.dat.nextStepData.stepNum);
                        end
                    end
                case 'OM PROPOSE EXECUTE'
                    if me.isFake()
                        me.dat.stepShift();
                        me.currentAction.setState('OM GET CONTROL POINTS');
                    else
                        odone = me.peOm.isDone();
                        if odone % execute response has been received from OM
                            if me.peOm.hasErrors()
                                me.ocOm.connectionError();
                                me.statusErrored();
                                me.currentAction.setState('DONE');
                                done = 1;
                                return;
                            end
                            me.dat.stepShift();
                            me.gcpOm.start();
                            me.currentAction.setState('OM GET CONTROL POINTS');
                        end
                    end
                case 'OM GET CONTROL POINTS'
                    
                    if me.isFake()
                        me.fakeGcp.generateControlPoints();
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    else
                        odone = me.gcpOm.isDone();
                        if odone
                            if me.peOm.hasErrors()
                                me.ocOm.connectionError();
                                me.statusErrored();
                                me.currentAction.setState('DONE');
                                done = 1;
                                return;
                            end
                            me.pResp.start();
                            me.currentAction.setState('PROCESS OM RESPONSE');
                        end
                    end
                    
                case 'PROCESS OM RESPONSE'
                    me.arch.archive(me.dat.curStepData);
                    me.gui.ddisp.update();
                    me.currentAction.setState('BROADCAST TRIGGER');
                    
                case 'BROADCAST TRIGGER'
                    if me.gettingInitialPosition
                        me.currentAction.setState('DONE');
                    else
                        me.currentAction.setState('NEXT STEP');
                    end
                case 'DONE'
                    me.statusReady();
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