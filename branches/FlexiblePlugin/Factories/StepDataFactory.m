classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        cfg = [];
    end
    methods
         function clone = clone(step)
            clone = StepData;
            num = StepData.numLbcbs();
            clone.lbcb = cell(num,1);
            for l = 1: num
                clone.lbcb{l} = step.lbcb{l}.clone();
            end
            clone.externalSensorsRaw = step.externalSensorsRaw;
            clone.simstep = step.simstep;
            me.addProtocol(clone);
         end
         function simStep2StepData(simstep)
             clone = StepData;
             clone.simstep = simstep;
             me.addProtocol(clone);
         end
         function target2StepData(targets)
             clone = StepData;
             me.addProtocol(clone);
             lgth = clone.numLbcbs();
             clone.lbcbCps = cell(lgth,1);
             for l = 1 : lgth
                 clone.lbcbCps{l} = LbcbControlPoint;
             end
             lgth = length(targets);
             for t = 1:lgth
                 clone.lbcbCps{t}.command = targets{t};
             end
             
         end
         function addProtocol(step)
             step.mdlLbcb = me.mdlLbcb;
             step.cfg = me.cfg;
         end
   end
end