classdef GetInitialPosition < OmState
    properties
        prevCps
        log = Logger('GetInitialPosition');
        
    end
    methods
        function me = GetInitialPosition()
            me = me@OmState();
            me.prevCps = 0;
            me.currentAction = StateEnum({...
                'LBCB1',...
                'LBCB2',...
                'DONE',...
                });
        end
        function start(me)
            me.currentAction.setState('LBCB1');
            address = me.cdp.getAddress();
            jmsg = me.mdlLbcb.createCommand('get-parameter',address,me.currentAction.getState(),'initial position');
            me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
            me.statusBusy();
        end
        function done = isDone(me)
            c = me.currentAction.getState();
            me.stateChanged();
            done = 0;
            address = me.cdp.getAddress();
            if me.mdlLbcb.isDone() == 0
                return;
            end
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                me.statusErrored();
                me.log.error(dbstack,'OM Link has errored out');
                me.currentAction.setState('DONE');
                done = 1;
                return;
            end
            
            lgth = me.cdp.numLbcbs();
            switch c
                case 'LBCB1'
                    if lgth == 2
                         me.currentAction.setState('LBCB2');
                    else
                        me.currentAction.setState('ExternalSensors');
                    end
                    goodMsg = me.dat.curStepData.parseOmGetInitialPositionMsg(me.mdlLbcb.response);
                    if goodMsg == false
                        me.statusErrored();
                        me.log.error(dbstack,sprintf('Bad msg received from OM [%s]',...
                            char(me.mdlLbcb.response.toString)));
                        me.currentAction.setState('DONE');
                        done = 1;
                        return;
                    end
                    jmsg = me.mdlLbcb.createCommand('get-parameter',address,me.currentAction.getState(),'initial position');
                    me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
                    me.statusBusy();
                    
                case 'LBCB2'
                    goodMsg = me.dat.curStepData.parseOmGetInitialPositionMsg(me.mdlLbcb.response);
                    if goodMsg == false
                        me.statusErrored();
                        me.log.error(dbstack,sprintf('Bad msg received from OM [%s]',...
                            char(me.mdlLbcb.response.toString)));
                        done = 1;
                        me.currentAction.setState('DONE');
                        return;
                    end
                    me.currentAction.setState('DONE');
                    me.statusReady();
                case 'DONE'
                    done = 1;
            end
        end
    end
end
