function startSimulation(me,notimer)
%        me.nxtTgt.start();
        ocfg = OmConfigDao(me.cfg);
        me.fakeOm = ocfg.useFakeOm;
        LbcbStep.setMdlLbcb(SimulationState.getMdlLbcb()); % created when the connection was opened
        if me.currentAction.isState('READY')
            me.log.info(dbstack,'Starting Simulation');
            me.nxtTgt.start();
            me.currentAction.setState('NEXT TARGET');
        end
        if notimer 
            return;
        end
        start(me.simTimer);
end