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
classdef NextStep < SimState
    properties
        steps = [];
        simCompleted = 0;
        lc = [];
        st = [];
    end
    methods
        function start(me)
            me.dat.prevStepData = me.dat.curStepData;
            me.dat.curStepData = me.dat.nextStepData;
        end
        function done = isDone(me)
            dat = SimState.getSd();
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.dat.curStepData) == 0
                if me.needsCorrection()
                    me.dat.nextStepData = me.datStepData.clone();
                    me.dat.nextStepData.simstep = me.datStepData.simstep.NextStep(1);
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
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCorrection == 0
                return;
            end
            if me.st.withinTolerances(me.dat.curStepData)
                needsCorrection = 1;
            end
        end
        function edAdjust(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCorrection
                for l = 1: StepData.numLbcbs()
                    me.ed{l}.adjustTarget(me.dat.nextStepData.lbcbCps{l});
                end
            end
        end
        function derivedDofAdjust(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCorrection
                me.dd.adjustTarget(me.dat.nextStepData);
            else
            end
            
        end
    end
end