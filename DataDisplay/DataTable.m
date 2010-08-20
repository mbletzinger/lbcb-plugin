classdef DataTable < DisplayControl
    properties
        name = '';
        table = [];
        steps = cell(3,1);
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        rnames = {'LBCB1 Command','LBCB1 Response',...
            'LBCB2 Command','LBCB2 Response','LBCB1 Readings','LBCB2 Readings'};
        data
        cdp
        log = Logger('DataTable');
    end
    methods
        function me = DataTable(name)
            me.name = name;
        end
        function displayMe(me)
            mnames = me.modelHeaders();
            me.fig = figure('Position',[100 100 1075 220], 'Name', me.name,'DeleteFcn',{'DataDisplay.checkOff',0 });
            me.table = uitable('ColumnName',me.cnames,'RowName',{ me.rnames{:} mnames{:} },...
                'Parent',me.fig,'Position',[5 5 1065 180],'ColumnFormat',repmat({'numeric'},1,length(me.cnames)));
            static1 = uicontrol('Style','text','Position',[5 195 50 18],'Parent',me.fig,'String','Step');
            me.steps{1} = uicontrol('Style','edit','Position',[60 195 50 18],'Parent',me.fig);
            static2 = uicontrol('Style','text','Position',[115 195 50 18],'Parent',me.fig,'String','Substep');
            me.steps{2} = uicontrol('Style','edit','Position',[170 195 50 18],'Parent',me.fig);
            static3 = uicontrol('Style','text','Position',[225 195 100 18],'Parent',me.fig,'String','Correction Step');
            me.steps{3} = uicontrol('Style','edit','Position',[330 195 50 18],'Parent',me.fig);
            me.isDisplayed = true;
            set(me.table,'Data',me.data);
        end
        function update(me,step)
            me.data = zeros(length(me.rnames),length(me.cnames));
            me.data(1,:) = [step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force'];
            me.data(2,:) = [ step.lbcbCps{1}.response.disp' step.lbcbCps{1}.response.force' ];
            me.data(5,:) = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            if length(step.lbcbCps) > 1
                me.data(3,:) = [ step.lbcbCps{2}.command.disp' step.lbcbCps{2}.command.force' ];
                me.data(4,:) = [ step.lbcbCps{2}.response.disp' step.lbcbCps{2}.response.force' ];
                me.data(6,:) = [ step.lbcbCps{2}.response.lbcb.disp' step.lbcbCps{2}.response.lbcb.force' ];
            end
            if me.cdp.numModelCps() > 0 && step.containsModelCps
                for m = 1 : me.cdp.numModelCps()
                   me.log.debug(dbstack,sprintf('Model: %s',step.modelCps{m}.toString()));
                    me.data((6 + (m * 2 - 1)),:) = [ step.modelCps{m}.command.disp', step.modelCps{m}.command.force'];
                    me.data((6 + (m * 2)),:) = [ step.modelCps{m}.response.disp', step.modelCps{m}.response.force'];
                end
            end
            if me.isDisplayed
                set(me.table,'Data',me.data);
                simstep = step.stepNum;
                set(me.steps{1},'String',sprintf('%d',simstep.step));
                set(me.steps{2},'String',sprintf('%d',simstep.subStep));
                set(me.steps{3},'String',sprintf('%d',simstep.correctionStep));
            end
        end
        function mnames = modelHeaders(me)
            if me.cdp.numModelCps() == 0
                mnames = {};
                return;
            end
            mnames = cell(me.cdp.numModelCps() * 2,1);
            addr = me.cdp.getAddresses();
            for m = 1 : me.cdp.numModelCps()
                mnames{m * 2 - 1 } = sprintf('%s Command',addr{m});
                mnames{m * 2 } = sprintf('%s Response',addr{m});
            end
            
        end
    end
end