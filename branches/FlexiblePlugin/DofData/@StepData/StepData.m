classdef StepData < handle
    properties
        lbcbCps = {}; % Instances of LbcbControlPoint
        modelCps = {}; % Instances of model control points
        simstep = {}; % SimulationStep instance
        externalSensorsRaw = [];
        dData = DerivedData;
        log = Logger;
        jid = {};
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
                            lgth = StepData.numLbcbs();
                            me.lbcbCps = cell(lgth,1);
                            for l = 1 : lgth
                                me.lbcbCps{l} = LbcbControlPoint;
                            end
                            lgth = length(targets);
                            for t = 1:lgth
                                me.lbcbCps{t}.command = targets{t};
                            end
                        otherwise
                            me.log.error(dbstack,sprintf('%s not recognized',label));
                    end
                end
            end
        end
        function clone = clone(me)
            clone = StepData;
            num = StepData.numLbcbs();
            clone.lbcb = cell(num,1);
            for l = 1: num
                clone.lbcb{l} = me.lbcb{l}.clone();
            end
            clone.externalSensorsRaw = me.externalSensorsRaw;
            clone.simstep = me.simstep;
        end
        str = toString(me)
        jmsg = generateProposeMsg(me)
        parseControlPointMsg(me,rsp)
        values = parseExternalSensorsMsg(me,names,msg)
        distributeExtSensorData(me,readings)
    end
    methods (Static)
        ml = getMdlLbcb()
        setMdlLbcb(ml)
        [n s a] = getExtSensors()
        num = numLbcbs()
        a = getAddress()
    end
end