classdef genLogConfig < handle
    
    %UNTITLED2 Summary of this class goes here
    %Detailed explanation goes here
    
    properties
        %Should anything be included here for this class?
    end
    
    methods
        
        function me = genLogConfig()
            %depends if some properties are declared above
        end
        
        function generate(cfg)
            
            lcfg = LogLevelsDao(cfg);
            
            %Can I put the following two together here? Or should sth else
            %be done?
            lcfg.cmdLevel = 'DEBUG';
            lcfg.msgLevel = 'INFO';
            
            %You asked me not to play with these.
            Logger.setCmdLevel(lcfg.cmdLevel);
            Logger.setMsgLevel(lcfg.msgLevel);
            Logger.setMsgHandle([]);
        
        end
        
    end
    
end

