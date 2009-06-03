classdef OneTargetActions < handle
    properties
        mdlLbcb = {};
        executeTarget = {};
        lbcb1Table = {};
        lbcb2Table = {};
        cfg = {};
        targets = {};
        simstate = SimulationState;
        actions = StateEnum({...
            'DONE',...
            'CONNECT OM',...
            'DISCONNECT OM',...
            'EXECUTE TARGET',...
            });
        state = StateEnum({...
            'READY',...
            'BUSY',...
            'DONE',...
            });

    end
    methods
        function me = OneTargetActions(cfg)
            me.cfg = cfg;
        end
        function setAction(me, a)
            if me.action.isState('DONE')
                me.action.setState(a);
            end
        end
        function done = execute(me)
        end
    end
    methods (Access=private)
        function executeConnectOm(me)
            s = me.state.getState();
            switch s
                case 'READY'
                    ncfg = NetworkConfigDao(me.cfg);
                    me.mdlLbcb = MdlLbcb(ncfg.omHost, ncfg.omPort, ncfg.timeout, me.simstate);
                    ocfg = OmConfigDao(me.cfg);
                    me.executeTarget = ExecuteTarget(me.mdlLbcb,ocfg.numLbcbs);
                    me.mdlLbcb.open();
                case 'BUSY'
                    if me.mdlLbcb.isDone()
                        me.state.setState('DONE');
                    end
                case 'DONE'
                    me.actions.setState('DONE');
                    me.state.setState('READY');
                otherwise
                    str = sprintf('%s not recognized',s);
                    disp(str);
            end
        end
        function executeDisconnectOm(me)
            s = me.state.getState();
            switch s
                case 'READY'
                    me.mdlLbcb.close();
                case 'BUSY'
                    if me.mdlLbcb.isDone()
                        me.state.setState('DONE');
                    end
                case 'DONE'
                    me.actions.setState('DONE');
                    me.state.setState('READY');
                otherwise
                    str = sprintf('%s not recognized',s);
                    disp(str);
            end
        end
        function executeExecuteTarget(me)
            s = me.state.getState();
            switch s
                case 'READY'
                    me.simstate.next(0);
                    me.executeTarget.execute(me.targets);
                case 'BUSY'
                    if me.executeTarget.isDone()
                        me.state.setState('DONE');
                    end
                case 'DONE'
                    me.updateTables();
                    me.actions.setState('DONE');
                    me.state.setState('READY');
                otherwise
                    str = sprintf('%s not recognized',s);
                    disp(str);
            end
        end
        function updateTables(me)
            lbcb1 = me.executeTarget.readings{1};
            lbcb2 = me.executeTarget.readings{2};
            step = me.simstate.step;
            me.lbcb1Table{step} = { step,lbcb1.lbcb.disp(1),lbcb1.lbcb.disp(2),lbcb1.lbcb.disp(3),...
                lbcb1.lbcb.disp(4),lbcb1.lbcb.disp(5),lbcb1.lbcb.disp(6),...
                lbcb1.lbcb.force(1),lbcb1.lbcb.force(2),lbcb1.lbcb.force(3),...
                lbcb1.lbcb.force(4),lbcb1.lbcb.force(5),lbcb1.lbcb.force(6)};
            me.lbcb2Table{step} = { step,lbcb2.lbcb.disp(1),lbcb2.lbcb.disp(2),lbcb2.lbcb.disp(3),...
                lbcb2.lbcb.disp(4),lbcb2.lbcb.disp(5),lbcb2.lbcb.disp(6),...
                lbcb2.lbcb.force(1),lbcb2.lbcb.force(2),lbcb2.lbcb.force(3),...
                lbcb2.lbcb.force(4),lbcb2.lbcb.force(5),lbcb2.lbcb.force(6)};
        end
    end
end