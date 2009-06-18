classdef FakeOm < handle
    properties
        cfg = {};
        drvO = {};
    end
    methods
        function me = FakeOm(cfg)
            me.cfg = FakeOmDao(cfg);
            me.drvO = StateEnum(me.cfg.derivedOptions);
        end
        function ostep = generateControlPoints(istep)
            lgt = length(istep.lbcb); %#ok<*MCNPN> Until LINT understands object properties 
            ostep.lbcb  = cell(lgt,1);
            for l = 1: lgt
                cp = istep.lbcb{l};
                ncp.command = cp.command;
                ncp.response = LbcbReading;
                if l ==1
                    scl = me.cfg.scale1;
                    ofst = me.cfg.offset1;
                    drv = me.derived1;
                else
                    scl = me.cfg.scale2;
                    ofst = me.cfg.offset2;
                    drv = me.derived2;
                end
                for d = 1:6
                    ncp.response.lbcb.disp(d) = me.getDof(drv{d}) * scl(d) + ofst(d);
                    ncp.response.lbcb.force(d) = me.getDof(drv{d + 6}) * scl(d + 6) + ofst(d + 6);
                end
                ostep.lbcb{l} = ncp;
            end
            ostep.simstep = istep.simstep;
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