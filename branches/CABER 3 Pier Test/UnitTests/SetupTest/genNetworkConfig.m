classdef genNetworkConfig < handle
    
    %UNTITLED2 Summary of this class goes here
    %Detailed explanation goes here
    
    properties
        needsLocalOm
        needsSimCor
        needsTrigger
    end
    
    methods
        
        function me = genNetworkConfig()
            me.needsLocalOm = false;
            me.needsSimCor = false;
            me.needsTrigger = false;
        end
        
        function generate(cfg)
            
            ncfg = NetworkConfigDao(cfg);
            
            if me.needsLocalOm
                ncfg.omhost = '127.0.0.1';
                ncfg.omport = 3400;
            end
            
            if me.needsSimCor
                ncfg.simcorPort = 6445;
            end
            
            if me.needsTrigger
               ncfg.triggerPort = 6445;
            end 
            
            ncfg.connectionTimeout = 4000;
            ncfg.msgTimeout = 40000;
            ncfg.address = 'MDL-00-01'; %Should this come under needsTrigger/needsSimCor?
            
        end
    end
end