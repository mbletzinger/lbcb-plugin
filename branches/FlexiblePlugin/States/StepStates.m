classdef StepStates < SimStates
    properties
        peOm = [];
        pResp = [];
        gcpOm = [];
        fakeGcp = [];
        arch = [];
        brdcstRsp = [];
        gettingInitialPosition;
        doTriggering
        log = Logger('StepStates');
        st
    end
    methods
        function me = StepStates()
            me = me@SimStates();
            me.doTriggering = false;
            me.currentAction = StateEnum({...
                'NEXT STEP',...
                'OM PROPOSE EXECUTE',...
                'OM GET CONTROL POINTS',...
                'PROCESS OM RESPONSE',...
                'BROADCAST TRIGGER',...
                'DONE'
                });
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
            if me.stateChanged()
                me.ddisp.dbgWin.setStepState(me.currentAction.idx);
                me.gui.updateStepState(me.currentAction.idx)
            end
            switch a
                case'NEXT STEP'
                    odone = me.nxtStep.isDone();
                    if odone % Next target is ready
                        if me.nxtStep.stepsCompleted  %  No more targets
                            me.log.info(dbstack,'Substeps are done');
                            me.statusReady();
                            me.currentAction.setState('DONE');                            
                        else % Execute next step
                            me.currentAction.setState('OM PROPOSE EXECUTE');
                            if me.isFake() == false
                                me.peOm.start()
                            end
                            me.gui.updateStepTolerances(me.st);
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
                        me.pResp.start();
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    else
                        odone = me.gcpOm.isDone();
                        if odone
                            if me.gcpOm.hasErrors()
                                me.ocOm.connectionError();
                                me.statusErrored();
                                done = 1;
                                return;
                            end
                            me.pResp.start();
                            me.currentAction.setState('PROCESS OM RESPONSE');
                        end
                    end
                    
                case 'PROCESS OM RESPONSE'
                    me.pResp.isDone();
                    me.arch.archive(me.dat.curStepData);
                    me.gui.ddisp.update();
                    if me.gettingInitialPosition
                        me.currentAction.setState('DONE');
                    elseif me.needsTriggering()
                        me.brdcstRsp.start();
                        me.currentAction.setState('BROADCAST TRIGGER');
                    else
                        me.currentAction.setState('NEXT STEP');
                    end
                    
                case 'BROADCAST TRIGGER'
                    bdone = me.brdcstRsp.isDone();
                    if bdone
                        if me.brdcstRsp.hasErrors()
                            me.gui.colorRunButton('BROKEN'); % Pause the simulation
                            me.statusErrored();
                            me.currentAction.setState('DONE');
                            return;
                        end
                        me.currentAction.setState('NEXT STEP');
                    end
                case 'DONE'
                    me.statusReady();
                    me.gui.updateStepState(me.currentAction.idx)
                    done = 1;
                    me.gui.updateTimer(); %BG
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
            end
        end
        function yes = isFake(me)
            ocfg = OmConfigDao(me.cdp.cfg);
            yes = ocfg.useFakeOm;
        end
        function resetOmStates(me)
            switch me.currentAction.getState()
                case 'OM PROPOSE EXECUTE'
                    me.peOm.statusReady();
                    me.peOm.start();
                case 'OM GET CONTROL POINTS'
                    me.gcpOm.statusReady();
                    me.gcpOm.start();
                otherwise
            end
        end
    end
    methods (Access='private')
        function needsTriggering = needsTriggering(me)
            needsTriggering = false;
            if me.doTriggering == false
                return;
            end
            if isempty(me.dat.curStepData)
                return;
            end
            if me.dat.curStepData.needsTriggering == false
                return;
            end
            needsTriggering = true;
        end
    end
end