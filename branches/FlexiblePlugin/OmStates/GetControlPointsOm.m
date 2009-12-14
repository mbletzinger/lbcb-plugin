classdef GetControlPointsOm < OmState
    properties
        cpsMsg = StateEnum({...
            'LBCB1',...
            'LBCB2',...
            'ExternalSensors',...
            'DONE',...
            });
        log = Logger('GetControlPointsOm');
        
    end
    methods
        function start(me)
            me.cpsMsg.setState('LBCB1');
            address = me.cdp.getAddress();
            jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
            me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
            me.statusBusy();
        end
        function done = isDone(me)
            c = me.cpsMsg.getState();
            done = 0;
            address = me.cdp.getAddress();
            if me.mdlLbcb.isDone() == 0
                return;
            end
            me.state.setState(me.mdlLbcb.state.getState);
            if me.state.isState('ERRORS EXIST')
                me.statusErrored();
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
                    me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response)
                    jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
                    me.statusBusy();

                case 'LBCB2'
                    me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response)
                    me.cpsMsg.setState('ExternalSensors');
                    jmsg = me.mdlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mdlLbcb.start(jmsg,me.dat.curStepData.stepNum,0);
                    me.statusBusy();

                case 'ExternalSensors'
                    me.dat.curStepData.parseOmControlPointMsg(me.mdlLbcb.response)
                    me.cpsMsg.setState('DONE');
                    me.statusReady();
                case 'DONE'
                    done = 1;
            end
        end
    end
end
