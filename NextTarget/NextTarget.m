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
        curStep = [];
        nextStep = [];
    end
    methods
        function start(me)
            me.curStep = me.nextStep;
        end
        function done = isDone(me)
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.curStep) == 0 
                %calculate elastic deformations
                for l = 1: length(me.curStep.lbcb)
                    ed = NextTarget.getED(l-1);
                    ed.calculate(me.curStep.lbcb{l});
                end
                % check tolerances
                st = NextTarget.getST();
                if st.withinTolerances(me.curStep)
                    % get next input step
                    me.nextStep = me.inpF.next();
                else
                    % get next derived dof step
                    dd = NextTarget.getDD();
                    me.nextStep = dd.newStep(me.curStep);
                end
            else % This must be the first step
                me.nextStep = me.inpF.next();
            end
        end
        % needs to be called immediately after isDone returns true.
        function yes = withinLimits(me)
            lc = NextTarget.getLC();
            yes = lc.withinLimits(me.nextStep,me.curStep );
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
        function ed = getED(isLbcb2)
            global ged1;
            global ged2;
            if isLbcb2
                ed = ged2;
            else
                ed = ged1;
            end
        end
        function setED(ed,isLbcb2)
            global ged1;
            global ged2;
            if isLbcb2
                ged2 = ed;
            else
                ged1 = ed;
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