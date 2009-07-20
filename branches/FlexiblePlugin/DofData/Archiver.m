classdef Archiver < handle
    properties
        commandA = DataArchive('LbcbCommands');
        extSensA = DataArchive('ExternalSensors');
        lbcbReadA = DataArchive('LbcbReadings');
        edReadA = DataArchive('ElasticDefReadings');
    end
    methods
        function me = Archiver()
            me.commandA.headers = ...
                {'Step','LBCB1 Dx','LBCB1 Dy','LBCB1 Dz','LBCB1 Rx','LBCB1 Ry','LBCB1 Rz',...
                'LBCB1 Fx','LBCB1 Fy','LBCB1 Fz','LBCB1 Mx','LBCB1 My','LBCB1 Mz'...
                'LBCB1 Dx','LBCB1 Dy','LBCB1 Dz','LBCB1 Rx','LBCB1 Ry','LBCB1 Rz',...
                'LBCB1 Fx','LBCB1 Fy','LBCB1 Fz','LBCB1 Mx','LBCB1 My','LBCB1 Mz'};
            me.commandA.writeHeaders();
            me.lbcbReadA.headers = me.commandA.headers;
            me.lbcbReadA.writeHeaders();
            me.edReadA.headers = me.commandA.headers;
            me.edReadA.writeHeaders();
            [n se a] = StepData.getExtSensors();
            me.extSensA.headers = {'Step' n{:} };
            me.extSensA.writeHeaders();
        end
        function archive(me,step)
            values = [ step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.command.disp' step.lbcbCps{2}.command.force' ];
            end
            me.commandA.write(step.simstep.step2String(),values,'');

            values = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.lbcb.disp' step.lbcbCps{2}.response.lbcb.force' ];
            end
            me.lbcbReadA.write(step.simstep.step2String(),values,'');

            values = [ step.lbcbCps{1}.response.ed.disp' step.lbcbCps{1}.response.ed.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.ed.disp' step.lbcbCps{2}.response.ed.force' ];
            end
            me.lbcbReadA.write(step.simstep.step2String(),values,'');
            me.extSensA.write(step.simstep.step2String(),step.externalSensorsRaw,'');
        end
    end
end