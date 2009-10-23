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
classdef ProcessResponse < SimState
    properties
    end
    methods
        function start(me)
            me.edCalculate();
            me.derivedDofCalculate();
        end
        function done = isDone(me)
            done = 1;
        end
    end
    methods (Access='private')
        function edCalculate(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doEdCalculations
                %calculate elastic deformations
                for l = 1: me.numLbcbs()
                    ccps = me.dat.curStepData.lbcbCps{l};
                    pcps = [];
                    if isempty(me.dat.prevStepData) == 0
                        pcps = me.dat.prevStepData.lbcbCps{l};
                    end                
                    me.ed{l}.calculate(ccps,pcps);
                end
            end
        end
        function derivedDofCalculate(me)
            cfg = SimState.getCfg();
            ocfg = OmConfigDao(cfg);
            if ocfg.doDdofCalculations
                me.dd.calculate(me.dat.curStepData);
            end
        end
    end
end