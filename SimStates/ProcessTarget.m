classdef ProcessTarget < SimStates
    properties
        currentAction = StateEnum({...
            'CHECK LIMITS',...
            'WAIT FOR ACCEPT',...
            'LIMIT FAULTS EXIST',...
            'DONE'
            });
        lc
        accepted;
        autoAccept;
        target;
        log = Logger('ProcessTarget');
    end
    methods
        function me = ProcessTarget()
            me.accepted = false;
            me.autoAccept = false;
        end
        function start(me,target)
            me.target = target;
            me.currentAction.setState('CHECK LIMITS');
            me.statusBusy();
            me.accepted = me.autoAccept;
            me.gui.blinkAcceptButton(~me.accepted);
            me.log.debug(dbstack,sprintf('Current Target: %s',target.toString()));
        end
        function edited(me)
            me.currentAction.setState('CHECK LIMITS');
            me.statusBusy();
            me.accepted = me.autoAccept;
            me.gui.blinkAcceptButton(~me.accepted);
        end
        function done = isDone(me)
            done = 0;
            me.log.debug(dbstack,sprintf('Executing %s',me.currentAction.getState()));
            switch me.currentAction.getState()
                case 'CHECK LIMITS'
                    within = me.withinLimits();
                    me.gui.updateLimits(me.lc);
                    if within
                        if me.accepted
                            me.dat.targetShift(me.target);
                            me.currentAction.setState('DONE');
                            me.statusReady();
                        else
                            me.currentAction.setState('WAIT FOR ACCEPT');
                        end
                    else
                        me.currentAction.setState('LIMIT FAULTS EXIST');
                        me.statusErrored();
                    end
                case 'WAIT FOR ACCEPT'
                    if me.accepted
                        me.currentAction.setState('CHECK LIMITS');
                        me.gui.blinkAcceptButton(~me.accepted);
                    end
                case 'LIMIT FAULTS EXIST'
                        me.currentAction.setState('CHECK LIMITS');
                case 'DONE'
                    done = 1;
                otherwise
                    me.log.error(dbstack,sprintf('%s action not recognized',action));
            end
        end
        function yes = withinLimits(me)
            yes = me.lc.withinLimits(me.target,me.dat.curTarget );
        end
        
    end
end