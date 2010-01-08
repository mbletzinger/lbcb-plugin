classdef SimSharedData < handle
    properties
        prevTarget = [];
        curTarget = [];
        correctionTarget = [];
        prevStepData = [];
        curStepData = [];
        nextStepData = [];
        sdf = [];
    end
    methods
        function stepShift(me)
            me.prevStepData = me.curStepData;
            me.curStepData = me.nextStepData;
        end
        function targetShift(me,target)
            me.prevTarget = me.curTarget;
            me.curTarget = target;
        end
        function clearSteps(me)
            me.correctionTarget = [];
            me.prevStepData = [];
            me.curStepData = [];
            me.nextStepData = [];
        end
        function table = cmdTable(me)
            steps = { me.curTarget, me.prevTarget, me.correctionTarget,  ...
                me.nextStepData,  me.curStepData, me.prevStepData};
            [ didx, fidx, labels ] = me.cmdTableHeaders();
            table = cell(6,length(labels));
            for s = 1 : 6
                if isempty(steps{s})
                    continue;
                end
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
            labels = {};
            if isempty(me.curTarget)
                return;
            end
            dofO = me.curTarget.lbcbCps{1}.response.lbcb; % for the label functions
            [ disp dDofs force fDofs] = me.curTarget.cmdData();
            idx = 1;
            for d = 1 : length(disp)
                if dDofs(d)
                    didx(idx) = d; %#ok<AGROW>
                    sd = d;
                    if d > 6
                        sd = d - 6;
                    end
                    labels{idx} = dofO.label(sd, d < 6); %#ok<AGROW>
                    idx = idx + 1;
                end
            end
            idxF = 1;
            for d = 1 : length(force)
                if fDofs(d)
                    fidx(idxF) = d; %#ok<AGROW>
                    sd = d;
                    if d > 6
                        sd = d - 6;
                    end
                    labels{idx} = dofO.label(sd + 6, d < 6); %#ok<AGROW>
                    idx = idx + 1;
                    idxF = idxF + 1;
                end
            end
        end
    end
end
