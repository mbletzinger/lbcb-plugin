classdef SimSharedData < handle
    properties
        prevStepTgt = [];
        curStepTgt = [];
        prevSubstepTgt = [];
        prev1SubstepTgt = [];
        curSubstepTgt = [];
        correctionTarget = [];
        prevStepData = [];
        curStepData = [];
        nextStepData = [];
        initialPosition = [];
        sdf = [];
        log = Logger('SimSharedData');
        lbls = {'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        cdp;
    end
    methods
        function stepShift(me)
            me.prevStepData = me.curStepData;
            me.curStepData = me.nextStepData;
        end
        function stepTgtShift(me,target)
            me.prevStepTgt = me.curStepTgt;
            me.curStepTgt = target;
        end
        function substepTgtShift(me,target)
            me.prev1SubstepTgt = me.prevSubstepTgt;
            me.prevSubstepTgt = me.curSubstepTgt;
            me.curSubstepTgt = target;
            cmd1 = target.lbcbCps{1}.command;
            cmd2 = [];
            if me.cdp.numLbcbs() > 1 
                cmd2 = target.lbcbCps{2}.command;
            end
            me.nextStepData = me.sdf.target2StepData({ cmd1, ...
                cmd2 }, target.stepNum.step,target.stepNum.subStep);
            me.setCorrectionTarget(target);
        end
                    
        function nextCorrectionStep(me,stype)
            cmd1 = me.curStepData.lbcbCps{1}.command;
            cmd2 = [];
            if me.cdp.numLbcbs() > 1
                cmd2 = me.curStepData.lbcbCps{2}.command;
            end
            me.nextStepData = me.sdf.target2StepData({ cmd1, ...
                cmd2 }, me.curStepData.stepNum.step, ...
                me.curStepData.stepNum.subStep);
            me.nextStepData.stepNum = me.curStepData.stepNum.next(stype);
            me.nextStepData.isLastSubstep = me.curStepData.isLastSubstep;
        end
        function step = curStepTgt2Step(me)
            cmd1 = me.curStepTgt.lbcbCps{1}.command;
            cmd2 = [];
            if me.cdp.numLbcbs() > 1
                cmd2 = me.curStepTgt.lbcbCps{2}.command;
            end
            step = me.sdf.target2StepData({ cmd1, ...
                cmd2 }, me.curStepTgt.stepNum.step,0);
        end
        function collectTargetResponse(me)
            me.curStepTgt.lbcbCps{1}.response = me.curStepData.lbcbCps{1}.response.clone();
            if me.cdp.numLbcbs() > 1
                me.curStepTgt.lbcbCps{2}.response = me.curStepData.lbcbCps{2}.response.clone();
            end
            me.curStepTgt.transformResponse();
        end
        function table = cmdTable(me)
            steps = { me.prevStepTgt, me.correctionTarget, me.curStepTgt, ...
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
               if cdofl1(d)
                   if d < 6
                       didx = concatL(didx,d);
                       l = sprintf('L1 %s',me.lbls{d});
                       dlabels = concatL(dlabels,l);
                   else
                       fidx = concatL(fidx,d - 6);
                       l = sprintf('L1 %s',me.lbls{d});
                       flabels = concatL(flabels,l);
                   end
               end
               if cdofl2(d)
                   if d < 6
                       didx = concatL(didx,d+6);
                       l = sprintf('L2 %s',me.lbls{d});
                       dlabels = concatL(dlabels,l);
                   else
                       fidx = concatL(fidx,d);
                       l = sprintf('L2 %s',me.lbls{d});
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
            me.curStepTgt = me.curStepData;
            me.curSubstepTgt = me.curStepData;
            me.prevStepData = me.curStepData;
            me.initialPosition = me.curStepData;
%             for l = 1: me.cdp.numLbcbs()
%                 lbcbCps = me.initialPosition.lbcbCps{l};
%                 lbcbCps.response.ed.disp = lbcbCps.command.disp;
%             end
        end
    end
end
