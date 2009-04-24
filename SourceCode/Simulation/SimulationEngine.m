classdef SimulationEngine < handle
    properties
        network = {};
        simState = {};
        stepReduction = cell(2,1);
        transform = cell(2,1);
        edCorrection = cell(2,1);
        getTarget = {};
        proposeExecute = {};
        startStep = 1;
        offsets = cell(2,1);
    end
    methods
        function me = SimulationEngine()
            me.simState = SimulationState();
            me.network = NetworkSettings();
            me.stepReduction{1} = StepReduction();
            me.stepReduction{2} = StepReduction();
            me.transform = CreateTransforms();
            me.edCorrections{1} = ElasticDeformationCorrections(me.transforms{1});
            me.edCorrections{2} = ElasticDeformationCorrections(me.transforms{2});
        end

        function connect(me)
                        me.getTarget = GetTargetStateMachine(me.network.factory,me.network.simcorLink);
                        me.proposeExecute = ProposeExecute(me.network.factory,me.network.lbcbLink);
        end
        function start(me)
            me.simState.setState('Starting Simulation');
        end
        function execute(me)
            switch me.simState.getState()
                case 'Starting Simulation'
                    me.simState.start(me.startStep());
                case 'Getting Target'
                case 'Running Ramp'
                case 'Triggering DAQ Devices'
                case 'Sending Response'
                case 'Done'
            end
        end
    end
end