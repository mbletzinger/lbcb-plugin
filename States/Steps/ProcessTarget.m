classdef ProcessTarget < Step
    properties
        lc
        accepted;
        autoAccept;
        target;
        log = Logger('ProcessTarget');
    end
    methods
        function me = ProcessTarget()
            me = me@Step();
            me.accepted = false;
            me.autoAccept = false;
            me.currentAction = StateEnum({...
                'CHECK LIMITS',...
                'WAIT FOR ACCEPT',...
                'DONE'
                });
        end
        function start(me)
            me.currentAction.setState('CHECK LIMITS');
            me.statusBusy();
            me.accepted = me.autoAccept;
            me.gui.updateCommandTable();
            me.gui.updateStepsDisplay(me.dat.nextStepData.stepNum);
            me.gui.blinkAcceptButton(~me.accepted);
            me.log.debug(dbstack,sprintf('Current Target: %s',me.dat.nextStepData.toString()));
        end
        function edited(me)
            me.currentAction.setState('CHECK LIMITS');
            me.statusBusy();
            me.accepted = me.autoAccept;
            me.gui.updateCommandTable();
            me.gui.blinkAcceptButton(~me.accepted);
        end
        function done = isDone(me)
            done = 0;
            a = me.currentAction.getState();
            if me.stateChanged()
%                 me.ddisp.dbgWin.setProcessState(me.currentAction.idx);
            end
            switch a
                case 'CHECK LIMITS'
                    within = me.withinLimits();
                    me.gui.updateLimits(me.lc);
                    if within
                        if me.accepted
                            me.currentAction.setState('DONE');
                            me.statusReady();
                        else
                            me.currentAction.setState('WAIT FOR ACCEPT');
                        end
                    else
                        me.statusErrored();
                    end
                case 'WAIT FOR ACCEPT'
                    if me.accepted
                        me.currentAction.setState('CHECK LIMITS');
                        me.gui.blinkAcceptButton(~me.accepted);
                    end
                case 'DONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
        function yes = withinLimits(me)
            yes = me.lc.withinLimits(me.dat.nextStepData,me.dat.curStepData);
        end
        
    end
end