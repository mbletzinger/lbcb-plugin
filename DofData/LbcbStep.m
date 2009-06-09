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
            lgth = length(me.lbcb.command);
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
        function parseControlPointMsg(me,rsp)
           [address contents] = rsp.getContent();
           switch char(address,getSuffix())
               case 'LBCB1'
                   lbcb = LbcbReading;
                   lbcb.parse(contents,rsp,me.lbcb,command(1).node);
                   me.lbcb{1}.response = lbcb;
               case 'LBCB2'
                   lbcb = LbcbReading;
                   lbcb.parse(contents,rsp,me.lbcb.command(1).node);
                   me.lbcb{2}.response = lbcb;
               case 'ExternalSensors'
                   % FINISH THIS
           end
           me.readings{me.cpsMsg.idx} = lbcb;
        end
    end
    methods (Static)
        function ml = getMdlLbcb(mlIn)
            persistent mdlLbcb;
            if isempty(mlIn) == 0
                mdlLbcb = mlIn;
            end
            ml = mdlLbcb;
        end
    end
end