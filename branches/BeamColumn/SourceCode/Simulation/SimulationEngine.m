classdef SimulationEngine < handle
    properties
        proposeExecute = {};
        getTarget = {};
        stepReduction = {};
        simState = {};
        edCorrection = {};
        offsets = {};
        network = {};
        startStep = 1;
    end
    methods
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