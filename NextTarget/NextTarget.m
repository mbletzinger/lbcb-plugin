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
        function me = NextTarget(inpF)
            me.inpF = inpF;
        end
        function start(me)
        end
        function done = isDone(me)
            done = 1;
            %calculate elastic deformations
            for l = 1: length(me.curStep.lbcb)
                getED().calculate(me.curStep.lbcb{l});
            end
            % check tolerances
            if getST().withinTolerances(me.curStep)
                % get next input step
                me.nextStep = me.inpF.next();
            else
                % get next derived dof step
                me.nextStep = getDD().newStep(me.curStep);
            end
        end
    end
    methods (Static)
        % static DerivedDof instance
        function odd = getDD()
            persistent dd;
            if isempty(dd)
                dd = DerivedDof;
            end
            odd = dd;
        end
        % static ElasticDeformationCalculations instance
        function ed = getED(edIn)
            persistent ped;
            if isempty(edIn) == 0
                ped = edIn;
            end
            ed = ped;
        end
        % static StepTolerances  instance
        function st = getST(stIn)
            persistent pst;
            if isempty(stIn) == 0
                pst = stIn;
            end
            st = pst;
        end
    
    end
end