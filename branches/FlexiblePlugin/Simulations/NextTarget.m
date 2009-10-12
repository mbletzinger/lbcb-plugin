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
classdef NextTarget < SimulationState
    properties
         inpF = [];
        prevStepData = []
        curStepData = [];
        nextStepData = [];
        simCompleted = 0;
        doEdCalculations = 1;
        doEdCorrections = 1;
        doDerivedDofCorrections = 1;
    end
    methods
        function start(me)
            me.prevStepData = me.curStepData;
            me.curStepData = me.nextStepData;
        end
        function done = isDone(me)
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.curStepData) == 0
                % perform calculations
                me.edCalculate();
                me.derivedDofCalculate();
                if me.needsCorrection()
                    me.nextStepData = me.curStepData.clone();
                    me.nextStepData.simstep = me.curStepData.simstep.NextStep(1);
                    me.edAdjust();
                    me.derivedDofAdjust();
                else
                    % get next input step
                    me.nextStepData = me.inpF.next();
                    me.simCompleted = me.inpF.endOfFile;
                end
            else % This must be the first step
                me.nextStepData = me.inpF.next();
            end
            if isempty(me.prevStepData)
                me.log.debug(dbstack,'PrevStep=none');
            else
                me.log.debug(dbstack,sprintf('PrevStep=%s',me.prevStepData.toString()));
            end
            if isempty(me.curStepData)
                me.log.debug(dbstack,'CurStep=none');
            else
                me.log.debug(dbstack,sprintf('CurStep=%s',me.curStepData.toString()));
            end
            if isempty(me.nextStepData)
                me.log.debug(dbstack,'NextStep=none');
            else
                me.log.debug(dbstack,sprintf('NextStep=%s',me.nextStepData.toString()));
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
            cfg = SimulationState.getCfg();
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
            cfg = SimulationState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCalculations
                %calculate elastic deformations
                for l = 1: StepData.numLbcbs()
                    ed = NextTarget.getED(l == 1);
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
            cfg = SimulationState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCorrection
                for l = 1: StepData.numLbcbs()
                    ed = NextTarget.getED(l == 1);
                    ed.adjustTarget(me.nextStepData.lbcbCps{l});
                end
            end
        end
        function derivedDofCalculate(me)
            cfg = SimulationState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCalculations
                dd = NextTarget.getDD();  % Derived DOF instance
                dd.calculate(me.curStepData);
            end
        end
        function derivedDofAdjust(me)
            cfg = SimulationState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCorrection
                % get next derived dof step
                dd = NextTarget.getDD();  % Derived DOF instance
                dd.adjustTarget(me.nextStepData);
            else
            end
            
        end
    end
    methods (Static)
        % static DerivedDof instance
        function dd = getDD()
            global gdd;
            dd = gdd;
        end
        function setDD(dd)
            global gdd;
            gdd = dd;
        end
        % static ElasticDeformationCalculations instance
        function ed = getED(isLbcb1)
            global ged1;
            global ged2;
            if isLbcb1
                ed = ged1;
            else
                ed = ged2;
            end
        end
        function setED(ed,isLbcb1)
            global ged1;
            global ged2;
            if isLbcb1
                ged1 = ed;
            else
                ged2 = ed;
            end
        end
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
