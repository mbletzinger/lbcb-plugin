classdef OmExternalSensor < handle
    properties
        cfg
        idx
        sensorName
        apply2Lbcb
        sensitivity
        fixedLocations
        pinLocations
        sensorErrorTol
        sensorLower
        sensorUpper
    end
    methods
        function me = OmExternalSensor(cfg,idx)
            me.cfg = OmConfigDao(cfg);
            me.idx = idx;
            me.sensorName = ' ';
            me.apply2Lbcb = 'LBCB1';
            me.sensitivity = 1;
            me.fixedLocations = zeros(3,1);
            me.pinLocations = zeros(3,1);
            me.sensorErrorTol = 0;
            me.sensorLower = -100;
            me.sensorUpper = 100;
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
            list = me.cfg.fixedLocations;
            me.fixedLocations = list{me.idx};
            list = me.cfg.pinLocations;
            me.pinLocations = list{me.idx};
            list = me.cfg.sensorErrorTol;
            me.sensorErrorTol = list(me.idx);
            list = me.cfg.sensorLower;
            me.sensorLower = list(me.idx);
            list = me.cfg.sensorUpper;
            me.sensorUpper = list(me.idx);
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
            
            list = me.cfg.fixedLocations;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.fixedLocations;
            me.cfg.fixedLocations = list;
            
            list = me.cfg.pinLocations;
            if length(list) < me.idx
                lst = cell(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list{me.idx} = me.pinLocations;
            me.cfg.pinLocations = list;
            
            list = me.cfg.sensorErrorTol;
            if length(list) < me.idx
                lst = zeros(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list(me.idx) = me.sensorErrorTol;
            me.cfg.sensorErrorTol = list;

            list = me.cfg.sensorLower;
            if length(list) < me.idx
                lst = zeros(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list(me.idx) = me.sensorLower;
            me.cfg.sensorLower = list;

            list = me.cfg.sensorUpper;
            if length(list) < me.idx
                lst = zeros(me.idx,1);
                lst(1:length(list)) = list(:);
                list = lst;
            end
            list(me.idx) = me.sensorUpper;
            me.cfg.sensorUpper = list;
end
        function str = toString(me)
            str = sprintf('/name=%s/lbcb=%s/sens=%9.7e', ...
                me.sensorName, me.apply2Lbcb, me.sensitivity);
            if isempty(me.fixedLocations)
                str = sprintf('%s/base=[]',str);
            else
            str = sprintf('%s/base=[%9.7e,%9.7e,%9.7e]', ...
                str,me.fixedLocations(1), me.fixedLocations(2), me.fixedLocations(3));
            end
            if isempty(me.pinLocations)
                str = sprintf('%s/lat=[]',str);
            else
            str = sprintf('%s/pinLocations=[%9.7e,%9.7e,%9.7e]', ...
                str,me.pinLocations(1), me.pinLocations(2), me.pinLocations(3));
            end
            str = sprintf('%s/error=%9.7e', str,me.sensorErrorTol);
            str = sprintf('%s/low=%9.7e', str,me.sensorLower);
            str = sprintf('%s/hi=%9.7e', str,me.sensorUpper);
        end
        function set.fixedLocations(me,b)
            if iscell(b)
                disp ('setting base as a cell array')
            end
            me.fixedLocations = b;
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