classdef LbcbDataTable < DisplayControl
    properties
        name = '';
        table = [];
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        rnames = {'LBCB1 Command','LBCB1 Response',...
            'LBCB2 Command','LBCB2 Response','LBCB1 Readings','LBCB2 Readings'};
        data
    end
    methods
        function me = LbcbDataTable(name)
            me.name = name;
        end
        function displayMe(me)
            me.fig = figure('Position',[100 100 1080 150], 'Name', me.name,'DeleteFcn',{'DataDisplay.checkOff',0 });
            me.table = uitable('ColumnName',me.cnames,'RowName',me.rnames,...
                'Parent',me.fig,'Position',[5 5 1050 140],'ColumnFormat',repmat({'numeric'},1,length(me.cnames)));
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
                me.data(6,:) = [ step.lbcbCps{2}.response.ed.disp' step.lbcbCps{2}.response.ed.force' ];
            end
            if me.isDisplayed
                set(me.table,'Data',me.data);
            end
        end
    end
end