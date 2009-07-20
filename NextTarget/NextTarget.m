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
        curStepData = [];
        nextStepData = [];
        simCompleted = 0;
    end
    properties (Dependent)
        curStep = []; % curStep to curStepData
        nextStep = []; % nextStep to nextStepData
    end
    methods
        function start(me)
            me.curStepData = me.nextStepData;
        end
        function done = isDone(me)
            done = 1;
            % Dumb MATLAB  double negative comparison to see if the current
            % step is not empty
            if isempty(me.curStepData) == 0 
                %calculate elastic deformations
                for l = 1: length(me.curStepData.lbcbCps)
                    ed = NextTarget.getED(l == 1);
                    ed.calculate(me.curStepData.lbcbCps{l});
                end
                % check tolerances
                st = NextTarget.getST();
                if st.withinTolerances(me.curStepData)
                    % get next input step
                    me.nextStepData = me.inpF.next();
                    me.simCompleted = me.inpF.endOfFile;
                else
                    % get next derived dof step
                    dd = NextTarget.getDD();  % Derived DOF instance 
                    me.nextStepData = dd.newStep(me.curStepData);
                end
            else % This must be the first step
                me.nextStepData = me.inpF.next();
            end
        end
        % needs to be called immediately after isDone returns true.
        function yes = withinLimits(me)
            lc = NextTarget.getLC();
            yes = lc.withinLimits(me.nextStepData,me.curStepData );
        end
    end
    methods
        function set.curStep(me,value)
             dbstack
             me.log.error(dbstack,'curStep has been renamed curStepData'); 
        end
        function value = get.curStep(me)
             dbstack
             me.log.error(dbstack,'curStep has been renamed curStepData'); 
        end
        function set.nextStep(me,value)
             dbstack
             me.log.error(dbstack,'nextStep has been renamed nextStepData'); 
        end
        function value = get.nextStep(me)
             dbstack
             me.log.error(dbstack,'nextStep has been renamed nextStepData'); 
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