classdef LbcbDataTable < handle
    properties
        name = '';
        fig = [];
        table = [];
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        rnames = {'LBCB1 Command','LBCB1 Response',...
            'LBCB2 Command','LBCB2 Response','LBCB1 Readings','LBCB2 Readings'};
    end
    methods
        function me = LbcbDataTable(name)
            me.name = name;
            me.fig = figure('Position',[100 100 1080 150], 'Name', me.name,'DeleteFcn','DataDisplay.deleteDataTable');
            me.table = uitable('ColumnName',me.cnames,'RowName',me.rnames,...
                'Parent',me.fig,'Position',[5 5 1050 140],'ColumnFormat',repmat({'numeric'},1,length(me.cnames)));
        end
        function update(me,step)
            data = zeros(length(me.rnames),length(me.cnames));
            data(1,:) = [step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force'];
            data(2,:) = [ step.lbcbCps{1}.response.disp' step.lbcbCps{1}.response.force' ];
            data(5,:) = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            if length(step.lbcbCps) > 1
                data(3,:) = [ step.lbcbCps{2}.command.disp' step.lbcbCps{2}.command.force' ];
                data(4,:) = [ step.lbcbCps{2}.response.disp' step.lbcbCps{2}.response.force' ];
                data(6,:) = [ step.lbcbCps{2}.response.ed.disp' step.lbcbCps{2}.response.ed.force' ];
            end
            set(me.table,'Data',data);
        end
    end
end