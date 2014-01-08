classdef SimSharedData < handle
    properties
        correctionTarget
        initialPosition
        sdf
        log = Logger('SimSharedData');
        lbls = {'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        cdp
        targetHist
        substepHist
        executeHist
        nextStepData
    end
    properties (Dependent = true)
        prevStepTgt
        curStepTgt
        prevSubstepTgt
        prev1SubstepTgt
        curSubstepTgt
        prevStepData
        curStepData
        
    end
    methods
        function me = SimSharedData()
            size = 20;
            me.targetHist = StepFifo(size);
            me.substepHist = StepFifo(size);
            me.executeHist = StepFifo(size);
        end
        function step = get.prevStepTgt(me)
            step = me.targetHist.get(2);
        end
        function step = get.curStepTgt(me)
            step = me.targetHist.get(1);
        end
        function step = get.prevSubstepTgt(me)
            step = me.substepHist.get(2);
        end
        function step = get.prev1SubstepTgt(me)
            step = me.substepHist.get(3);
        end
        function step = get.curSubstepTgt(me)
            step = me.substepHist.get(1);
        end
        function step = get.prevStepData(me)
            step = me.executeHist.get(2);
        end
        function step = get.curStepData(me)
            step = me.executeHist.get(1);
        end
        function stepShift(me)
            me.executeHist.push(me.nextStepData);
        end
        function stepTgtShift(me,target)
            me.targetHist.push(target);
        end
        function substepTgtShift(me,target)
            me.substepHist.push(target);
            me.nextStepData = me.sdf.stepData2StepData(target, -1); % need a clone here
            me.setCorrectionTarget(target);
        end
        
        function nextCorrectionStep(me,stype)
            me.nextStepData = me.sdf.stepData2StepData(me.curStepData, stype);
        end
        function step = curStepTgt2Step(me)
            step = me.sdf.stepData2StepData(me.curStepTgt, -1);
        end
        function collectTargetResponse(me)
            me.curStepTgt.lbcbCps{1}.response = me.curStepData.lbcbCps{1}.response.clone();
            if me.cdp.numLbcbs() > 1
                me.curStepTgt.lbcbCps{2}.response = me.curStepData.lbcbCps{2}.response.clone();
            end
            me.curStepTgt.loadCfg();
            me.curStepTgt.transformResponse();
        end
        function table = cmdTable(me)
            steps = {  me.curStepTgt, me.prevStepTgt, me.correctionTarget, ...
                me.nextStepData,  me.curStepData, me.prevStepData};
            [ didx, fidx, labels ] = me.cmdTableHeaders();
            table = cell(6,length(labels));
            for s = 1 : 6
                if isempty(steps{s})
                    continue;
                end
                %                me.log.debug(dbstack,sprintf('%s: %s',lbls{s},steps{s}.toString()));
                [ disp dDofs force fDofs] = steps{s}.cmdData(); %#ok<NASGU,ASGLU>
                for d = 1 : length(didx)
                    table{s,d} = disp(didx(d));
                end
                dEnd = length(didx);
                for d = 1 : length(fidx)
                    table{s,d + dEnd} = force(fidx(d));
                end
            end
        end
        function [ didx, fidx, labels ] = cmdTableHeaders(me)
            didx = [];
            fidx = [];
            dlabels = {};
            flabels = {};
            cdofcfg = ControlDofConfigDao(me.cdp.cfg);
            cdofl1 = cdofcfg.cDofL1;
            cdofl2 = cdofcfg.cDofL2;
            for dof= 1:12
                if cdofl1(dof)
                    if dof <= 6
                        didx = concatL(didx,dof);
                        l = sprintf('L1 %s',me.lbls{dof});
                        dlabels = concatL(dlabels,l);
                    else
                        fidx = concatL(fidx,dof - 6);
                        l = sprintf('L1 %s',me.lbls{dof});
                        flabels = concatL(flabels,l);
                    end
                end
                if cdofl2(dof)
                    if dof <= 6
                        didx = concatL(didx,dof+6);
                        l = sprintf('L2 %s',me.lbls{dof});
                        dlabels = concatL(dlabels,l);
                    else
                        fidx = concatL(fidx,dof);
                        l = sprintf('L2 %s',me.lbls{dof});
                        flabels = concatL(flabels,l);
                    end
                end
            end
            labels = concatL(dlabels,flabels);
        end
        function set.nextStepData(me,sd)
            me.nextStepData = sd;
        end
        function setCorrectionTarget(me,targetStep)
            cmd1 = targetStep.lbcbCps{1}.command;
            cmd2 = [];
            if me.cdp.numLbcbs() > 1
                cmd2 = targetStep.lbcbCps{2}.command;
            end
            me.correctionTarget = me.sdf.target2StepData({ cmd1, ...
                cmd2 }, targetStep.stepNum.step,targetStep.stepNum.subStep);
        end
        function initialPosition2Target(me)
            me.targetHist.push(me.curStepData);
            me.substepHist.push(me.curStepData);
            me.initialPosition = me.curStepData;
        end
    end
end
