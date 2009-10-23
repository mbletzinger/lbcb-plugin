classdef GetControlPointsOm < SimState
    properties
        cpsMsg = StateEnum({...
            'LBCB1',...
            'LBCB2',...
            'ExternalSensors',...
            'DONE',...
            });
        
    end
    methods
        function start(me)
            me.cpsMsg.setState('LBCB1');
            address = me.getAddress();
            jmsg = me.mlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
            me.mlLbcb.start(jmsg,me.dat.nextStep.simstep,0);
            me.state.setState('BUSY');
        end
        function done = isDone(me)
            c = me.cpsMsg.getState();
            done = 0;
            address = me.getAddress();
            if me.mlLbcb.isDone() == 0
                return;
            end
            me.state.setState(me.mlLbcb.state.getState);
            if me.state.isState('ERRORS EXIST')
                done = 1;
                return;
            end

            lgth = me.numLbcbs();
            switch c
                case 'LBCB1'
                    if lgth == 2
                        me.cpsMsg.setState('LBCB2');
                    else
                        me.cpsMsg.setState('ExternalSensors');
                    end
                    me.dat.nextStep.parseControlPointMsg(me.mlLbcb.response)
                    jmsg = me.mlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mlLbcb.start(jmsg,me.dat.nextStep.simstep,0);
                    me.state.setState('BUSY');
                case 'LBCB2'
                    me.dat.nextStep.parseControlPointMsg(me.mlLbcb.response)
                    me.cpsMsg.setState('ExternalSensors');
                    jmsg = me.mlLbcb.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    me.mlLbcb.start(jmsg,me.dat.nextStep.simstep,0);
                    me.state.setState('BUSY');
                case 'ExternalSensors'
                    me.dat.nextStep.parseControlPointMsg(me.mlLbcb.response)
                    me.cpsMsg.setState('DONE');
                    me.state.setState('READY');
                case 'DONE'
                    done = 1;
            end
        end
    end
end
