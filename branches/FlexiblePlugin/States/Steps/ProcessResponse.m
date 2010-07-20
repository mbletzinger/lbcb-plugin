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
            me.edCalculate();
            me.derivedDofCalculate();
        end
        function done = isDone(me)
            me.statusReady();
            done = 1;
        end
    end
    methods (Access='private')
        function edCalculate(me)
                %calculate elastic deformations
                ccfg = StepCorrectionConfigDao(me.cdp.cfg);
                doC = ccfg.doCalculations;
                if isempty(doC) || doC(1) == false
                    return;
                end
                for l = 1: me.cdp.numLbcbs()
                    ccps = me.dat.curStepData.lbcbCps{l};
                    pcps = {};
                    if isempty(me.dat.prevStepData) == false
                        pcps = me.dat.prevStepData.lbcbCps{l};
                    end
                    me.ed{l}.calculate(ccps,pcps);
                    me.ed{l}.saveData(me.dat.curStepData);
                end
        end
        function derivedDofCalculate(me)
            for d = 1:4
                ccfg = StepCorrectionConfigDao(me.cdp.cfg);
                doC = ccfg.doCalculations;
                if isempty(doC) || doC(1 + d) == false
                    continue;
                end
                me.dd{d}.calculate(me.dat.curStepData);
                me.dd{d}.saveData(me.dat.curStepData);
            end
        end
    end
end