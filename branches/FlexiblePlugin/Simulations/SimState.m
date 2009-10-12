classdef SimulationState < handle
    properties
        step = {};
        errors = '';
        state = StateEnum({ ...
            'BUSY', ...
            'READY', ...
            'ERRORS EXIST' ...
            });
        log = Logger;
    end
    methods (Static)
        %static MdlLbcb instance
        function ml = getMdlLbcb()
            global mdlLbcb;
            ml = mdlLbcb;
        end
        function setMdlLbcb(mlIn)
            global mdlLbcb;
            mdlLbcb = mlIn;
        end
        
        %static shared data instance
        function sd = getSd()
            global gsd;
            sd = gsd;
        end
        function setSd(sdin)
            global gsd;
            gsd = sdin;
        end
        
        % static configuration instance
        function cfg = getCfg()
            global ssCfg;
            cfg = ssCfg;
        end
        function setCfg(cfg)
            global ssCfg;
            ssCfg = cfg;
        end
        
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
    end
end