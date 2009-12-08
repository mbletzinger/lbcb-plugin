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
            clone.stepNum = step.StepNum;
            
         end
         function clone = stepNumber2StepData(me,stepNum)
             clone = StepData;
             clone.stepNum = stepNum;
             me.addProtocol(clone);
         end
         function clone = target2StepData(me,targets,step,sub)
             clone = StepData;
             me.addProtocol(clone);
             clone.stepNum = StepNumber(step,sub,0);
             lgth = length(targets);
             for t = 1:lgth
                 clone.lbcbCps{t}.command = targets{t};
             end
             
         end
         function addProtocol(me,step)
             step.mdlLbcb = me.mdlLbcb;
             step.cdp = me.cdp;
             lgth = me.cdp.numLbcbs();
             step.lbcbCps = cell(lgth,1);
             for l = 1 : lgth
                 step.lbcbCps{l} = LbcbControlPoint;
                 step.lbcbCps{l}.response.cdp = me.cdp;
             end
             if me.cdp.numModelCps > 0
                 step.modelCps = cell(me.cdp.numModelCps,1);
                 for m = 1:me.cdp.numModelCps
                     step.modelCps{m} = ModelControlPoint;
                 end
             end
         end
   end
end