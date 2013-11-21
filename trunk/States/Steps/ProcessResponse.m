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
classdef ProcessResponse < Step
    properties
        log = Logger('ProcessResponse');
    end
    methods
        function me = ProcessResponse()
            me = me@Step();
        end
        function start(me)
            me.corrections.calculate(me.dat.prevStepData,...
                me.dat.curStepData,me.dat.correctionTarget);            
        end
        function done = isDone(me)
            me.statusReady();
            done = 1;
        end
    end
end
