classdef Archiver < handle
    properties
        commandA;
        extSensA;
        lbcbReadA;
        edReadA;
        corDataA
        simCmdA
        simRespDataA
        archiveOn
        wroteCorDataHeaders
        notes
        stepHeaders
        cfg
    end
    methods
        function me = Archiver(cdp)
            me.cfg = cdp.cfg;
            me.commandA = DataArchive('LbcbCommands');
            me.extSensA = DataArchive('ExternalSensors');
            me.lbcbReadA = DataArchive('LbcbReadings');
            me.edReadA = DataArchive('ElasticDefReadings');
            me.corDataA = DataArchive('CorrectionData');
            me.simCmdA = DataArchive('ModelCommands');
            me.simRespDataA = DataArchive('ModelResponseData');
            me.notes = TextArchive('TestNotes');
            me.stepHeaders = {'Step','Substep','CorrectionStep'};
            me.archiveOn = true;
            hdrs = ...
                {me.stepHeaders{:},'LBCB1 Dx','LBCB1 Dy','LBCB1 Dz','LBCB1 Rx','LBCB1 Ry','LBCB1 Rz',...
                'LBCB1 Fx','LBCB1 Fy','LBCB1 Fz','LBCB1 Mx','LBCB1 My','LBCB1 Mz'};%#ok<*CCAT>
            mrhdrs = {'MDL1 Dx','MDL1 Dy','MDL1 Dz','MDL1 Rx','MDL1 Ry','MDL1 Rz',...
                'MDL1 Fx','MDL1 Fy','MDL1 Fz','MDL1 Mx','MDL1 My','MDL1 Mz'};
            mchdrs = {'MDL1 Dx','MDL1 Dy','MDL1 Dz','MDL1 Rx','MDL1 Ry','MDL1 Rz'};
            if cdp.numLbcbs() == 2
                hdrs = {hdrs{:}, 'LBCB2 Dx','LBCB2 Dy','LBCB2 Dz','LBCB2 Rx','LBCB1 Ry','LBCB2 Rz',...
                    'LBCB2 Fx','LBCB2 Fy','LBCB2 Fz','LBCB2 Mx','LBCB1 My','LBCB2 Mz'};
                mrhdrs = {mrhdrs{:}, 'MDL2 Dx','MDL2 Dy','MDL2 Dz','MDL2 Rx','MDL2 Ry','MDL2 Rz',...
                    'MDL2 Fx','MDL2 Fy','MDL2 Fz','MDL2 Mx','MDL2 My','MDL2 Mz'};
                mchdrs = {mchdrs{:}, 'MDL2 Dx','MDL2 Dy','MDL2 Dz','MDL2 Rx','MDL2 Ry','MDL2 Rz'};
            end
            me.commandA.headers = hdrs;
            me.lbcbReadA.headers = hdrs;
            me.edReadA.headers = hdrs;
            me.simCmdA.headers = mchdrs;
            me.simRespDataA.headers = mrhdrs;
            [n se a] = cdp.getExtSensors(); %#ok<ASGLU,NASGU>
            if isempty(n) == false
                me.extSensA.headers = {me.stepHeaders{:} n{:} }; %#ok<CCAT>
            end
            me.setCorDataHeaders();
        end
        function setArchiveOn(me,on)
            me.archiveOn = on;
            if on
                me.commandA.writeHeaders();
                me.lbcbReadA.writeHeaders();
                me.simCmdA.writeHeaders();
                me.simRespDataA.writeHeaders();
                me.edReadA.writeHeaders();
                me.extSensA.writeHeaders();
                me.corDataA.writeHeaders();
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
            me.commandA.write(step.stepNum.toString('noflags',1),values);
            
            values = [ step.lbcbCps{1}.response.lbcb.disp' step.lbcbCps{1}.response.lbcb.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.lbcb.disp' step.lbcbCps{2}.response.lbcb.force' ];
            end
            me.lbcbReadA.write(step.stepNum.toString('noflags',1),values);
            
            values = [ step.lbcbCps{1}.response.ed.disp' step.lbcbCps{1}.response.ed.force' ];
            if length(step.lbcbCps) > 1
                values = [ values step.lbcbCps{2}.response.ed.disp' step.lbcbCps{2}.response.ed.force' ];
            end
            me.edReadA.write(step.stepNum.toString('noflags',1),values);
            me.extSensA.write(step.stepNum.toString('noflags',1),step.externalSensorsRaw);
            if isempty(step.cData.values) == false
                me.corDataA.write(step.stepNum.toString('noflags',1),step.cData.values);
                me.setCorDataHeaders();
            end
        end
        function marchive(me, step)
            if me.archiveOn == false
                return;
            end
            values = step.modelCps{1}.command.disp';
            if length(step.lbcbCps) > 1
                values = [ values step.modelCps{2}.command.disp'];
            end
            me.simCmdA.write(step.stepNum.toString('noflags',1),values);
            
            values = [ step.modelCps{1}.response.disp step.modelCps{1}.response.force ];
            if length(step.lbcbCps) > 1
                values = [ values step.modelCps{2}.response.disp step.modelCps{2}.response.force ];
            end
            me.simRespDataA.write(step.stepNum.toString('noflags',1),values);
        end            
        function setCorDataHeaders(me)
            avarcfg = ArchiveVarsDao(me.cfg);
            if isempty(avarcfg.cfgLabels)
                return;
            end
            me.corDataA.headers = { me.stepHeaders{:} avarcfg.cfgLabels{:}};
        end
        function storeNote(me,nt,step)
            stp = '0    0   0';
            if isempty(step) == false
                stp = step.stepNum.toString('noflags',1);
            end
            me.notes.writeText(sprintf('%s\t%s',stp,nt));
        end
    end
end
