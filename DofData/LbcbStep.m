classdef LbcbStep < handle
    properties
        lbcb = {};
        simstep = {};
    end
    methods
        function me = LbcbStep(simstep, targets)
            me.simstep = simstep;
            lgth = length(targets);
            me.lbcb = cell(lgth,1);
            for t = 1:lgth
                me.lbcb{t} = LbcbControlPoint;
                me.lbcb{t}.command = targets{t};
            end
        end
        function jmsg = generateProposeMsg(me)
            lgth = length(me.command);
            mdl = cell(lgth,1);
            cps = cell(lgth,1);
            contents = cell(lgth,1);
            for t = 1:lgth
                mdl(t) = command(t).node;
                cps(t) = command(t).cps;
                contents(t) = command(t).createMsg();
            end
            jmsg = getMdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
        end
        function parseControlPointMsg(me,jmsg)
        end
    end
    methods (Static)
        function ml = getMdlLbcb(mlIn)
            persistent mdlLbcb;
            if isempty(mlIn)
                mdlLbcb = mlIn;
            end
            ml = mdlLbcb;
        end
    end
end