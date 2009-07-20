classdef StepData < handle
    properties
        lbcbCps = {}; % Instances of LbcbControlPoint
        modelCps = {}; % Instances of model control points
        simstep = {}; % SimulationStep instance
        externalSensorsRaw = [];
        log = Logger;
        jid = {};
    end
    properties (Dependent)
        lbcb
    end
    methods
        function me = StepData(varargin)
            if(nargin > 0)
                for i = 1:2:nargin
                    if nargin==i, break, end
                    label = lower(varargin{i});
                    switch label
                        case 'simstep'
                            me.simstep = varargin{i+ 1};
                        case 'lbcb_tgts'
                            targets = varargin{i+ 1};
                            lgth = length(targets);
                            me.lbcbCps = cell(lgth,1);
                            for t = 1:lgth
                                me.lbcbCps{t} = LbcbControlPoint;
                                me.lbcbCps{t}.command = targets{t};
                            end
                        case 'istep'
                            istep = varargin{i+ 1};
                            me.lbcbCps = istep.lbcbCps;
                            me.modelCps = istep.modelCps;
                            me.simstep = istep.simstep;
                            me.externalSensorsRaw = istep.externalSensorsRaw;
                        otherwise
                            me.log.debug(dbstack,sprintf('%s not recognized',label));
                    end
                end
            end
        end
        function set.lbcbCps(me,value)
%             dbstack
%             lgth = length(value)
            me.lbcbCps = value;
        end
        function set.lbcb(me,value)
             dbstack
             me.log.error(dbstack,'lbcb has been renamed lbsb_cps'); 
        end
        function value = get.lbcb(me)
             dbstack
             me.log.error(dbstack,'lbcb has been renamed lbsb_cps'); 
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