classdef OmConfigActions < handle
    properties
        handles = [];
        table = [];
    end
    methods
        function me = OmConfigActions(handles, cfg)
            ocfg = OmConfigDao(cfg);
            me.table = { ocfg.sensorNames(:); ocfg.apply2Lbcb(:);ocfg.sensitivities(:);...
                ocfg.baseX(:);ocfg.baseY(:);ocfg.baseZ(:);...
                ocfg.platX(:);ocfg.platY(:);ocfg.platZ(:);ocfg.sensorErrorTol(:) }';
            me.handles = handles;
            
        end
        function setCell(me,row,column,str)
        end
    end
end