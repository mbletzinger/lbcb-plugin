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
classdef DerivedDofDao < handle
    properties (Dependent = true)
    kfactor
    Fztarget
    end
    properties
        cfg = Configuration();
        su = StringListUtils();
    end
    methods
        function me = DerivedDofDao(cfg)
            me.cfg = cfg;
        end
        function result = get.kfactor(me)
              str = char(me.cfg.props.getProperty('derivedDofs.kfactor'));
              if isempty(str)
                  result = 1;
                  return;
              end
              result = sscanf(str,'%f');
        end
        function set.kfactor(me,value)
              me.cfg.props.setProperty('derivedDofs.kfactor',sprintf('%f',value));
        end
        function result = get.Fztarget(me)
              str = char(me.cfg.props.getProperty('derivedDofs.Fztarget'));
              if isempty(str)
                  result = 1;
                  return;
              end
              result = sscanf(str,'%f');
        end
        function set.Fztarget(me,value)
              me.cfg.props.setProperty('derivedDofs.Fztarget',sprintf('%f',value));
        end
    end
end