% =====================================================================================================================
% Class containing the calculations for derived DOFs.
%
% Members:
%  inpF - InputFile instance
%  curStep - The current LbcbStep
%  nextStep - The next LbcbStep as calculated by this class
%
% $LastChangedDate: 2009-06-01 15:30:46 -0500 (Mon, 01 Jun 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef NextStep < SimState
    properties
        inpF = [];
        simCompleted = 0;
        doEdCorrections = 1;
        doDerivedDofCorrections = 1;
    end
    methods
        function start(me)
            dat = SimState.getSd();
            dat.prevStepData = dat.curStepData;
            dat.curStepData = dat.nextStepData;
        end
        function done = isDone(me)
            dat = SimState.getSd();
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.curStepData) == 0
                % perform calculations
                me.edCalculate();
                me.derivedDofCalculate();
                if me.needsCorrection()
                    dat.nextStepData = me.datStepData.clone();
                    dat.nextStepData.simstep = me.datStepData.simstep.NextStep(1);
                    me.edAdjust();
                    me.derivedDofAdjust();
                else
                    % get next input step
                    dat.nextStepData = me.inpF.next();
                    me.simCompleted = me.inpF.endOfFile;
                end
            else % This must be the first step
                dat.nextStepData = me.inpF.next();
            end
        end
        % needs to be called immediately after isDone returns true.
        function yes = withinLimits(me)
            lc = NextTarget.getLC();
            yes = lc.withinLimits(me.nextStepData,me.curStepData );
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
            st = NextTarget.getST();
            if st.withinTolerances(me.curStepData)
                needsCorrection = 1;
            end
        end
        function edCalculate(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCalculations
                %calculate elastic deformations
                for l = 1: StepData.numLbcbs()
                    ed = SimState.getED(l == 1);
                    ccps = me.curStepData.lbcbCps{l};
                    pcps = [];
                    if isempty(me.prevStepData) == 0
                        pcps = me.prevStepData.lbcbCps{l};
                    end                
                    ed.calculate(ccps,pcps);
                end
            end
        end
        function edAdjust(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCorrection
                for l = 1: StepData.numLbcbs()
                    ed = SimState.getED(l == 1);
                    ed.adjustTarget(me.nextStepData.lbcbCps{l});
                end
            end
        end
        function derivedDofCalculate(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCalculations
                dd = SimState.getDD();  % Derived DOF instance
                dd.calculate(me.curStepData);
            end
        end
        function derivedDofAdjust(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCorrection
                % get next derived dof step
                dd = SimState.getDD();  % Derived DOF instance
                dd.adjustTarget(me.nextStepData);
            else
            end
            
        end
    end
    methods (Static)
        % static StepTolerances  instance
        function st = getST()
            global gst;
            st = gst;
        end
        function setST(st)
            global gst;
            gst = st;
        end
        % static LimitChecks  instance
        function lc = getLC()
            global glc;
            lc = glc;
        end
        function setLC(lc)
            global glc;
            glc = lc;
        end
    
    end
end