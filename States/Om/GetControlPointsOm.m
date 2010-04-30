classdef GetControlPointsOm < OmState
    properties
        cpsMsg = StateEnum({...
            'LBCB1',...
            'LBCB2',...
            'ExternalSensors',...
            'DONE',...
            });
        prevCps
        log = Logger('GetControlPointsOm');
        
    end
    methods
        function me = GetControlPointsOm()
            me = me@OmState();
            me.prevCps = 0;
        end
        function start(me)
            me.cpsMsg.setState('LBCB1');
            address = me.cdp.getAddress();
            jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
            me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
            me.statusBusy();
        end
        function done = isDone(me)
            c = me.cpsMsg.getState();
            if me.cpsMsg.idx ~= me.prevCps
                me.log.debug(dbstack,sprintf('Executing CPS %s',c));
                me.prevCps = me.cpsMsg.idx;
            end
            done = 0;
            address = me.cdp.getAddress();
            if me.mdlLbcb.isDone() == 0
                return;
            end
            if me.mdlLbcb.state.isState('ERRORS EXIST')
                me.statusErrored();
                me.log.error(dbstack,'OM Link has errored out');
                me.cpsMsg.setState('DONE');
                done = 1;
                return;
            end
            
            lgth = me.cdp.numLbcbs();
            switch c
                case 'LBCB1'
                    if lgth == 2
                        me.cpsMsg.setState('LBCB2');
                    else
                        me.cpsMsg.setState('ExternalSensors');
                    end
                    goodMsg = me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response);
                    if goodMsg == false
                        me.statusErrored();
                        me.log.error(dbstack,sprintf('Bad msg received from OM [%s]',...
                            char(me.mdlLbcb.response.toString)));
                        me.cpsMsg.setState('DONE');
                        done = 1;
                        return;
                    end
                    jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
                    me.statusBusy();
                    
                case 'LBCB2'
                    goodMsg = me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response);
                    if goodMsg == false
                        me.statusErrored();
                        me.log.error(dbstack,sprintf('Bad msg received from OM [%s]',...
                            char(me.mdlLbcb.response.toString)));
                        done = 1;
                        me.cpsMsg.setState('DONE');
                        return;
                    end
                    me.cpsMsg.setState('ExternalSensors');
                    jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
                    me.statusBusy();
                    
                case 'ExternalSensors'
                    goodMsg = me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response);
                    if goodMsg == false
                        me.statusErrored();
                        me.log.error(dbstack,sprintf('Bad msg received from OM [%s]',...
                            char(me.mdlLbcb.response.toString)));
                        done = 1;
                        me.cpsMsg.setState('DONE');
                        return;
                    end
                    me.cpsMsg.setState('DONE');
                    me.statusReady();
                case 'DONE'
                    done = 1;
            end
        end
    end
end
