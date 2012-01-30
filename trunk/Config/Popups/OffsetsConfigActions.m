classdef OffsetsConfigActions < handle
    properties
        handles
        dofT
        offsetsT
        offstcfg
        ocfg
        names
        simTimer
        offstRfsh
        dat
    end
    methods
        function me = OffsetsConfigActions(offstcfg,cfg,fact)
            me.offstcfg = offstcfg;
            me.ocfg = OmConfigDao(cfg);
            me.names = me.ocfg.sensorNames;
            me.offstRfsh = fact.offstRfsh;
            me.dat = fact.dat;
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,...
                'ExecutionMode','fixedSpacing','Name','Initial Position Timer');
            me.simTimer.TimerFcn = { 'OffsetsConfigActions.queryInitialPosition', me };
            me.dofT = zeros(2,6);
            me.offsetsT = cell(length(me.names),3);
        end
        function initialize(me,handles)
            me.handles = handles;
            for s = 1:length(me.names)
                of = me.offstcfg.getOffset(me.names{s});
                if of == 0.0
                    me.offstcfg.setOffset(me.names{s},0.0); % make sure there is an entry
                end
                me.offsetsT{s,1} = me.names{s};
                me.offsetsT{s,2} = of;
                me.offsetsT{s,3} = 0;
            end
            set(me.handles.offsetsTable,'Data',me.offsetsT);
            format = {'char','numeric','numeric'};
            set(me.handles.offsetsTable,'ColumnFormat',format);
            set(me.handles.dofTable,'Data',me.dofT);
            format = {'numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.dofTable,'ColumnFormat',format);
            me.refresh();
            
        end
        function refresh(me)
            me.offstRfsh.start();
            start(me.simTimer);
        end
        function editOffset(me,indices,data,errString)
            if isempty(data)
                me.log.error(dbstack,errString);
                return; %#ok<*UNRCH>
            end
            if indices(2) ~= 2
                me.log.error(dbstack,'You cannot edit this value');
                return;
            end
            me.offstcfg.setOffset(me.names{indices(1)},data);
            me.refresh();
        end
        
        function setLengths(me)
            me.offsetsT(:,2) = me.offsetsT(:,3);
            for s = 1:length(me.names)
                me.offstcfg.setOffset(me.names{s},me.offsetsT{s,2});
            end
            me.refresh();
        end
        
        function import(me)
            me.offstcfg.import();
            for s = 1:length(me.names)
                of = me.offstcfg.getOffset(me.names{s});
                if of == 0.0
                    me.offstcfg.setOffset(me.names{s},0.0); % make sure there is an entry
                end
                me.offsetsT{s,1} = me.names{s};
                me.offsetsT{s,2} = of;
                me.offsetsT{s,3} = 0;
            end
            me.refresh();
        end
        
        function export(me)
            me.offstcfg.export();
        end
        function save(me)
            me.offstcfg.save();
        end
        
        function reload(me)
            me.offstcfg.load();
            for s = 1:length(me.names)
                of = me.offstcfg.getOffset(me.names{s});
                if of == 0.0
                    me.offstcfg.setOffset(me.names{s},0.0); % make sure there is an entry
                end
                me.offsetsT{s,1} = me.names{s};
                me.offsetsT{s,2} = of;
                me.offsetsT{s,3} = 0;
            end
            me.refresh();
        end
        
    end
    methods (Static)
        function queryInitialPosition(obj, event,me) %#ok<*INUSL,*INUSD>
            if me.offstRfsh.isDone() == false
                return;
            end
            for lbcb = 1 : me.ocfg.numLbcbs
                for d = 1:6
                    me.dofT(lbcb,d) = me.dat.initialPosition.lbcbCps{lbcb}.response.disp(d);
                end
            end
            for s = 1:length(me.names)
                me.offsetsT{s,3} = me.dat.initialPosition.externalSensorsRaw(s);
            end
            set(me.handles.offsetsTable,'Data',me.offsetsT);
            set(me.handles.dofTable,'Data',me.dofT);
            guidata(me.handles.OffsetsConfig, me.handles);
            stop(me.simTimer);
        end
    end
end