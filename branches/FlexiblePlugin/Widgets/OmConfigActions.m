classdef OmConfigActions < handle
    properties
        handles = [];
        table = cell(15,10);
        ocfg
        log = Logger
    end
    methods
        function me = OmConfigActions(cfg)
            aps = StateEnum({'LBCB1','LBCB2'});
            me.ocfg = OmConfigDao(cfg);
            names = me.ocfg.sensorNames; 
            apply = me.ocfg.apply2Lbcb;
            sens = me.ocfg.sensitivities;
            bx = me.ocfg.baseX;
            by = me.ocfg.baseY;
            bz = me.ocfg.baseZ;
            px = me.ocfg.platX;
            py = me.ocfg.platY;
            pz = me.ocfg.platZ;
            err = me.ocfg.sensorErrorTol;
            for s = 1:15
                me.table{s,1} = names{s};
                aps.setState(apply(s));
                me.table{s,2} = aps.idx;
                me.table{s,3} = sens(s);
                me.table{s,4} = bx(s);
                me.table{s,5} = by(s);
                me.table{s,6} = bz(s);
                me.table{s,7} = px(s);
                me.table{s,8} = py(s);
                me.table{s,9} = pz(s);
                me.table{s,10} = err(s);
            end
            
        end
        function setCell(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return;
            end
            me.table(indices(1),indices(2)) = data;
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.sensorTable,'Data',me.table);
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);
            set(me.handles.useFakeOm,'Value',me.ocfg.useFakeOm);
        end
        function setNumLbcbs(me,value)
            me.ocfg.numLbcbs = value;
        end
        function setUseFakeOm(me,value)
            me.ocfg.useFakeOm = value;
        end
    end
end