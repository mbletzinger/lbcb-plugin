classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        cdp = [];
    end
    methods
         function clone = clone(me,step)
            clone = StepData;
            num = StepData.numLbcbs();
            clone.lbcb = cell(num,1);
            for l = 1: num
                clone.lbcb{l} = step.lbcb{l}.clone();
            end
            clone.externalSensorsRaw = step.externalSensorsRaw;
            clone.StepNumber = step.StepNumber;
            me.addProtocol(clone);
         end
         function clone = StepNumber2StepData(me,StepNumber)
             clone = StepData;
             clone.StepNumber = StepNumber;
             me.addProtocol(clone);
         end
         function clone = target2StepData(me,targets)
             clone = StepData;
             me.addProtocol(clone);
             lgth = clone.cdp.numLbcbs();
             clone.lbcbCps = cell(lgth,1);
             for l = 1 : lgth
                 clone.lbcbCps{l} = LbcbControlPoint;
             end
             lgth = length(targets);
             for t = 1:lgth
                 clone.lbcbCps{t}.command = targets{t};
             end
             
         end
         function addProtocol(me,step)
             step.mdlLbcb = me.mdlLbcb;
             step.cdp = me.cdp;
         end
   end
end