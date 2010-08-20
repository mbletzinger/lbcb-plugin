classdef Archiver < handle
    properties
        commandA;
        extSensA;
        lbcbReadA;
        edReadA;
        corDataA
        archiveOn
        wroteCorDataHeaders
    end
    methods
        function me = Archiver(cdp)
            me.commandA = DataArchive('LbcbCommands');
            me.extSensA = DataArchive('ExternalSensors');
            me.lbcbReadA = DataArchive('LbcbReadings');
            me.edReadA = DataArchive('ElasticDefReadings');
            me.corDataA = DataArchive('CorrectionData');
            me.archiveOn = false;
            me.commandA.headers = ...
                {'Step','LBCB1 Dx','LBCB1 Dy','LBCB1 Dz','LBCB1 Rx','LBCB1 Ry','LBCB1 Rz',...
                'LBCB1 Fx','LBCB1 Fy','LBCB1 Fz','LBCB1 Mx','LBCB1 My','LBCB1 Mz'...
                'LBCB2 Dx','LBCB2 Dy','LBCB2 Dz','LBCB2 Rx','LBCB1 Ry','LBCB2 Rz',...
                'LBCB2 Fx','LBCB2 Fy','LBCB2 Fz','LBCB2 Mx','LBCB1 My','LBCB2 Mz'};
            me.lbcbReadA.headers = me.commandA.headers;
            me.edReadA.headers = me.commandA.headers;
            [n se a] = cdp.getExtSensors(); %#ok<NASGU,MCNPN>
            me.extSensA.headers = {'Step' n{:} };
            me.wroteCorDataHeaders = false;
        end
        function setArchiveOn(me,on)
            me.archiveOn = on;
            if on
                me.commandA.writeHeaders();
                me.lbcbReadA.writeHeaders();
                me.edReadA.writeHeaders();
                me.extSensA.writeHeaders();
            end
        end
        function archive(me,step)
            if me.archiveOn == false
                return;
            end
            values = [ step.lbcbCps{1}.command.disp' step.lbcbCps{1}.command.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.command.disp' step.lbcbCps{2}.command.force' ];
            end
            me.commandA.write(step.stepNum.toString(),values,'');
            
            values = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.lbcb.disp' step.lbcbCps{2}.response.lbcb.force' ];
            end
            me.lbcbReadA.write(step.stepNum.toString(),values,'');
            
            values = [ step.lbcbCps{1}.response.ed.disp' step.lbcbCps{1}.response.ed.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.ed.disp' step.lbcbCps{2}.response.ed.force' ];
            end
            me.edReadA.write(step.stepNum.toString(),values,'');
            me.extSensA.write(step.stepNum.toString(),step.externalSensorsRaw,'');
            if isempty(step.cData.values) == false
                me.corDataA.write(step.stepNum.toString(),step.cData.values,'');
                me.setCorDataHeaders(step);
            end
        end
        function setCorDataHeaders(me,step)
            if me.wroteCorDataHeaders
                return;
            end
            me.corDataA.headers = step.cData.labels;
            me.corDataA.writeHeaders();
            me.wroteCorDataHeaders = true;
        end
    end
end