classdef OmExternalSensor < handle
    properties
        cfg
        idx
        sensorName
        apply2Lbcb
        sensitivity
        base
        plat
        sensorErrorTol
    end
    methods
        function me = OmExternalSensor(cfg,idx)
            me.cfg = OmConfigDao(cfg);
            me.idx = idx;
            me.sensorName = ' ';
            me.apply2Lbcb = 'LBCB1';
            me.sensitivity = 1;
            me.base = zeros(3,1);
            me.plat = zeros(3,1);
            me.sensorErrorTol = 0;
            me.getMe();
        end
        function getMe(me)
            list = me.cfg.sensorNames;
            if length(list) < me.idx
                return;
            end
            me.sensorName = list{me.idx};
            list = me.cfg.apply2Lbcb;
            me.apply2Lbcb = list{me.idx};
            list = me.cfg.sensitivities;
            me.sensitivity = list(me.idx);
            list = me.cfg.base;
            me.base = list{me.idx};
            list = me.cfg.plat;
            me.plat = list{me.idx};
            list = me.cfg.sensorErrorTol;
            me.sensorErrorTol = list(me.idx);
        end
        function setMe(me)          
            list = me.cfg.sensorNames;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.sensorName;
            me.cfg.sensorNames = list;
            
            list = me.cfg.apply2Lbcb;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.apply2Lbcb;
            me.cfg.apply2Lbcb = list;
            
            list = me.cfg.sensitivities;
            if length(list) < me.idx
                lst = ones(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list(me.idx) = me.sensitivity;
            me.cfg.sensitivities = list;
            
            list = me.cfg.base;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.base;
            me.cfg.base = list;
            
            list = me.cfg.plat;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.plat;
            me.cfg.plat = list;
            
            list = me.cfg.sensorErrorTol;
            if length(list) < me.idx
                lst = zeros(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list(me.idx) = me.sensorErrorTol;
            me.cfg.sensorErrorTol = list;
        end
        function str = toString(me)
            str = sprintf('/name=%s/lbcb=%s/sens=%f', ...
                me.sensorName, me.apply2Lbcb, me.sensitivity);
            if isempty(me.base)
                str = sprintf('%s/base=[]',str);
            else
            str = sprintf('%s/base=[%f,%f,%f]', ...
                str,me.base(1), me.base(2), me.base(3));
            end
            if isempty(me.plat)
                str = sprintf('%s/lat=[]',str);
            else
            str = sprintf('%s/plat=[%f,%f,%f]', ...
                str,me.plat(1), me.plat(2), me.plat(3));
            end
            str = sprintf('%s/error=%f', str,me.sensorErrorTol);
        end
        function set.base(me,b)
            if iscell(b)
                disp ('setting base as a cell array')
            end
            me.base = b;
        end
        function set.sensorName(me,s)
            if iscell(s)
                disp ('setting sensorName as a cell array')
            end
            me.sensorName= s;
        end
        function set.apply2Lbcb(me,l)
            if iscell(l)
                disp ('setting apply2Lbcb as a cell array')
            end
            me.apply2Lbcb= l;
        end
    end
end