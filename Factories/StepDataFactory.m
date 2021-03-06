classdef StepDataFactory < handle
    properties
        mdlLbcb = [];
        mdlUiSimCor
        cdp = [];
        m2d = Msg2DofData();
        tgtNumber;
        log= Logger('StepDataFactory')
        offstcfg
        cv
    end
    methods
        function clone = createEmptyStepData(me,step,sub,cor)
            clone = StepData(me.cdp);
            stepNum = StepNumber(step,sub,cor);
            clone.stepNum = stepNum;
            me.addProtocol(clone);
        end
        function clone = stepNumber2StepData(me,stepNum)
            clone = StepData(me.cdp);
            clone.stepNum = stepNum.clone();
            me.addProtocol(clone);
        end
        function clone = stepData2StepData(me, step, cstype)
            clone = StepData(me.cdp);
            me.addProtocol(clone);
            if cstype < 0
                clone.stepNum = step.stepNum.clone();
            else
                clone.stepNum = step.stepNum.next(cstype);
            end
            lgth = me.cdp.numLbcbs();
            if lgth > 1
                clone.lbcbCps{1}.command = step.lbcbCps{1}.command.clone();
                clone.lbcbCps{2}.command = step.lbcbCps{2}.command.clone();
            else
                clone.lbcbCps{1}.command = step.lbcbCps{1}.command.clone();
            end
            
        end
        function clone = target2StepData(me,targets,step,sub)
            clone = StepData(me.cdp);
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
            clone = StepData(me.cdp);
            me.addProtocol(clone);
            clone.stepNum = StepNumber(me.nextTgtNumber(),0,0);
            [addresses, contents] = cmd.getContents();
            if iscell(addresses)
                if length(addresses) ~= me.cdp.numModelCps()
                    me.log.error(dbstack,...
                        sprintf('Number of control points set in Target Configuration is not equal to the targets that UI-SimCor is sending (%d)',...
                        length(addresses)));
                    return; %#ok<UNRCH>
                end
                for a = 1 : length(addresses)
                    addr = char(addresses{a}.toString());
                    target = me.m2d.parse(contents{a});
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
                if me.cdp.numModelCps() ~= 1
                    me.log.error(dbstack,...
                        sprintf('Number of control points set in Target Configuration is not equal to the targets that UI-SimCor is sending (%d)',...
                        length(addresses)));
                    return; %#ok<UNRCH>
                end
                target = me.m2d.parse(contents);
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
            step.offstcfg = me.offstcfg;
            lgth = me.cdp.numLbcbs();
            
            % Needs a better fix here
             step.cfgH = me.cv.cfgH;
             step.datH = me.cv.datH;
             step.archH = me.cv.archH;
            %
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
