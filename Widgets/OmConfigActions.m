classdef OmConfigActions < handle
    properties
        handles = [];
        table = cell(15,10);
        ocfg
        log = Logger
        aps
    end
    methods
        function me = OmConfigActions(cfg)
            me.aps = StateEnum({'LBCB1','LBCB2'});
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
%                me.aps.setState(apply(s));
 %               me.table{s,2} = me.aps.idx;
                me.table{s,2} = apply{s};
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
            switch indices(2)
                case 1
                    names = me.ocfg.sensorNames;
                    names{indices(1)} = data;
                    me.ocfg.sensorNames = names;
                case 2
                    apply = me.ocfg.apply2Lbcb;
                    apply{indices(1)} = data;
                    me.ocfg.apply2Lbcb = apply;
                case 3
                    sens = me.ocfg.sensitivities;
                    sens(indices(1)) = data;
                    me.ocfg.sensitivities = sens;
                case 4
                    bx = me.ocfg.baseX;
                    bx(indices(1)) = data;
                    me.ocfg.baseX = bx;
                case 5
                    by = me.ocfg.baseY;
                    by(indices(1)) = data;
                    me.ocfg.baseY = by;
                case 6
                    bz = me.ocfg.baseZ;
                    bz(indices(1)) = data;
                    me.ocfg.baseZ = bz;
                case 7
                    px = me.ocfg.baseX;
                    px(indices(1)) = data;
                    me.ocfg.platX = px;
                case 8
                    py = me.ocfg.baseY;
                    py(indices(1)) = data;
                    me.ocfg.platY = py;
                case 9
                    pz = me.ocfg.baseZ;
                    pz(indices(1)) = data;
                    me.ocfg.platZ = pz;
                case 10
                    err = me.ocfg.sensorErrorTol;
                    err(indices(1)) = data;
                    me.ocfg.sensorErrorTol = err;
            end
        end
        function initialize(me,handles)
            me.handles = handles;
            format = {'char',{'LBCB1','LBCB2'},'numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.sensorTable,'Data',me.table);
             set(me.handles.numLbcbs,'String',{'1','2'});
            set(me.handles.numLbcbs,'Value',me.ocfg.numLbcbs);
            set(me.handles.sensorTable,'ColumnFormat',format);
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