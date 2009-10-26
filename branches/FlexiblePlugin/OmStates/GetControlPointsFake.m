classdef GetControlPointsFake < handle
    properties
        cfg = {};
        drvO = {};
        log = Logger;
    end
    methods
        function me = GetControlPointsFake(cfg)
            me.cfg = cfg;
            fcfg = FakeOmDao(cfg);
            me.drvO = StateEnum(fcfg.derivedOptions);
        end
        function generateControlPoints(me,istep)
            lgt = length(istep.lbcbCps); %#ok<*MCNPN> Until LINT understands object properties
            fcfg = FakeOmDao(me.cfg);
            error = me.calcConvergence(istep);
            for l = 1: lgt
                cp = istep.lbcbCps{l};
                if l ==1
                    scl = fcfg.scale1;
                    ofst = fcfg.offset1;
                    drv = fcfg.derived1;
                else
                    scl = fcfg.scale2;
                    ofst = fcfg.offset2;
                    drv = fcfg.derived2;
                end
                for d = 1:6
                    ddof = me.getDof(cp.command,drv(d));
                    fddof = me.getDof(cp.command,drv(d+ 6));
                    cp.response.lbcb.disp(d) = ddof * scl(d) + ofst(d) - error;
                    cp.response.lbcb.force(d) = fddof * scl(d + 6) + ofst(d + 6) - error;
                end
                cdp = ConfigDaoProvider(me.cfg);
                [ names s a] = cdp.getExtSensors();
                readings = zeros(length(names),1);
                for e = 1:length(names)
                    ddof = me.getDof(cp.command,drv(e));
                    readings(e) = ddof * scl(e) + ofst(e) - error;
                end
                istep.externalSensorsRaw = readings;
                istep.distributeExtSensorData(readings);
            end
%            me.log.debug(dbstack,sprintf('Generated fake response: %s',istep.toString));
        end
        function dof = getDof(me,cmd,drv)
            me.drvO.setState(drv);
            idx = me.drvO.idx;
            if idx > 6
                dof = cmd.force(idx - 6);
            else
                dof = cmd.disp(idx);
            end
        end
        function error = calcConvergence(me,istep)
            fcfg = FakeOmDao(me.cfg);
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