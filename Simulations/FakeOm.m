classdef FakeOm < handle
    properties
        cfg = {};
        drvO = {};
    end
    methods
        function me = FakeOm(cfg)
            me.cfg = cfg;
            fcfg = FakeOmDao(cfg);
            me.drvO = StateEnum(fcfg.derivedOptions);
        end
        function generateControlPoints(me,istep)
            lgt = length(istep.lbcb); %#ok<*MCNPN> Until LINT understands object properties
            fcfg = FakeOmDao(me.cfg);
            for l = 1: lgt
                cp = istep.lbcb{l};
                cp.response = LbcbReading;
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
                    cp.response.lbcb.disp(d) = ddof * scl(d) + ofst(d);
                    cp.response.lbcb.force(d) = fddof * scl(d + 6) + ofst(d + 6);
                end
                ocfg = OmConfigDao(me.cfg);
                names = ocfg.sensorNames;
                readings = zeros(15,1);
                for e = 1:15
                    if isempty(names{e})
                        break;
                    end
                    ddof = me.getDof(cp.command,drv(e));
                    readings(e) = ddof * scl(e) + ofst(e);
                end
                istep.distributeExtSensorData(readings);
            end
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
    end
end