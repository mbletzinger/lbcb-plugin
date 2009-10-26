classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        cdp = [];
    end
    methods
         function clone = clone(me,step)
            clone = StepData;
            num = StepData.numLbcbs();
            me.addProtocol(clone);
            for l = 1: num
                clone.lbcbCps{l} = step.lbcbCps{l}.clone();
            end
            clone.externalSensorsRaw = step.externalSensorsRaw;
            clone.StepNumber = step.StepNumber;
            
         end
         function clone = StepNumber2StepData(me,stepNum)
             clone = StepData;
             clone.StepNumber = stepNum;
             me.addProtocol(clone);
         end
         function clone = target2StepData(me,targets)
             clone = StepData;
             me.addProtocol(clone);
             lgth = length(targets);
             for t = 1:lgth
                 clone.lbcbCps{t}.command = targets{t};
             end
             
         end
         function addProtocol(me,step)
             step.mdlLbcb = me.mdlLbcb;
             step.cdp = me.cdp;
             lgth = me.cdp.numLbcbs();
             for l = 1 : lgth
                 step.lbcbCps{l} = LbcbControlPoint;
                 step.lbcbCps{l}.response.cdp = me.cdp;
             end
         end
   end
end