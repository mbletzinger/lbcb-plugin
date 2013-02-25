classdef LoadProtocolPlot < DisplayControl
    properties
        loadP
        steps
        name
        par
        grp
        currentStep
        ylab
        start
        dat
        dof
        lbcb
        plot
        cdp
    end
    methods
        function me = LoadProtocolPlot(isLbcb1, dat, dof)
            me=me@DisplayControl();
            me.currentStep = 1;
            me.dat = dat;
            me.lbcb = 1 + (isLbcb1 == false);
            me.dof = dof;
            colorLabels = { 'r','b','g','k','c','m','y' };
            me.par = { 0, 0,sprintf('-%s',colorLabels{dof}), 0, 0,sprintf('d%s',colorLabels{dof}) };
            me.ylab = me.lbl{dof};
            me.name = sprintf('LBCB %d %s Load Protocol',me.lbcb, me.ylab);
            me.plot = me;
        end
        
        function setLoadP(me, steps,start)
            if me.lbcb > me.cdp.numLbcbs()
                return;
            end
            me.loadP = zeros(length(steps),1);
            me.steps = zeros(length(steps),1);
            for s = 1: length(steps)
                me.loadP(s) = steps{s}.lbcbCps{me.lbcb}.command.disp(me.dof);
                me.steps(s) = start + s - 1;
            end
            me.currentStep = start;
            me.start = start;
            if me.isDisplayed
                me.displayData();
            end
        end
        function displayMe(me)
            me.fig = figure('DeleteFcn',{'DisplayFactory.dispDeleted', me.name },...
                'Name',me.name,...
                'Position', [0 0 1000 200]...
                );
            ax = axes();
            hold on;
            xys = plot(ax,me.par{:});
            me.grp = hggroup;
            set(xys,'Parent',me.grp);
            hold off;
            xlabel('Step'); ylabel(me.ylab);
            set(ax, 'XGrid', 'on');
            set(ax, 'YGrid', 'on');
            set(ax,'YLimMode','auto');
            set(ax,'YLimMode','auto');
            set(ax,'XLimMode','auto');
            ls = get(me.grp,'Children');
            set(ls(1),'MarkerFaceColor','auto');
            set(ls(1),'MarkerSize',10);
            me.isDisplayed = true;
            me.displayData();
        end
        function update(me,ignored) %#ok<INUSD>
            stepNum = me.dat.curStepData.stepNum;
            if stepNum.step == 0
                return; %initial position no commands
            end
            me.currentStep = stepNum.step;
            if me.isDisplayed
                me.displayData();
            end
        end
    end
    methods (Access = private)
        function displayData(me)
            if length(me.loadP) > 1
                ls = get(me.grp,'Children');
                set(ls(2),'XData',me.steps,'YData',me.loadP);
                set(ls(1),'XData',me.currentStep,'YData',me.loadP(me.currentStep - (me.start - 1)));
            end
        end
    end
end