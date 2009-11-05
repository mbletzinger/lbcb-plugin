% =====================================================================================================================
% Class which manages the operations manager configuration data
%
% Members:
%   cfg - a Configuration instance
%   numControlPoints, addresses, apply2Lbcb are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef TargetConfigDao < handle
    properties
        dofL = {'dx' 'dy' 'dz' 'rx' 'ry' 'rz'};
    end
    properties (Dependent = true)
        numControlPoints
        apply2Lbcb
        addresses
        offsets
        xforms
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = TargetConfigDao(cfg)
            me.cfg = cfg;
        end
        function result = get.numControlPoints(me)
            str = char(me.cfg.props.getProperty('uisimcor.numControlPoints'));
            if isempty(str)
                result = 0;
                return;
            end
            result = sscanf(str,'%d');
        end
        function set.numControlPoints(me,value)
            me.cfg.props.setProperty('uisimcor.numControlPoints',sprintf('%d',value));
        end
        function result = get.apply2Lbcb(me)
            resultSL = me.cfg.props.getPropertyList('uisimcor.apply2Lbcb');
            if isempty(resultSL)
                result = cell(me.numControlPoints + 1,1);
                return;
            end
            result = me.su.sl2ca(resultSL);
        end
        function set.apply2Lbcb(me,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList('uisimcor.apply2Lbcb',valS);
        end
        function result = get.offsets(me)
            result = cell(me.numControlPoints + 1,1);
            for cp = 1: me.numControlPoints
                result{cp} = zeros(3,1);
                resultSL = me.cfg.props.getPropertyList(sprintf('uisimcor.offsets.cp%d',cp));
                if isempty(resultSL) == 0
                    result = me.su.sl2da(resultSL);
                end
            end
        end
        function set.offsets(me,value)
            for cp = 1: me.numControlPoints
                valS = me.su.da2sl(value{cp});
                me.cfg.props.setPropertyList(sprintf('uisimcor.offsets.cp%d',cp),valS);
            end
        end
        function result = get.xforms(me)
            result = cell(me.numControlPoints + 1,1);
            for cp = 1: me.numControlPoints
                rslt = eye(6);
                for d = 1:6
                    resultSL = me.cfg.props.getPropertyList(sprintf('uisimcor.xforms.cp%d.%s',cp,me.dofL{d}));
                    if isempty(resultSL) == 0
                        rslt(d,:) = me.su.sl2da(resultSL);
                    end
                end
                result{cp} = rslt;
            end
        end
        function set.xforms(me,value)
            for cp = 1: me.numControlPoints
                vl = value{cp};
                for d = 1:6
                    valS = me.su.da2sl(vl(d,:));
                    me.cfg.props.setPropertyList(sprintf('uisimcor.xforms.cp%d.%s',cp,me.dofL{d}),valS);
                end
            end
        end
        function result = get.addresses(me)
            resultSL = me.cfg.props.getPropertyList('uisimcor.addresses');
            if isempty(resultSL)
                result = cell(me.numControlPoints + 1,1);
                return;
            end
            result = me.su.sl2ca(resultSL);
        end
        function set.addresses(me,value)
            valS = me.su.ca2sl(value);
            me.cfg.props.setPropertyList('uisimcor.addresses',valS);
        end
    end
    methods (Static)
        function yes = hasLbcb2(cfg)
            ocfg = OmConfig(cfg);
            yes = ocfg.numControlPoints > 1;
        end
    end
end