classdef GetControlPoints < SimulationState
    properties
        cpsMsg = StateEnum({...
            'LBCB1',...
            'LBCB2',...
            'ExternalSensors',...
            'DONE',...
            });
        
    end
    methods
        function me = GetControlPoints(step)
            me.step = step;
        end
        function start(me)
            me.cpsMsg.setState('LBCB1');
            jmsg = getMdlLbcb().createCommand('get-control-point',...
                me.step.lbcb.command(1).node,me.cpsMsg.getState(),[]);
            getMdlLbcb().start(jmsg);
            me.state.setState('BUSY');
        end
        function done = isDone(me)
            c = me.cpsMsg.getState();
            done = 0;
            if getMdlLbcb().isDone() == 0
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
                    me.step.parseControlPointMsg(getMdlLbcb().response)
                    jmsg = getMdlLbcb().createCommand('get-control-point',...
                        me.step.lbcb.command(1).node,me.cpsMsg.getState(),[]);
                    getMdlLbcb().start(jmsg);
                    me.state.setState('BUSY');
                case 'LBCB2'
                    me.cpsMsg.setState('ExternalSensors');
                    jmsg = getMdlLbcb().createCommand('get-control-point',...
                        me.step.lbcb.command(1).node,me.cpsMsg.getState(),[]);
                    getMdlLbcb().start(jmsg);
                    me.state.setState('BUSY');
                case 'ExternalSensors'
                    me.cpsMsg.setState('DONE');
                    me.state.setState('READY');
                case 'NONE'
                    done = 1;
            end
        end
    end
end
