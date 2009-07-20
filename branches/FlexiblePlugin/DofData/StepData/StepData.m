classdef LbcbStep < handle
    properties
        lbcb = {}; % Number of LBCBs Instances of LbcbControlPoint
        simstep = {}; % SimulationStep instance
        externalSensorsRaw = [];
        log = Logger;
        jid = {};
    end
    methods
        function me = LbcbStep(varargin)
            if(nargin > 0)
                for i = 1:2:nargin
                    if nargin==i, break, end
                    label = lower(varargin{i});
                    switch label
                        case 'simstep'
                            me.simstep = varargin{i+ 1};
                        case 'targets'
                            targets = varargin{i+ 1};
                            lgth = length(targets);
                            me.lbcb = cell(lgth,1);
                            for t = 1:lgth
                                me.lbcb{t} = LbcbControlPoint;
                                me.lbcb{t}.command = targets{t};
                            end
                        case 'istep'
                            istep = varargin{i+ 1};
                            me.lbcb = istep.lbcb;
                            me.simstep = istep.simstep;
                            me.externalSensorsRaw = istep.externalSensorsRaw;
                        otherwise
                            me.log.debug(dbstack,sprintf('%s not recognized',label));
                    end
                end
            end
        end
        function set.lbcb(me,value)
%             dbstack
%             lgth = length(value)
            me.lbcb = value;
        end
        function me = clone(istep)
            me.simstep = istep.simstep;
            me.lbcb = istep.lbcb;
        end
        jmsg = generateProposeMsg(me)
        parseControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
    end
    methods (Static)
        ml = getMdlLbcb()
        setMdlLbcb(ml)
        [n s a] = getExtSensors()
        setConfig(cfg)
        a = getAddress()
    end
end