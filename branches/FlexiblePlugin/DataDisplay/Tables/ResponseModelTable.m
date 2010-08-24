classdef ResponseModelTable < DisplayControl
% Needs to be finished
    
    properties
        name = '';
        table = [];
        steps = cell(3,1);
        cnames = { 'Dx','Dy','Dz','Rx','Ry','Rz','Fx','Fy','Fz','Mx','My','Mz'};
        data
        cdp
        log = Logger('DataTable');
        plot
    end
    methods
        function me = ResponseModelTable(name)
            me.name = name;
            if me.cdp.numLbcbs() == 2
                lt = length(me.cnames);
                cn = cell(lt * 2,1);
                for i = 1: lt
                    cn{i} = sprintf('L1 %s',me.cnames{i});
                    cn{i + lt} = sprintf('L2 %s',me.cnames{i});
                end
            else
                cn = me.cnames;
            end
            me.plot = DataTable(name,cn);
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