% =====================================================================================================================
% Class which manages the network configuration data
%
% Members:
%   cfg - a Configuration instance
%   omHost, omPort, triggerPort, simcorPort, and timeout are all 
%   dependent properties whose values reside in a java properties object.
%
% $LastChangedDate: 2009-05-31 07:19:36 -0500 (Sun, 31 May 2009) $ 
% $Author: mbletzin $
% =====================================================================================================================
classdef NetworkConfigDao < handle
    properties (Dependent = true)
        omHost
        omPort
        triggerPort
        simcorPort
        timeout
        address
    end
    properties
        dt;
    end
    methods
        function me = NetworkConfigDao(cfg)
            me.dt = DataTypes(cfg);
        end
        function result = get.omHost(me)
            result = me.dt.getString('network.omHost','localhost');
        end
        function set.omHost(me,value)
            me.dt.setString('network.omHost',value);
        end
        function result = get.omPort(me)
            result = me.dt.getString('network.omPort','localhost');
        end
        function set.omPort(me,value)
            me.dt.setString('network.omPort',value);
        end
        function result = get.triggerPort(me)
            result = me.dt.getString('network.triggerPort','localhost');
        end
        function set.triggerPort(me,value)
            me.dt.setString('network.triggerPort',value);
        end
        function result = get.simcorPort(me)
            result = me.dt.getString('network.simcorPort','localhost');
        end
        function set.simcorPort(me,value)
            me.dt.setString('network.simcorPort',value);
        end
        function result = get.timeout(me)
            result = me.dt.getString('network.timeout','localhost');
        end
        function set.timeout(me,value)
            me.dt.setString('network.timeout',value);
        end
        function result = get.address(me)
            result = me.dt.getString('network.address','localhost');
        end
        function set.address(me,value)
            me.dt.setString('network.address',value);
        end
    end
end