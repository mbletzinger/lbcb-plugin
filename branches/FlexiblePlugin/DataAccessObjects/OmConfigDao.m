% =====================================================================================================================
% Class which manages the operations manager configuration data
%
% Members:
%   cfg - a Configuration instance
%   numLbcbs, sensorNames, apply2Lbcb are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef OmConfigDao < handle
    properties (Dependent = true)
        numLbcbs
        sensorNames
        apply2Lbcb
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = OmConfigDao(cfg)
            me.cfg = cfg;
        end
        function result = get.numLbcbs(me)
              result = me.cfg.props.getProperty('om.numLbcbs');
        end
        function set.numLbcbs(me,value)
              me.cfg.props.setProperty('om.numLbcbs',value);
        end
        function result = get.sensorNames(me)
              resultSL = me.cfg.props.getPropertyList('om.sensorNames');
              if isempty(resultSL)
                  result = [];
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.sensorNames(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('om.sensorNames',valS);
        end
        function result = get.apply2Lbcb(me)
              resultSL = me.cfg.props.getPropertyList('om.apply2Lbcb');
              if isempty(resultSL)
                  result = [];
                  return;
              end
              result = me.su.sl2ca(resultSL);
        end
        function set.apply2Lbcb(me,value)
            valS = me.su.ca2sl(value);
              me.cfg.props.setPropertyList('om.apply2Lbcb',valS);
        end
    end
end