classdef LbcbStep < handle
    properties
        lbcb = {}; % Number of LBCBs Instances of LbcbControlPoint 
        simstep = {}; % SimulationStep instance 
        externalSensorRaw = [];
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
            jmsg = LbcbStep.getMdlLbcb.createCompoundCommand('propose',mdl,cps,contents);
        end
        function parseControlPointMsg(me,rsp)
           [address contents] = rsp.getContent();
           switch char(address,getSuffix())
               case 'LBCB1'
                   lbcbR = LbcbReading;
                   lbcbR.parse(contents,rsp,me.lbcb,command(1).node);
                   me.lbcb{1}.response = lbcbR;
               case 'LBCB2'
                   lbcbR = LbcbReading;
                   lbcbR.parse(contents,rsp,me.lbcb.command(1).node);
                   me.lbcb{2}.response = lbcbR;
               case 'ExternalSensors'
                   [n se a ] = LbcbStep.getExtSensors();
                   readings = ParseExternalTransducersMsg(n,contents);
                   me.externalSensorRaw = readings;
                   el1 = zeroes(length(n));
                   el1l = 1;
                   el2 = zeroes(length(n));
                   el2l = 1;
                   for s = 1:length(n)
                       r = readings(s) * se(s);
                       if strcmp(a(s),'LBCB1')
                           el1(el1l) = r;
                       else
                           el2(el2l) = r;
                       end
                   end
                   me.lbcb{1}.externalSensors = el1(1:el1l - 1);
                   me.lbcb{2}.externalSensors = el2(1:el2l - 1);
           end
        end
    end
    methods (Static)
        function ml = getMdlLbcb()
            global mdlLbcb;
            ml = mdlLbcb;
        end
        function setMdlLbcb(ml)
            global mdlLbcb;
            mdlLbcb = ml;
        end
        function [n s a] = getExtSensors()
            global names;
            global sensitivities;
            global applied;
            n = names;
            s = sensitivities;
            a = applied;
        end
        function setExtSensors(cfg)
            global names;
            global sensitivities;
            global applied;
            ocfg = OmConfigDao(cfg);
            names = ocfg.sensorNames;
            sensitivities = ocfg.sensitivities;
            applied = ocfg.apply2Lbcb;
        end
    end
end