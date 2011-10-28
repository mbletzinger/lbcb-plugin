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
        function initialize(me)
            offsets = me.offstcfg.offsets;
            if isempty(offsets)
                offsets = zeros(length(me.names),1);
                me.offstcfg.offsets = offsets;
            end
            if length(offsets) < length(me.names)
                ofs = zeros(length(me.names),1);
                ofs(1:length(offsets)) = offsets(:);
                me.offstcfg.offsets = offsets;
            end
            if length(offsets) > length(me.names)
                offsets = offsets(1:length(me.names));
                me.offstcfg.offsets = offsets;
            end
            for s = 1:length(me.names)
                me.offsetsT{s,1} = me.names{s};
                me.offsetsT{s,2} = offsets(s);
                me.offsetsT{s,3} = 0.0;
            end
            
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
            offsets = me.offstcfg.offsets;
            offsets(indices(1)) = data;
            me.offstcfg.offsets = offsets;
            me.refresh();
        end
        
        function setLengths(me)
            me.offsetsT{:,2} = me.offsetsT{:,3};
            me.refresh();
        end
        
        function import(me)
            me.offstcfg.import();
            me.refresh();
        end
        
        function export(me)
            me.offstcfg.export();
        end
        
        function reload(me)
            me.offstcfg.load();
            me.refresh();
        end
        
    end
    methods (Static)
        function queryInitialPosition(obj, event,me)
            if me.offstRfsh.isDone() == false
                return;
            end
            for l = 1: me.ocfg.numLbcbs
                for d = 1:6
                    me.dofT(l,d) = me.dat.initialPosition.lbcbCps{l}.disp(d);
                end
            end
            for s = 1:length(me.names)
                me.offsetsT{s,3} = me.dat.initialPosition.externalSensorsRaw(s);
            end
        end
    end
end