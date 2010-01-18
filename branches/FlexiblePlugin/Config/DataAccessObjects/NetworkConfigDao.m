% =====================================================================================================================
% Class which manages the network configuration data
%
% Members:
%   cfg - a Configuration instance
%   omHost, omPort, triggerPort, simcorPort, and connectionTimeout are all 
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
        connectionTimeout
        msgTimeout
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
            result = me.dt.getInt('network.omPort',1000);
        end
        function set.omPort(me,value)
            me.dt.setInt('network.omPort',value);
        end
        function result = get.triggerPort(me)
            result = me.dt.getInt('network.triggerPort',1000);
        end
        function set.triggerPort(me,value)
            me.dt.setInt('network.triggerPort',value);
        end
        function result = get.simcorPort(me)
            result = me.dt.getInt('network.simcorPort',1000);
        end
        function set.simcorPort(me,value)
            me.dt.setInt('network.simcorPort',value);
        end
        function result = get.connectionTimeout(me)
            result = me.dt.getInt('network.connectionTimeout',3000);
        end
        function set.connectionTimeout(me,value)
            me.dt.setInt('network.connectionTimeout',value);
        end
        function result = get.msgTimeout(me)
            result = me.dt.getInt('network.msgTimeout',3000);
        end
        function set.msgTimeout(me,value)
            me.dt.setInt('network.msgTimeout',value);
        end
        function result = get.address(me)
            result = me.dt.getString('network.address','MDL-00-01');
        end
        function set.address(me,value)
            me.dt.setString('network.address',value);
        end
    end
end