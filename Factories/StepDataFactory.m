classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        mdlUiSimCor
        cdp = [];
        m2d = Msg2DofData();
        tgtNumber;
    end
    methods
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
                clone.lbcbCps{1}.command = targets{1}.clone();
                clone.lbcbCps{2}.command = targets{2}.clone();
            else
                clone.lbcbCps{1}.command = targets{1}.clone();
            end
        end
        function clone = uisimcorMsg2Step(me,cmd)
            clone = StepData;
            me.addProtocol(clone);
            clone.stepNum = StepNumber(me.nextTgtNumber(),0,0);
            [addresses, contents] = cmd.getContents();
            if iscell(addresses)
                for a = 1 : length(addresses)
                    addr = char(addresses{a}.toString());
                    target = me.m2d.parse(contents{a},addr);
                    for t = 1 : 6
                        if(target{1}.dispDofs(t))
                            clone.modelCps{a}.command.setDispDof(t,target{1}.disp(t));
                        end
                        if(target{1}.forceDofs(t))
                            clone.modelCps{a}.command.setForceDof(t,target{1}.force(t));
                        end
                    end
                    clone.modelCps{a}.address = addr;
                end
            else
                addr = char(addresses.toString());
                target = me.m2d.parse(contents,addr);
                for t = 1 : 6
                    if(target{1}.dispDofs(t))
                        clone.modelCps{1}.command.setDispDof(t,target{1}.disp(t));
                    end
                    if(target{1}.forceDofs(t))
                        clone.modelCps{1}.command.setForceDof(t,target{1}.force(t));
                    end
                end
                clone.modelCps{1}.address = addr;
            end
        end
        function addProtocol(me,step)
            step.mdlLbcb = me.mdlLbcb;
            step.mdlUiSimCor = me.mdlUiSimCor;
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
        function resetTgtNumber(me)
            me.tgtNumber = 1;
        end
        function t = nextTgtNumber(me)
            t = me.tgtNumber;
            me.tgtNumber = t + 1;
        end
        
    end
end