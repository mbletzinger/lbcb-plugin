classdef OmExternalSensorList < handle
    properties
        list
        cfg
    end
    methods
        function me = OmExternalSensorList(cfg)
            ocfg = OmConfigDao(cfg);
            me.cfg = cfg;
            nm = ocfg.numExtSensors;
            if nm == 0
                return;
            end
            me.list = cell(nm,1);
            for s = 1:nm
                me.list{s} = OmExternalSensor(cfg,s);
            end
            me.refresh();
        end
        function setList(me)
            for s = 1: length(me.list)
                me.list{s}.idx = s;
                me.list{s}.setMe();
            end
            ocfg = OmConfigDao(me.cfg);
            ocfg.numExtSensors = length(me.list);
        end
        function refresh(me)
            ocfg = OmConfigDao(me.cfg);
            for s = 1:ocfg.numExtSensors
                me.list{s}.getMe();
            end
        end
        function idxO = insertSensor(me,idx)
            if isempty(me.list)
                idxO = 1;
                me.list = cell(1,1);
                me.list{idxO} = OmExternalSensor(me.cfg,idxO);
                me.setList();
                return;
            end
            nm = length(me.list);
            if idx > nm
                idxO = nm + 1;
                lst = cell(idxO,1);
                lst(1:nm) = me.list(1:nm);
                lst{idxO} = OmExternalSensor(me.cfg,idxO);
                me.list = lst;
                me.setList();
                return;
            end
            if idx == nm
                last = nm + 1;
                idxO = nm;
                lst = cell(last,1);
                lst(1:nm) = me.list(1:nm);
                lst(last) = me.list(nm);
                lst{idxO} = OmExternalSensor(me.cfg,idxO);
                me.list = lst;
                me.setList();
                return;
            end
            if idx == 1
                last = nm + 1;
                idxO = 1;
                lst = cell(last,1);
                lst(2:last) = me.list(1:nm);
                lst{idxO} = OmExternalSensor(me.cfg,idxO);
                me.list = lst;
                me.setList();
                return;
            end
            last = nm + 1;
            idxO = idx;
            lst = cell(last);
            lst(1:idx) = me.list(1:idx); % lst(idx) will be overriden
            lst(idx + 1:last) = me.list(idx:nm);
            lst{idxO} = OmExternalSensor(me.cfg,idxO);
            me.list = lst;
            me.setList();
        end
        function removeSensor(me,idx)
            ocfg = OmConfigDao(me.cfg);
            if isempty(me.list)
                return;
            end
            nm = length(me.list);
            if nm == 1
                me.list = {};
                ocfg.numExtSensors = 0;
                return;
            end
            if idx > nm
                return;
            end
            lst = cell(nm - 1,1);
            if idx == nm
                lst(1:nm -1 ) = me.list(1:nm - 1);
                me.list = lst;
                me.setList();
                return;
            end
            if idx == 1
                lst(1:nm - 1) = me.list(2:nm);
                me.list = lst;
                me.setList();
                return;
            end
            lst(1:idx - 1)= me.list(1:idx - 1);
            lst(idx:nm - 1)= me.list(idx + 1:nm);
            me.list = lst;
            me.setList();
        end
        function upSensor(me,idx)
            if isempty(me.list)
                return;
            end
            nm = length(me.list);
            if(idx <= 1)
                return;
            end
            lst = me.list;
            o = me.list{idx};
            p = me.list{idx - 1};
            p.idx = idx;
            lst{idx} = p;
            o.idx = idx - 1;
            lst{idx - 1} = o;
            me.list = lst;
            me.setList();
        end
        function downSensor(me,idx)
            if isempty(me.list)
                return;
            end
            nm = length(me.list);
            if(idx == nm)
                return;
            end
            lst = me.list;
            o = me.list{idx};
            p = me.list{idx + 1};
            p.idx = idx;
            lst{idx} = p;
            o.idx = idx + 1;
            lst{idx + 1} = o;
            me.list = lst;
            me.setList();
        end
        function str = toString(me)
            str = '';
            for s = 1: length(me.list)
                str = sprintf('%s%s\n',str,me.list{s}.toString());
            end
        end
    end
end