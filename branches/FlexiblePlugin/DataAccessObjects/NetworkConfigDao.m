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
        cfg = Configuration();
    end
    methods
        function me = NetworkConfigDao(cfg)
            me.cfg = cfg;
        end
        function result = get.omHost(me)
              result = char(me.cfg.props.getProperty('network.omHost'));
        end
        function set.omHost(me,value)
              me.cfg.props.setProperty('network.omHost',value);
        end
        function result = get.omPort(me)
              result = char(me.cfg.props.getProperty('network.omPort'));
        end
        function set.omPort(me,value)
              me.cfg.props.setProperty('network.omPort',value);
        end
        function result = get.triggerPort(me)
              result = char(me.cfg.props.getProperty('network.triggerPort'));
        end
        function set.triggerPort(me,value)
              me.cfg.props.setProperty('network.triggerPort',value);
        end
        function result = get.simcorPort(me)
              result = char(me.cfg.props.getProperty('network.simcorPort'));
        end
        function set.simcorPort(me,value)
              me.cfg.props.setProperty('network.simcorPort',value);
        end
        function result = get.timeout(me)
              result = char(me.cfg.props.getProperty('network.timeout'));
        end
        function set.timeout(me,value)
              me.cfg.props.setProperty('network.timeout',value);
        end
        function result = get.address(me)
              result = char(me.cfg.props.getProperty('network.address'));
        end
        function set.address(me,value)
              me.cfg.props.setProperty('network.address',value);
        end
    end
end