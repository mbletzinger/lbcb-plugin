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
        simCompleted = 0;
        lc = [];
        st = [];
        
    end
    methods
        function start(me)
        end
        function done = isDone(me)
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.dat.curStepData) == 0
                if me.needsCorrection()
                    me.dat.nextStepData = me.sdf.clone(me.dat.curStepData);
                    me.dat.nextStepData.simstep = me.dat.curStepData.simstep.NextStep(2);
                    me.edAdjust();
                    me.derivedDofAdjust();
                else
                    % get next input step
                    me.dat.nextStepData = me.steps.next();
                    me.simCompleted = me.steps.endOfFile;
                end
            else % This must be the first step
                me.dat.nextStepData = me.steps.next();
            end
        end
        % needs to be called immediately after isDone returns true.
        function yes = withinLimits(me)
            yes = me.lc.withinLimits(me.dat.nextStepData,me.dat.curStepData );
        end
    end
    methods (Access='private')
        function needsCorrection = needsCorrection(me)
            needsCorrection = 0;
            ocfg = OmConfigDao(me.cfg);
            if ocfg.doEdCorrection == 0
                return;
            end
            wt1 = me.st{1}.withinTolerances(me.dat.correctionTarget.lbcbCps{1}.command,...
                me.dat.curStepData.lcbCps{1}.response);
            wt2 = 1;
            if me.numLbcbs() == 2
                wt2 = me.st{2}.withinTolerances(me.dat.correctionTarget.lbcbCps{2}.command,...
                    me.dat.curStepData.lcbCps{2}.response);
            end
            needsCorrection = wt1 && wt2 == 0;
        end
        function edAdjust(me)
            ocfg = OmConfigDao(me.cfg);
            if ocfg.doEdCorrection
                for l = 1: StepData.numLbcbs()
                    me.ed{l}.adjustTarget(me.dat.nextStepData.lbcbCps{l});
                end
            end
        end
        function derivedDofAdjust(me)
            ocfg = OmConfigDao(me.cfg);
            if ocfg.doDdofCorrection
                me.dd.adjustTarget(me.dat.nextStepData);
            else
            end
            
        end
    end
end