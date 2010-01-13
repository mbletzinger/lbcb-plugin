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
            lgth = me.cdp.numLbcbs();
            if lgth > 1
                clone.lbcbCps{1}.command = targets{1};
                clone.lbcbCps{2}.command = targets{2};
            else
                clone.lbcbCps{1}.command = targets{1};
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
                        if(target.dispDofs(t))
                            clone.modelCps{a}.command.setDispDof(t,target.disp(t));
                        end
                        if(target.forceDofs(t))
                            clone.modelCps{a}.command.setForceDof(t,target.force(t));
                        end
                    end
                    clone.modelCps{a}.address = addresses{a};
                end
            else
                target = me.m2d.parse(contents,addresses);
                for t = 1 : 6
                    if(target.dispDofs(t))
                        clone.modelCps{1}.command.setDispDof(t,target.disp(t));
                    end
                    if(target.forceDofs(t))
                        clone.modelCps{1}.command.setForceDof(t,target.force(t));
                    end
                end
                clone.modelCps{1}.address = addresses;
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
                %                 step.lbcbCps{l}.command.cdp = me.cdp;
            end
            if me.cdp.numModelCps > 0
                step.modelCps = cell(me.cdp.numModelCps,1);
                for m = 1:me.cdp.numModelCps
                    step.modelCps{m} = ModelControlPoint;
                    %                    step.modelCps{m}.response.cdp = me.cdp;
                    %                    step.modelCps{m}.command.cdp = me.cdp;
                end
            end
        end
    end
end