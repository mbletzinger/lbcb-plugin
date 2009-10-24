% =====================================================================================================================
% Class which manages the logger configuration data
%
% Members:
%   cfg - a Configuration instance
%   cmdLevel, msgLevel, triggerPort, simcorPort, and timeout are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef LogLevelsDao < handle
    properties (Dependent = true)
        cmdLevel
        msgLevel
    end
    properties
        cfg = Configuration();
    end
    methods
        function me = LogLevelsDao(cfg)
            me.cfg = cfg;
        end
        function result = get.cmdLevel(me)
              result = char(me.cfg.props.getProperty('logger.cmdLevel'));
              if strcmp(result,'')
                  result = 'ERROR';
              end
        end
        function set.cmdLevel(me,value)
              me.cfg.props.setProperty('logger.cmdLevel',value);
        end
        function result = get.msgLevel(me)
              result = char(me.cfg.props.getProperty('logger.msgLevel'));
              if strcmp(result,'')
                  result = 'ERROR';
              end
        end
        function set.msgLevel(me,value)
              me.cfg.props.setProperty('logger.msgLevel',value)
        end
    end
end