function startSimulation(me,notimer)
        me.nxtTgt.start();
        ocfg = OmConfigDao(me.cfg);
        me.fakeOm = ocfg.useFakeOm;
        me.currentAction.setState('NEXT TARGET');
        if notimer 
            return;
        end
        start(me.simTimer);
end