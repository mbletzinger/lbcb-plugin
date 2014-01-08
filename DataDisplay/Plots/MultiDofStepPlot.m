classdef MultiDofStepPlot < handle
    properties
        plot = {};
        select
        isCummulative
        isLbcb1
        cdp
        ylabel
        dofL
        haveData
        buffer
        log
    end
    methods
        function me = MultiDofStepPlot(name,selection,ylabel,isLbcb1, isCummulative)
            me.select = selection;
            me.plot = TargetPlot(name,selection);
            me.isLbcb1 = isLbcb1;
            me.isCummulative = isCummulative;
            me.plot.figNum = 1 + (isLbcb1 == false);
            me.ylabel = ylabel;
            me.dofL = DofLabels;
            me.haveData = false;
            me.log = Logger('MultiDofStepPlot');
            
        end
        function displayMe(me)
            me.plot.displayMe(me.ylabel);
        end
        function undisplayMe(me)
            me.plot.undisplayMe();
        end
        function update(me,step) %#ok<INUSD>
            if me.isLbcb1
                data = step.lbcbCps{1};
            elseif me.cdp.numLbcbs() == 2
                data = step.lbcbCps{2};
            end
            cdata = step.cData;
            if isempty(data)
                return;
            end
            update = zeros(length(me.select),1);
            for s = 1: length(me.select)
                lbl = me.select{s};
                if me.dofL.exists(lbl)
                    datum = me.getDof(data,lbl);
                else
                    datum = me.getArch(cdata,lbl);
                end
                if me.isCummulative && s > 1
                    datum = datum + update(s - 1);
                end
                update(s) = datum;
            end
            
            if(me.haveData)
                sz = size(me.buffer);
                tmp = zeros(sz(1),sz(2) + 1);
                tmp(:,1:sz(2)) = me.buffer;
                tmp(:,sz(2) + 1) = update;
                me.buffer = tmp;
                
            else
                me.buffer = zeros(length(update),1);
                for i = 1: length(update)
                    me.buffer(i,1) = update(i);
                end
                me.haveData = true;
            end
            for i = 1:length(update)
                me.plot.update(me.buffer(i,:),i);
            end
        end
        function datum = getDof(me, data, lbl)
            dof = me.dofL.get(lbl);
            if dof > 6
                datum = data.response.force(dof - 6);
            else
                datum = data.response.disp(dof);
            end
        end
        function datum = getArch(me, cdata, lbl)
            lt = length(cdata.labels);
            yidx = -1;
            for i = 1:lt
                if strcmp(lbl,cdata.labels{i})
                    yidx = i;
                    break;
                end
            end
            if yidx < 0
                datum = 0; %#ok<NASGU>
                me.log.error(dbstack,sprintf('"%s" not found in arch data',lbl));
                return; %#ok<UNRCH>
            end
            datum = cdata.values(yidx);
        end
    end
end
