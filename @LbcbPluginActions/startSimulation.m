function startSimulation(me,notimer)
%        me.nxtTgt.start();
        ocfg = OmConfigDao(me.cfg);
        me.fakeOm = ocfg.useFakeOm;
        mdll = SimulationState.getMdlLbcb(); % created when the connection was opened
        if me.fakeOm == 0
            if isempty(mdll)
                me.log.error(dbstack,'Operation Manager is not connected');
                return;
            end
            StepData.setMdlLbcb(mdll); % created when the connection was opened
        end
        if me.currentAction.isState('READY')
            me.log.info(dbstack,'Starting Simulation');
            me.nxtTgt.start();
            me.currentAction.setState('NEXT TARGET');
        end
        me.arch = Archiver();
        if notimer 
            return;
        end
        start(me.simTimer);
end