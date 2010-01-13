classdef GetControlPointsFake < handle
    properties
        cdp = {};
        drvO = {};
        log = Logger('GetControlPointsFake');;
        dat
    end
    methods
        function me = GetControlPointsFake(cdp)
            me.cdp = cdp;
            fcfg = FakeOmDao(cdp.cfg); %#ok<*MCNPN>
            me.drvO = StateEnum(fcfg.derivedOptions);
        end
        function generateControlPoints(me)
            if me.dat.curStepData.needsCorrection
                me.generateCorrectiveCps();
            else
                me.generateSimpleCps();
            end
        end
        function generateSimpleCps(me)
            lgt = 12;
            if me.cdp.numLbcbs()  > 1
                lgt = 24;
            end
            fcfg = FakeOmDao(me.cdp.cfg);
            cmd = zeros(24,1);
            dofs = zeros(24,1);
            scl = zeros(24,1);
            ofst = zeros(24,1);
            drv = cell(24,1);
            if me.cdp.numLbcbs()  > 1
                [cmd(1:12) dofs(1:12) cmd(13:24) dofs(13:24) ] = me.dat.curStepData.cmdData();
                % reorganize data to reflect the fake parameters
                cmd = vertcat(cmd(1:6), cmd(13:18), cmd(7:12), cmd(19:24));
                dofs = vertcat(dofs(1:6), dofs(13:18), dofs(7:12), dofs(19:24));
            else
                [cmd(1:6) dofs(1:6) cmd(7:12) dofs(7:12) ] = me.dat.curStepData.cmdData();
            end
            scl(1:12) = fcfg.scale1;
            ofst(1:12) = fcfg.offset1;
            drv(1:12) = fcfg.derived1;
            if me.cdp.numLbcbs()  > 1
                scl(13:24) = fcfg.scale2;
                ofst(13:24) = fcfg.offset2;
                drv(13:24) = fcfg.derived2;
            end
            resp = zeros(24,1);
            for d = 1:lgt
                if dofs(d)
                    resp(d) = cmd(d);
                else
                    ddof = me.getDof(cmd,drv(d));
                    resp(d) = ddof * scl(d) + ofst(d);
                end
            end
            me.dat.curStepData.lbcbCps{1}.response.lbcb.disp = resp(1:6);
            me.dat.curStepData.lbcbCps{1}.response.lbcb.force = resp(7:12);
            if me.cdp.numLbcbs()  > 1
                me.dat.curStepData.lbcbCps{2}.response.lbcb.disp = resp(13:18);
                me.dat.curStepData.lbcbCps{2}.response.lbcb.force = resp(19:24);
            end
            [ names s a] = me.cdp.getExtSensors();
            readings = zeros(length(names),1);
            escl = fcfg.eScale;
            eofst = fcfg.eOffset;
            edrv = fcfg.eDerived;
            
            for e = 1:length(names)
                ddof = me.getDof(cmd,edrv(e));
                readings(e) = ddof * escl(e) + eofst(e);
            end
            me.dat.curStepData.externalSensorsRaw = readings;
            me.dat.curStepData.distributeExtSensorData(readings);
            %            me.log.debug(dbstack,sprintf('Generated fake response: %s',me.dat.curStepData.toString));
        end
        function generateCorrectiveCps(me)
            lgt = 12;
            if me.cdp.numLbcbs()  > 1
                lgt = 24;
            end
            fcfg = FakeOmDao(me.cdp.cfg);
            error = me.calcConvergence(me.dat.curStepData);
            
            cmd = zeros(24,1);
            dofs = zeros(24,1);
            scl = zeros(24,1);
            ofst = zeros(24,1);
            drv = cell(24,1);
            [cmd(1:12) dofs(1:12) cmd(13:24) dofs(13:24) ] = me.dat.correctionTarget.cmdData();
            % reorganize data to reflect the fake parameters
            cmd = vertcat(cmd(1:6), cmd(13:18), cmd(7:12), cmd(19:24));
            dofs = vertcat(dofs(1:6), dofs(13:18), dofs(7:12), dofs(19:24));
            scl(1:12) = fcfg.scale1;
            ofst(1:12) = fcfg.offset1;
            drv(1:12) = fcfg.derived1;
            if me.cdp.numLbcbs()  > 1
                scl(13:24) = fcfg.scale2;
                ofst(13:24) = fcfg.offset2;
                drv(13:24) = fcfg.derived2;
            end
            resp = zeros(24,1);
            for d = 1:lgt
                if dofs(d)
                    resp(d) = cmd(d) - error;
                else
                    ddof = me.getDof(cmd,drv(d));
                    resp(d) = ddof * scl(d) + ofst(d) - error;
                end
            end
            me.dat.curStepData.lbcbCps{1}.response.lbcb.disp = resp(1:6);
            me.dat.curStepData.lbcbCps{1}.response.lbcb.force = resp(7:12);
            if me.cdp.numLbcbs()  > 1
                me.dat.curStepData.lbcbCps{2}.response.lbcb.disp = resp(13:18);
                me.dat.curStepData.lbcbCps{2}.response.lbcb.force = resp(19:24);
            end
            [ names s a] = me.cdp.getExtSensors();
            readings = zeros(length(names),1);
            escl = fcfg.eScale;
            eofst = fcfg.eOffset;
            edrv = fcfg.eDerived;
            
            for e = 1:length(names)
                ddof = me.getDof(cmd,edrv(e));
                readings(e) = ddof * escl(e) + eofst(e) - error;
            end
            me.dat.curStepData.externalSensorsRaw = readings;
            me.dat.curStepData.distributeExtSensorData(readings);
            %            me.log.debug(dbstack,sprintf('Generated fake response: %s',istep.toString));
        end
        function dof = getDof(me,cmd,drv)
            me.drvO.setState(drv);
            idx = me.drvO.idx;
            dof = cmd(idx);
        end
        function error = calcConvergence(me,istep)
            fcfg = FakeOmDao(me.cdp.cfg);
            cstp = fcfg.convergeSteps;
            cinc = fcfg.convergeInc;
            stp = istep.stepNum.correctionStep;
            if stp >= cstp
                error = 0;
                return;
            end
            error = (cstp - stp) * cinc;
            me.log.debug(dbstack,sprintf('cstp=%d/cinc=%f/stp=%d/error=%f',cstp,cinc,stp,error));
        end
    end
end