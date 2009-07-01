classdef GetControlPointsOm < SimulationState
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
            ml = SimulationState.getMdlLbcb();
                        address = LbcbStep.getAddress();
            jmsg = ml.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
            ml.start(jmsg);
            me.state.setState('BUSY');
        end
        function done = isDone(me)
            c = me.cpsMsg.getState();
            done = 0;
            ml = SimulationState.getMdlLbcb();
            if ml.isDone() == 0
                return;
            end
            lgth = length(me.step.lbcb.command);
            switch c
                case 'LBCB1'
                    if lgth == 2
                        me.cpsMsg.setState('LBCB2');
                    else
                        me.cpsMsg.setState('ExternalSensors');
                    end
                    me.step.parseControlPointMsg(ml.response)
                    jmsg = ml.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    ml.start(jmsg);
                    me.state.setState('BUSY');
                case 'LBCB2'
                    me.step.parseControlPointMsg(ml.response)
                    me.cpsMsg.setState('ExternalSensors');
                    jmsg = ml.createCommand('get-control-point',address,me.cpsMsg.getState(),[]);
                    ml.start(jmsg);
                    me.state.setState('BUSY');
                case 'ExternalSensors'
                    me.step.parseControlPointMsg(ml.response)
                    me.cpsMsg.setState('DONE');
                    me.state.setState('READY');
                case 'NONE'
                    done = 1;
            end
        end
    end
end
