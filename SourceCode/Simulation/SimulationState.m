classdef SimulationState < handle
    properties
        step = 0;
        subStep = 0;
        startTime = clock;
        state = StateEnum({...
            'Starting Simulation',...
            'Getting Target',...
            'Running Ramp',...
            'Triggering DAQ Devices',...
            'Sending Response',...
            'Done'...
            });
        rampState = StateEnum({...
            'Getting Target',...
            'Calculate ED Adjustment to Target',...
            'Propose and Execute Steps',...
            'Sending ED Target Corrections to LBCBs',...
            'Done'...
            });
        proposeExecuteState = StateEnum({...
            'Check Limits',...
            'Send Target to LBCBs',...
            'Triggering DAQ Devices',...
            'Done'...
            });
    end
    methods
        function start(me,startStep)
            me.startTime = clock;
            me.step = startStep;
        end
        function next(me,useSubStep)
            if(useSubStep)
                me.subStep = me.subStep + 1;
                return;
            end
                me.step = me.step + 1;
                me.subStep = 1;
        end
        function et = getElapsedTime(me)
            et = clock - me.startTime;
        end
    end
end