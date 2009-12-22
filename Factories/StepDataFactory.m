classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        cdp = [];
        m2d = Msg2DofData();
    end
    methods
         function clone = newStep(me)
            clone = StepData;
            me.addProtocol(clone);
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
         function clone = uisimcorMsg2Step(me,cmd)
             clone = StepData;
             me.addProtocol(clone);
             [addresses, contents] = cmd.getContents();
             if iscell(addresses)
                 for a = 1 : length(addresses)
                    target = me.m2d.parse(contents{a},addresses{a});
                    for t = 1 : 6
                    end
                 end
             else
                target = me.m2d.parse(contents,addresses);             
             end
            me.command = targets{1};
            me.address = address;

         end
         function addProtocol(me,step)
             step.mdlLbcb = me.mdlLbcb;
             step.cdp = me.cdp;
             lgth = me.cdp.numLbcbs();
             step.lbcbCps = cell(lgth,1);
             for l = 1 : lgth
                 step.lbcbCps{l} = LbcbControlPoint;
                 step.lbcbCps{l}.response.cdp = me.cdp;
                 step.lbcbCps{l}.command.cdp = me.cdp;
             end
             if me.cdp.numModelCps > 0
                 step.modelCps = cell(me.cdp.numModelCps,1);
                 for m = 1:me.cdp.numModelCps
                     step.modelCps{m} = ModelControlPoint;
                     step.modelCps{m}.response.cdp = me.cdp;
                     step.modelCps{m}.command.cdp = me.cdp;
                 end
             end
         end
   end
end