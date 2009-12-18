% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%  steps - InputFile instance
%  curStep - The current LbcbStep
%  nextStep - The next LbcbStep as calculated by this class
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef NextStep < OmState
    properties
        steps = [];
        stepsCompleted = 0;
        st = [];
        log = Logger('NextStep');
        
    end
    methods
        function start(me)
            me.stepsCompleted = false;
        end
        function done = isDone(me)
            done = 1;
            me.statusReady();
            if me.steps.started == false
                me.dat.nextStepData = me.steps.next();
                me.dat.correctionTarget = me.dat.nextStepData;
                return;
            end
            if me.needsCorrection()
                me.dat.nextStepData = me.sdf.target2StepData({ me.dat.curStepData.lbcbCps{1}.command ...
                    me.dat.curStepData.lbcbCps{2}.command }, me.dat.curStepData.stepNum.step, ...
                    me.dat.curStepData.stepNum.subStep);
                me.dat.nextStepData.stepNum = me.dat.curStepData.stepNum.next(2);
                me.dat.nextStepData.needsCorrection = true;
                me.edAdjust();
                me.derivedDofAdjust();
                me.log.info(dbstack,'Generating correction step');
            else
                % get next input step
                me.dat.nextStepData = me.steps.next();
                me.dat.correctionTarget = me.dat.nextStepData;
                me.stepsCompleted = me.steps.endOfFile;
            end
        end
    end
    methods (Access='private')
        function needsCorrection = needsCorrection(me)
            needsCorrection = 0;
            if isempty(me.dat.curStepData)
                return;
            end
            if me.dat.curStepData.needsCorrection == false
                return;
            end
            wt1 = me.st{1}.withinTolerances(me.dat.correctionTarget.lbcbCps{1}.command,...
                me.dat.curStepData.lbcbCps{1}.response);
            wt2 = 1;
            if me.cdp.numLbcbs() == 2
                wt2 = me.st{2}.withinTolerances(me.dat.correctionTarget.lbcbCps{2}.command,...
                    me.dat.curStepData.lbcbCps{2}.response);
            end
            needsCorrection = (wt1 && wt2) == 0;
        end
        function edAdjust(me)
            scfg = StepConfigDao(me.cdp.cfg);
            if scfg.doEdCorrection
                for l = 1: me.cdp.numLbcbs()
                   me.ed{l}.adjustTarget(me.dat.nextStepData.lbcbCps{l});
                end
            end
        end
        function derivedDofAdjust(me)
            scfg = StepConfigDao(me.cdp.cfg);
            if scfg.doDdofCorrection
               me.dd.adjustTarget(me.dat.nextStepData);
            else
            end
            
        end
    end
end