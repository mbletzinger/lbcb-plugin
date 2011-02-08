classdef MultiDofStepPlot < handle
    properties
        plot = {};
        select
        dat
        isCummulative
        isLbcb1
        cdp
        ylabel
        dofL
        haveData
        buffer
    end
    methods
        function me = MultiDofStepPlot(name,selection, dat,ylabel,isLbcb1, isCummulative)
            me.select = selection;
            me.dat = dat;
            me.plot = TargetPlot(name,selection);
            me.isLbcb1 = isLbcb1;
            me.isCummulative = isCummulative;
            me.plot.figNum = 1 + (isLbcb1 == false);
            me.ylabel = ylabel;
            me.dofL = DofLabels;
            me.haveData = false;
        end
        function displayMe(me)
            me.plot.displayMe(me.plot.lbl{me.ylabel});
        end
        function undisplayMe(me)
            me.plot.undisplayMe();
        end
        function update(me,ignored) %#ok<INUSD>
            stepNum = me.dat.curStepData.stepNum;
            if me.isLbcb1
                data = me.curStepData.lbcbCps{1};
            elseif cdp.numLbcbs() == 2
                data = me.curStepData.lbcbCps{2};
            end
            cdata = me.curStepData.cData;
            if isempty(data)
                return;
            end
            update = zeros(length(me.select));
            for s = 1: length(me.select)
                lbl = me.select{s};
                datum = 0;
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
                for i = 1: length(update)
                    me.buffer(i,:) = cat(me.buffer(i,:),update(i));
                end
            else
                me.buffer = zeros(length(update),1);
                for i = 1: length(update)
                    me.buffer(i,1) = update(i);
                end
            end
            me.plot.update(me.cmdData,1);
            me.plot.update(me.corData,2);
            me.plot.update(me.tgtData,3);
            me.plot.update(me.rspData,4);
            me.plot.update(me.subData,5);
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
                ydix = -1;
                for i = 1:lt
                    if strcmp(lbl,cdata.labels{i})
                        yidx = i;
                        break;
                    end
                end 
                if yidx < 0
                    me.log.error(dbstack,sprintf('"%s" not found in arch data',me.ylabel));
                    datum = 0;
                    return;
                end
                datum = cdata.values(yidx);
        end
    end
end
