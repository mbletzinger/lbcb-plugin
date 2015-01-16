classdef OffsetsConfigActions < handle
    properties
        handles
        dofT
        offsetsT
        dset
        ocfg
        names
        simTimer
        offstRfsh
        dat
        sampleCount
        accum
        currentCount
    end
    methods
        function me = OffsetsConfigActions(offstcfg,cfg,fact)
            me.dset = OffsetsDataSet(offstcfg,cfg,fact);
            me.dset.load();
            me.ocfg = OmConfigDao(cfg);
            me.names = me.dset.getNames();
            me.offstRfsh = fact.offstRfsh;
            me.dat = fact.dat;
            me.simTimer = timer('Period',0.05, 'TasksToExecute',1000000,...
                'ExecutionMode','fixedSpacing','Name','Initial Position Timer');
            me.simTimer.TimerFcn = { 'OffsetsConfigActions.queryInitialPosition', me };
            me.dofT = zeros(2,6);
            me.offsetsT = cell(length(me.names),3);
            me.sampleCount = 10;
            me.resetSampling;
        end
        function resetSampling(me)
            me.accum = zeros(length(me.names),1);
            me.currentCount = 0;
        end
        function initialize(me,handles)
            me.handles = handles;
            set(me.handles.offsetsTable,'Data',me.offsetsT);
            format = {'char','numeric','numeric'};
            set(me.handles.offsetsTable,'ColumnFormat',format);
            set(me.handles.dofTable,'Data',me.dofT);
            format = {'numeric','numeric','numeric','numeric','numeric','numeric'};
            set(me.handles.dofTable,'ColumnFormat',format);
            set(me.handles.samplesCount,'String',sprintf('%d',me.sampleCount));
            me.refresh();
            
        end
        function refresh(me)
            me.names = me.dset.getNames();
            values = me.dset.getValues();
            me.offsetsT = cell(length(me.names),3);
            for s = 1:length(me.names)
                me.offsetsT{s,1} = me.names{s};
                me.offsetsT{s,2} = values(s);
                me.offsetsT{s,3} = 0;
            end
            me.resetSampling();
            set(me.handles.progressWindow,'String','Working...1');
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
            me.dset.set(me.names{indices(1)},data);
            me.refresh();
        end
        
        function setLengths(me)
            me.offsetsT(:,2) = me.offsetsT(:,3);
            for s = 1:length(me.names)
                me.dset.set(me.names{s},me.offsetsT{s,2});
            end
            me.dset.saveCfg();
            me.refresh();
        end
        
        function import(me)
            me.dset.import();
            me.refresh();
        end
        
        function export(me)
            me.dset.export();
        end
        function save(me)
            me.dset.save();
        end
        
        function reload(me)
            me.dset.load();
            me.refresh();
        end
        function setSampleCount(me, count)
            me.sampleCount = count;
        end
        function count = getSampleCount(me)
            count = me.sampleCount;
        end
    end
    methods (Static)
        function queryInitialPosition(obj, event,me) %#ok<*INUSL,*INUSD>
            if me.offstRfsh.isDone() == false
                return;
            end
            me.currentCount = me.currentCount+1;
            for lbcb = 1 : me.ocfg.numLbcbs
                for d = 1:6
                    me.dofT(lbcb,d) = me.dat.initialPosition.lbcbCps{lbcb}.response.disp(d);
                end
            end
            values = me.dat.initialPosition.externalSensorsRaw;
            for lbcb = 1 : me.ocfg.numLbcbs
                values = cat(1, values, me.dat.initialPosition.lbcbCps{lbcb}.response.lbcb.disp);
            end
            
            for s = 1:length(me.names)
                me.accum(s) = values(s) + me.accum(s);
                me.offsetsT{s,3} = me.accum(s) / me.currentCount;
            end
            set(me.handles.offsetsTable,'Data',me.offsetsT);
            set(me.handles.dofTable,'Data',me.dofT);
            guidata(me.handles.OffsetsConfig, me.handles);
            if(me.currentCount < me.sampleCount)
             set(me.handles.progressWindow,'String',sprintf('Working...%d',me.currentCount + 1));
               me.offstRfsh.start();
                return;
            end
            stop(me.simTimer);
            set(me.handles.progressWindow,'String','');
        end
    end
end
