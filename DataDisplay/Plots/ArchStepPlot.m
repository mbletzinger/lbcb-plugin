classdef ArchStepPlot < handle
    properties
        plot = {};
        measuredY = cell(8,1);
        measuredX = [];
        ylabel
        yidx
        archVariables = {};
        log
        dat
        cdp
        name
        noValues
    end
    methods
        function me = ArchStepPlot(name,archVariables,dat)
            me.plot = XyPlots(name,archVariables);
            me.plot.figNum = 1;
            me.archVariables = archVariables;
            me.yidx = -1*ones(1,length(archVariables));
            me.log = Logger('ArchStepPlot');
            me.noValues = false;
            me.dat = dat;
            me.name = name;
        end
        function displayMe(me)
                me.plot.displayMe('Step',me.name);
        end
        function undisplayMe(me)
                me.plot.undisplayMe();
        end
        function update(me,step)
            stepNum = me.dat.curStepData.stepNum;
            if stepNum.step == 0
                return; %initial position no commands
            end
            
            if isempty(step.cData.values) || me.noValues
                return;
            end
        
            for j = 1:length(me.archVariables)
                if me.yidx(j) < 0 
                    lt = length(step.cData.labels);
                    for i = 1:lt
                        if strcmp(me.archVariables{j},step.cData.labels{i})
                            me.yidx(j) = i;
                            break;
                        end
                    end
                    if me.yidx(j) < 0
                        me.log.error(dbstack,sprintf('"%s" not found in arch data',me.archVariables{j}));
                        me.noValues = true; %#ok<UNRCH>
                        return;
                    end
                end
            
                
                yd = step.cData.values(me.yidx(j));    

                if isempty(me.measuredY{j}) == false
                    me.measuredY{j} = cat(1, me.measuredY{j},yd);    
                else
                    me.measuredY{j} = yd;
                end

                me.measuredX = (1:length(me.measuredY{j}))';

                
                me.plot.update([me.measuredY{j}'; me.measuredX'],j);
            end
        end
    end
end
