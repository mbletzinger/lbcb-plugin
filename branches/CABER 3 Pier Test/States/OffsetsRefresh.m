classdef OffsetsRefresh < SimStates
    properties
        pResp = [];
        gcpOm = [];
        gipOm = [];
        log = Logger('OffsetsRefresh');
    end
    methods
        function me = OffsetsRefresh()
            me = me@SimStates();
            me.currentAction = StateEnum({...
                'OM GET INITIAL POSITION',...
                'OM GET CONTROL POINTS',...
                'PROCESS OM RESPONSE',...
                'DONE'
                });
        end
        function start(me)
            if me.cdp.numLbcbs() == 2
                tgts = { Target Target };
            else
                tgts = { Target };
            end
            me.dat.curStepData = me.sdf.target2StepData(tgts,0,0);
            me.dat.curStepData.isInitialPosition = true;
            me.gipOm.start();
            me.currentAction.setState('OM GET INITIAL POSITION');
            me.statusBusy();
        end
        function done = isDone(me)
            done = 0;
            a = me.currentAction.getState();
            if me.stateChanged()
                if isempty(me.gui) == false
                    me.gui.updateStepState(me.currentAction.idx)
                end
            end
            switch a
                case 'OM GET INITIAL POSITION'
                    odone = me.gipOm.isDone();
                    if odone
                        if me.gipOm.hasErrors()
                            me.ocOm.connectionError();
                            me.statusErrored();
                            done = 1;
                            return;
                        end
                        me.gcpOm.start();
                        me.currentAction.setState('OM GET CONTROL POINTS');
                    end
                case 'OM GET CONTROL POINTS'
                    odone = me.gcpOm.isDone();
                    if odone
                        if me.gcpOm.hasErrors()
                            me.ocOm.connectionError();
                            me.statusErrored();
                            done = 1;
                            return;
                        end
                        me.dat.initialPosition2Target();
                        me.pResp.start();
                        me.currentAction.setState('PROCESS OM RESPONSE');
                    end
                    
                case 'PROCESS OM RESPONSE'
                    me.pResp.isDone();
                    me.log.debug(dbstack,sprintf('Current Response: %s', ...
                        me.dat.curStepData.toString()));
                    me.dat.initialPosition2Target();
                    me.currentAction.setState('DONE');
                case 'DONE'
                    me.statusReady();
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',me.currentAction.getState()));
            end
        end
    end
end