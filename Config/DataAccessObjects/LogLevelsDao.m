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
        dt;
    end
    methods
        function me = LogLevelsDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.cmdLevel(me)
            result = me.dt.getString('logger.cmdLevel','ERROR');
        end
        function set.cmdLevel(me,value)
            me.dt.setString('logger.cmdLevel',value);
        end
        function result = get.msgLevel(me)
            result = me.dt.getString('logger.msgLevel','ERROR');
        end
        function set.msgLevel(me,value)
            me.dt.setString('logger.msgLevel',value);
        end
    end
end